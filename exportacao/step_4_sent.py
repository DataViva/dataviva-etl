# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_4_sent -m all
    If need to run just a specific check, run: python -m exportacao.step_4_sent -m HS
    
    Running one by one:
    
    python -m exportacao.step_4_sent -m all -y all > step_4_sent.log
    python -m exportacao.step_4_sent -m HS -y all > HS.log
    python -m exportacao.step_4_sent -m Municipality -y all > Municipality.log 
    python -m exportacao.step_4_sent -m State -y all > State.log 
    python -m exportacao.step_4_sent -m WLD -y all > WLD.log     
    
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR
from helpers import d, get_file, format_runtime,find_in_df,sql_to_df,read_from_csv
import pandas as pd
from pandas import DataFrame
import pandas.io.sql as psql

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=environ["DATAVIVA_DB_USER"], 
                        passwd=environ["DATAVIVA_DB_PW"], 
                        db=environ["DATAVIVA_DB_NAME"])
db.autocommit(1)
cursor = db.cursor()

def to_int(s):
    if s is None:
        return False
    try: 
        ret=int(s)
        return ret
    except ValueError:
        return False

def checkHS(year):
    print "Entering in checkHS" 

    dfDV = sql_to_df("SELECT s.hs_id as id,sum(val_usd) as val FROM secex_yp s where length(s.hs_id)=6 and year="+str(year)+" group by 1;",db)

    dfSent = read_from_csv("dados\exportacao\sent\MDIC_"+str(year)+".csv",delimiter="|")
    dfGroup = dfSent.groupby(dfSent.columns[10])

    
    for hs in dfDV['id']:
        hsid= str(hs).zfill(6)   
        hsshort=hsid[2:6]
        hsint=to_int(hsshort)
        if not hsint: #not isinstance(hs,int):
            continue

        valDV = dfDV[(dfDV['id']==hsid)]['val'].values[0]
        try: 
            valCSV= dfGroup.get_group(hsint)[dfSent.columns[9]].sum()
        except:
            print "Not found in CSV a value for "+str(hsint)+" / "+str(hsshort)+" - Exports of value  "+ str(valDV)+ " in the year "+str(year)
            continue
         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        if valDV!=valCSV:
            txt= "ERROR in HS ("+str(year)+"): "+str(hsint)+" / "+str(hs)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(valCSV - valDV)
            print txt
        else:
            txt="OK"
            #print txt
   
def checkMunicipality(year,size,column):
    print "Entering in checkBRA" 

    dfDV = sql_to_df("SELECT a.id_mdic as id,sum(val_usd) as val FROM secex_yb s,attrs_bra a where length(a.id)="+str(size)+" and  a.id=s.bra_id and year="+str(year)+" group by 1;",db)

    dfSent = read_from_csv("dados\exportacao\sent\MDIC_"+str(year)+".csv",delimiter="|")
    dfGroup = dfSent.groupby(dfSent.columns[column])

    
    for mdic in dfDV['id']:        
        mdicid=to_int(mdic)
        if not mdicid: #not isinstance(hs,int):
            continue
        
        valDV = dfDV[(dfDV['id']==mdicid)]['val'].values[0]
        try: 
            valCSV= dfGroup.get_group(mdicid)[dfSent.columns[9]].sum()
        except:
            print "Not found in CSV a value for "+str(mdic)+" - Exports of value  "+ str(valDV)+ " in the year "+str(year)
            continue
         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        if valDV!=valCSV:
            txt= "ERROR in BRA ("+str(year)+"): "+str(mdic)+" / "+str(mdicid)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(valCSV - valDV)
            print txt
        else:
            txt="OK"
   
def checkWLD(year):
    print "Entering in checkWLD" 

    dfDV = sql_to_df("SELECT a.id_mdic as id,sum(val_usd) as val FROM secex_yw s,attrs_wld a where length(a.id)=5 and  a.id=s.wld_id and year="+str(year)+" group by 1;",db)

    dfSent = read_from_csv("dados\exportacao\sent\MDIC_"+str(year)+".csv",delimiter="|")
    dfGroup = dfSent.groupby(dfSent.columns[2])

    for mdic in dfDV['id']:        
        mdicid=to_int(mdic)
        if not mdicid: #not isinstance(hs,int):
            continue
        
        valDV = dfDV[(dfDV['id']==mdicid)]['val'].values[0]
        try: 
            valCSV= dfGroup.get_group(mdic)[dfSent.columns[9]].sum()
            if valCSV==False or valCSV is None:
                print "ALOOOO"+valCSV
        except:
            print "Not found in CSV a value for "+str(mdic)+" - Exports of value  "+ str(valDV)+ " in the year "+str(year)
            continue
         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        if valDV!=valCSV:
            txt= "ERROR in WLD ("+str(year)+"): "+str(mdic)+" / "+str(mdicid)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(valCSV - valDV)
            print txt
        else:
            txt="OK"
   
        
            
    
   
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: HS , Municipality , State , WLD',required=False)
@click.option('-y', '--year', prompt='Year', help='chosse a year to run : 2000 to 2014 or all',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method,year):
    if not year:
        year=2000
        
    elif year=='all':
        for y in (2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013):
            runMethodYear(method,y)
            
        return
    
    runMethodYear(method,year)    
        
        
       

def runMethodYear(method,year):
    if not method or method=='all':
        checkHS(year)
        checkWLD(year)
        checkMunicipality(year,8,5) 
        checkMunicipality(year,2,3) 
    elif method=="HS":
        checkHS(year)     
    elif method=="Municipality":
        checkMunicipality(year,8,5) 
    elif method=="State":
        checkMunicipality(year,2,3)
    elif method=="WLD":
        checkWLD(year)  
                                                
if __name__ == "__main__":
    start = time.time()
    
    total_error=0
    msg_error=[]
    
    main()
    
    print; print;
    print "---------------------------"
    print "SUMMARY"
    print "---------------------------"
    print "Total erros found: "+str(total_error)
    print "Erros messages:"
    print     msg_error
    
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;