# -*- coding: utf-8 -*-
"""
    Check all data in rais tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_4_sent -m all
    If need to run just a specific check, run: python -m emprego.step_4_sent -m ISIC
    
    
    Running a method for a yer:
    python -m emprego.step_4_sent -m ISIC -y 2012 > ISIC.log
    
    
    Running one by one for all years:
    
    python -m emprego.step_4_sent -m all -y all > step_4_sent.log
    python -m emprego.step_4_sent -m ISIC -y all > ISIC.log
    python -m emprego.step_4_sent -m Municipality -y all > Municipality.log 
    python -m emprego.step_4_sent -m State -y all > State.log 
    python -m emprego.step_4_sent -m CBO -y all > CBO.log     
    
    
    SENT DATA IN FORMAT CSV:
    
    0 - Municipality_ID, ex.: 120040
    1 - EconomicAtivity_ID_ISIC, ex.: 141 or  4730
    2 - EconomicActivity_ID_CNAE, ex.: 0151201
    3 - BrazilianOcupation_ID, ex.:  142105
    4 - WageReceived, 
    5 - AverageMonthlyWage, 
    6 - Employee_ID, 
    7 - Establishment_ID, 
    8 - Year
     
    
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR
from helpers import d, get_file, format_runtime,find_in_df,sql_to_df,read_from_csv,df_to_csv,left_df,to_int,to_number
import pandas as pd
from pandas import DataFrame
import pandas.io.sql as psql
import numpy as np

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=environ["DATAVIVA_DB_USER"], 
                        passwd=environ["DATAVIVA_DB_PW"], 
                        db=environ["DATAVIVA_DB_NAME"])
db.autocommit(1)
cursor = db.cursor()



##########################
#
#      CHECK FOR ISIC, CBO AND MDIC 
# 
##########################         
def checkISIC(year):
    print "Entering in checkISIC" 
    dfDV = sql_to_df("SELECT right(s.isic_id,4) as id,sum(wage) as val FROM rais_yi s where length(s.isic_id)=5 and year="+str(year)+" group by 1;",db)
    dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=",")    
    run_check(dfDV,dfSent,'EconomicAtivity_ID_ISIC',year)  

 
   
def checkMunicipality(year,size):
    print "Entering in checkBRA"    
    dfDV = sql_to_df("SELECT left(a.id_ibge,6) as id,sum(wage) as val FROM rais_yb s,attrs_bra a where length(a.id)="+str(size)+" and  a.id=s.bra_id and year="+str(year)+" group by 1;",db)
    dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=",")
    #dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+"Teste.csv",delimiter=",")    
    run_check(dfDV,dfSent,'Municipality_ID',year) 
    
    
    
         
def checkCBO(year):
    print "Entering in checkCBO" 
    dfDV = sql_to_df("SELECT a.id as id,sum(wage) as val FROM rais_yo s,attrs_cbo a where length(a.id)=4 and  a.id=s.cbo_id and year="+str(year)+" group by 1;",db)
    dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=",")   
    run_check(dfDV,dfSent,'BrazilianOcupation_ID',year)  
    

def get_valueGroup(dfGroup,id,var):
    try:
        valCSV= dfGroup.get_group(id)['AverageMonthlyWage'].sum() 
        if valCSV==False or valCSV is None:
            print "Value in None or False sor "+valCSV
        else:
            return valCSV
    
    except:                    
        return False

##########################
#
#      RUN SCRIPTS AND METHODS
# 
##########################         

def run_check(dfDV,dfSent,groupId,year):

    if dfSent is not None:
        dfSent=clean_df_sent(dfSent)    
    if dfDV is not None:
        dfDV=clean_df_dv(dfDV)
        
    
    dfGroup = dfSent.groupby([groupId]) 
    df_to_csv(dfGroup.sum(),"dados\emprego\sent\RaisGroup"+str(year)+".csv")
            
    print "Enterin in for "+groupId
    for id in dfDV['id']:  
        idint =to_int(id)
        if not id:
            continue
        
        valDV = dfDV[(dfDV['id']==id)]['val'].values[0]

        valCSV=get_valueGroup(dfGroup,id,'AverageMonthlyWage')
        if valCSV==False:
            valCSV=get_valueGroup(dfGroup,idint,'AverageMonthlyWage')
        
        if valCSV==False:
            print "Not found in CSV a value for "+str(id)+" - "+str(idint)+"  : Exports of value  "+ str(valDV)+ " in the year "+str(year)
            continue 

         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        if valDV!=valCSV:
            txt= "ERROR in groupId ("+str(year)+"): "+str(id)+" / "+str(idint)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(valCSV - valDV)
            print txt
        else:
            txt="OK "+str(id)
            print txt

#dfSent=dfSent[dfSent['BrazilianOcupation_ID4']<2000]
#dfDV=dfDV[dfDV['id']<2000]
def clean_df_sent(dfSent):
    
    for column in ('EconomicActivity_ID_CNAE','WageReceived','Employee_ID','Establishment_ID','Year'):
        dfSent = dfSent.drop(column, axis=1)
    
     
    dfSent = left_df(dfSent,'BrazilianOcupation_ID',4,'BrazilianOcupation_ID4')

    dfSent['BrazilianOcupation_ID'] = dfSent.apply(lambda f : to_number(f['BrazilianOcupation_ID4']) , axis = 1)
    dfSent['Municipality_ID']=dfSent[dfSent.columns[0]]
    
    
    dfSent['Municipality_ID'] = dfSent.apply(lambda f : to_number(f['Municipality_ID']) , axis = 1)
    dfSent['Municipality_ID'] = dfSent['Municipality_ID'].astype(np.float64)   
    dfSent['AverageMonthlyWage'] = dfSent.apply(lambda f : to_number(f['AverageMonthlyWage']) , axis = 1) 
    dfSent['AverageMonthlyWage'] = dfSent['AverageMonthlyWage'].astype(np.float64)     

    
    return dfSent


def clean_df_dv(dfDV):
    
    dfDV['id'] = dfDV.apply(lambda f : to_number(f['id']) , axis = 1) 
    dfDV['id'] = dfDV['id'].astype(np.float64)     
    return dfDV

    #TESTES CORTE
    #dfDV = read_from_csv("dados\emprego\sent\RaisBD"+str(year)+".csv",delimiter=",")
    #df_to_csv(dfSent,"dados\emprego\sent\RaisTest"+str(year)+".csv")
    #df_to_csv(dfDV,"dados\emprego\sent\RaisBD"+str(year)+".csv")
      


##########################
#
#      RUN COMMAND CONSOLE SCRIPTS
# 
##########################            
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: ISIC , Municipality , State , CBO',required=False)
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
        checkISIC(year)
        checkCBO(year)
        checkMunicipality(year,8) 
        checkMunicipality(year,2) 
    elif method=="ISIC":
        checkISIC(year)     
    elif method=="Municipality":
        checkMunicipality(year,8) 
    elif method=="State":
        checkMunicipality(year,2)
    elif method=="CBO":
        checkCBO(year)  
                                                
if __name__ == "__main__":
    start = time.time()
    
    total_error=0
    msg_error=[]
    
    main()
    
    print "Total erros found: "+str(total_error)
    print "Erros messages:"
    print     msg_error
    
    
    total_run_time = time.time() - start
    print "Total runtime: " + format_runtime(total_run_time)