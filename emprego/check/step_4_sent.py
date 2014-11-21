# -*- coding: utf-8 -*-
"""
    Check all data in rais tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_4_sent -m all
    If need to run just a specific check, run: python -m emprego.step_4_sent -m cnae
    
    
    Running a method for a yer:
    python -m emprego.step_4_sent -m cnae -y 2012 > cnae.log
    
    Running aall methods for a yer:
    python -m emprego.step_4_sent -m all -y 2012 > cnae2012.log
        
    Running one by one for all years:
    
    python -m emprego.check.step_4_sent -m all -y all > step_4_sent.log
    python -m emprego.check.step_4_sent -m CNAE -y all > CNAE.log
    python -m emprego.check.step_4_sent -m Municipality -y all > Municipality.log 
    python -m emprego.check.step_4_sent -m State -y all > State.log 
    python -m emprego.check.step_4_sent -m CBO -y all > CBO.log     
    
    
    SENT DATA IN FORMAT CSV:
    
    0 - cbo, ex.: 413210
    1 - cnae, ex.: 64221
    2 - Literacy, ex.: 7
    3 - Age, ex.: 50
    4 - est_id 7120, 
    5 - Simple 0, 
    6 - munic 120040, 
    7 - emp_id 10000652927, 
    8 - Color 9 ,
    9 - wage_dec 288,52
   10 - wage 288,52
   11 - Gender 1,
   12 - Establishment_Size 5,
   13 - Year 2002
     
    
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR,DATAVIVA_DB_USER,DATAVIVA_DB_PW,DATAVIVA_DB_NAME
from helpers import d, get_file, format_runtime,find_in_df,sql_to_df,read_from_csv,df_to_csv,left_df,to_int,to_number
import pandas as pd
from pandas import DataFrame
import pandas.io.sql as psql
import numpy as np
import unittest

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER,  passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()

cols = ["cbo", "cnae", "literacy", "age", "est_id", "simple", "munic", "emp_id", "color", "wage_dec", "wage", "gender", "est_size", "year"]

##########################
#
#      CHECK FOR cnae, CBO AND MDIC 
# 
########################## 
class EmpregoSent(unittest.TestCase):  
                
    def test_CNAE(self,year):
        print "Entering in checkCNAE" 
        #before right 4 and len 5
        dfDV = sql_to_df("SELECT right(s.cnae_id,4) as id,sum(wage) as val FROM rais_yi s where s.cnae_id_len=6 and year="+str(year)+" group by 1;",db)
        dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=";",cols=cols) 
        total=run_check(dfDV,dfSent,'cnae',year)  
        self.assertEqual(total, 0)
     
       
    def test_Municipality(self,year,size):
        print "Entering in checkBRA"    
        dfDV = sql_to_df("SELECT left(a.id_ibge,6) as id,sum(wage) as val FROM rais_yb s,attrs_bra a where s.bra_id_len="+str(size)+" and  a.id=s.bra_id and year="+str(year)+" group by 1;",db)
        dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=";",cols=cols)
        #dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+"Teste.csv",delimiter=",")    
        total=run_check(dfDV,dfSent,'munic',year) 
        self.assertEqual(total, 0)
        
        
             
    def test_CBO(self,year):
        print "Entering in checkCBO" 
        dfDV = sql_to_df("SELECT s.cbo_id as id,sum(wage) as val FROM rais_yo s where s.cbo_id_len=4 and s.year="+str(year)+" group by 1;",db)
        dfSent = read_from_csv("dados\emprego\sent\Rais"+str(year)+".csv",delimiter=";",cols=cols)   
        total=run_check(dfDV,dfSent,'cbo',year)  
        self.assertEqual(total, 0)

def get_valueGroup(dfGroup,id,var):
    try:
        valCSV= dfGroup.get_group(id)['wage'].sum() 
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
    
    total=0
    print "Enterin in for "+groupId
    for id in dfDV['id']:  
        idint =to_int(id)
        if not id:
            continue
        
        valDV = dfDV[(dfDV['id']==id)]['val'].values[0]

        valCSV=get_valueGroup(dfGroup,id,'wage')
        if valCSV==False:
            valCSV=get_valueGroup(dfGroup,idint,'wage')
        
        if valCSV==False:
            total=total+1
            print "Not found in CSV a value for "+str(id)+" - "+str(idint)+"  : Exports of value  "+ str(valDV)+ " in the year "+str(year)
            continue 

         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        if valDV!=valCSV:
            txt= "ERROR in groupId ("+str(year)+"): "+str(id)+" / "+str(idint)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(valCSV - valDV)
            print txt
            total=total+1
        else:
            txt="OK "+str(id)
            #print txt
    return total


#dfSent=dfSent[dfSent['cbo4']<2000]
#dfDV=dfDV[dfDV['id']<2000]
def clean_df_sent(dfSent):
    #'cnae',
    for column in ('wage_dec','emp_id','est_id','year'):
        dfSent = dfSent.drop(column, axis=1)
    
     
    dfSent = left_df(dfSent,'cbo',4,'cbo4')

    dfSent['cbo'] = dfSent.apply(lambda f : to_number(f['cbo4']) , axis = 1)
    dfSent['munic']=dfSent[dfSent.columns[0]]
    
    
    dfSent['munic'] = dfSent.apply(lambda f : to_number(f['munic']) , axis = 1)
    dfSent['munic'] = dfSent['munic'].astype(np.float64)   
    dfSent['wage'] = dfSent.apply(lambda f : to_number(f['wage']) , axis = 1) 
    dfSent['wage'] = dfSent['wage'].astype(np.float64)     

    
    return dfSent


def clean_df_dv(dfDV):
    print dfDV
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
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: CNAE , Municipality , State , CBO',required=False)
@click.option('-y', '--year', prompt='Year', help='chosse a year to run : 2000 to 2014 or all',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method,year):
    if not year:
        year=2002
        
    elif year=='all':
        for y in (2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013):
            runMethodYear(method,y)
            
        return
    
    runMethodYear(method,year)    
        
        
       

def runMethodYear(method,year):
    cls=EmpregoSent()
    if not method or method=='all':
        cls.test_CNAE(year)
        cls.test_CBO(year)
        cls.test_Municipality(year,8) 
        cls.test_Municipality(year,2) 
    elif method=="CNAE":
        cls.test_CNAE(year)     
    elif method=="Municipality":
        cls.test_Municipality(year,8) 
    elif method=="State":
        cls.test_Municipality(year,2)
    elif method=="CBO":
        cls.test_CBO(year)  
                                                
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