# -*- coding: utf-8 -*-
"""
    Check all data in nfe tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: 
        All months:
        python -m educacaosuperior.check.step_4_sent -y all

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

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER,  passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()


   
    
def sumColumns(f,columns):
    total=None
    for i in columns:
        if total:
            total=total+to_number(f[i])
        else:
            total=to_number(f[i])
    return total
        
        
    

def get_valueGroup(dfGroup,id,var):
    try:
        valCSV= dfGroup.get_group(id)[var].sum() 
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

def run_check(dfDV,dfSent,groupId,month,valId):

    
    dfGroup = dfSent.groupby([groupId]) 
    #df_to_csv(dfGroup.sum(),"dados\emprego\sent\RaisGroup"+str(year)+".csv")
            
    print "Running check "
    for id in dfDV['id']:  
        idint =to_int(id)
        if not id:
            continue
        
        valDV = dfDV[(dfDV['id']==id)]['val'].values[0]

        valCSV=get_valueGroup(dfGroup,id,valId)
        if valCSV==False:
            valCSV=get_valueGroup(dfGroup,idint,valId)
        
        if valCSV==False:
            if valDV>1:
                print "Not found in CSV a value for "+str(id)+" - "+str(idint)+"  : Exports of value  "+ str(valDV)+ " in the month "+str(month)
            continue 

         
        valCSV=to_int(valCSV)        
        valDV=to_int(valDV)
        diffDVCSV=valCSV - valDV
        if valDV!=valCSV and (diffDVCSV>1 or diffDVCSV<-1):
            txt= "ERROR in groupId ("+str(month)+"): "+str(id)+" / "+str(idint)+" - Value in CSV "+ str(valCSV)+ " <> Value in DV "+str(valDV) + " - Difference: "+str(diffDVCSV)
            print txt
        else:
            txt="OK "+str(id)
            print txt


##########################
#
#      RUN COMMAND CONSOLE SCRIPTS
# 
##########################            
        
@click.command()
@click.option('-y', '--year', prompt='year', help='chosse a year to run : 2009 to 2013 or all',required=False)
#@click.option('-s', '--step', prompt='step', help='chosse a step to run. Use all or [purchase,transfer,devolution,icms, remit, icmstax,tax]',required=False)
def main(year=None):

    #"Brasil;;;2.314;"
    cols=['bra','bra_sub1','bra_sub2','value']    
    idsites=['bra','bra_sub1','bra_sub2','value']
    
    dfSent = read_from_csv("docs\\check\\educacaosuperior\\sinopse_da_educacao_superior_2009-1.1.csv",delimiter=";",cols=cols,usecols=cols)
    dfSent=dfSent.drop(['bra_sub1','bra_sub2'],axis=1)
    dfSent = dfSent.dropna(thresh=2)
    
    mapStates=getMapStates()    

    format = lambda x:  city_fix(x,mapStates)
    dfSent['bra']= dfSent["bra"].map(format)
    dfSent['value'] = dfSent.apply(lambda f : to_number(f['value']) , axis = 1)
    dfSent['value'] = dfSent['value'].astype(np.float64)
    

    sql="SELECT bra_id,sum(enrolled) as value FROM hedu_ybucd where bra_id='4mg' and bra_id_len=3 AND d_id in ('A','B') and course_id_len=6 group by 1"
    dfDV = sql_to_df(sql,db)
    dfDV['value'] = dfDV['value'].astype(np.float64)
    

    return 


def city_fix(entrada,mapStates):
    encontrou= mapStates[(mapStates['bra_accent']==entrada)]
    #print entrada
    if encontrou.empty:
        encontrou= mapStates[(mapStates['bra']==entrada)]
        if encontrou.empty:
            return entrada

    return encontrou['value'].tolist()[0]
    
    
def getMapStates():
    cols=['bra','bra_accent','value']
    mapStates = read_from_csv("docs\\check\\codestados.csv",delimiter=";",cols=cols)
    return mapStates
            
def runsteps(month,senderReceiver,step):
    
    if step=="all":
        checkPurchase(month,senderReceiver)
        checkTransfer(month,senderReceiver)
        checkDevolution(month,senderReceiver)
        checkICMS(month,senderReceiver)
        checkRemit(month,senderReceiver)
        checkIcmsTax(month,senderReceiver)
        checkTax(month,senderReceiver)
    elif step=="purchase":
        checkPurchase(month,senderReceiver)
    elif step=="transfer":
        checkTransfer(month,senderReceiver)
    elif step=="devolution":
        checkDevolution(month,senderReceiver)
    elif step=="icms":
        checkICMS(month,senderReceiver)
    elif step=="remit":
        checkRemit(month,senderReceiver)
    elif step=="icmstax":
        checkIcmsTax(month,senderReceiver)
    elif step=="tax":
        checkTax(month,senderReceiver)
                    
                                                      
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