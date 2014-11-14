# -*- coding: utf-8 -*-
"""
    Check all data in nfe tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: 
        All months:
        python -m nfe.check.step_4_sent -m all
    
        One month:
        python -m nfe.check.step_4_sent -m 01

        Wrinting a log file:
        python -m nfe.check.step_4_sent -m 01 > nfecheck4.log
        
        One step:
        python -m nfe.check.step_4_sent -m 01 -s transfer > nfecheck4.log
        
        One month, step and city:
        python -m nfe.check.step_4_sent -m 01 -s transfer -c Receiver > nfecheck4.log
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

cols = ["TransactedProduct_ID_NCM", "TransactedProduct_ID_HS", "EconomicAtivity_ID_CNAE_Receiver_5d", "EconomicAtivity_ID_CNAE_Receiver_2d", "EconomicAtivity_ID_CNAE_Sender_5d",\
         "EconomicAtivity_ID_CNAE_Sender_2d", "CFOP_ID", "Receiver_foreign", "Sender_foreign", "Municipality_ID_Receiver", "Municipality_ID_Sender", "Year", "Monthly", "Cost_Value", \
         "ICMS_ST_Value", "ICMS_Value", "IPI_Value", "PIS_Value", "COFINS_Value", "II_Value", "Product_Value", "ISSQN_Value"]
   
usecols = ["Municipality_ID_Sender","Municipality_ID_Receiver","CFOP_ID","ICMS_ST_Value", "ICMS_Value", "IPI_Value", "PIS_Value", "COFINS_Value", "II_Value", "Product_Value", "ISSQN_Value"]

def getTable(senderReceiver):
    if senderReceiver=='Sender':
        return 'ei_yms'
    return 'ei_ymr'

# ,senderReceiver = 'Sender' or 'Receiver'
#1    Compras/Vendas    Purchases / Sales
def checkPurchase(month,senderReceiver):
    
    prepare(month,'purchase_value',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,'Product_Value',1)

#2    Transferências    Transfer
def checkTransfer(month,senderReceiver):
    prepare(month,'transfer_value',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,'Product_Value',2)

#3    Devolução    Devolution
def checkDevolution(month,senderReceiver):
    prepare(month,'devolution_value',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,'Product_Value',3)

#4    Crédito ICMS    ICMS credit
def checkICMS(month,senderReceiver):
    prepare(month,'icms_credit_value',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,'Product_Value',4)

#5    Remessas ou Retornos    Remittances or returns
def checkRemit(month,senderReceiver):
    prepare(month,'remit',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,'Product_Value',5)

#Tax
def checkIcmsTax(month,senderReceiver):
    prepare(month,'icms_tax',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,["ICMS_ST_Value", "ICMS_Value"])
    
#5    Remessas ou Retornos    Remittances or returns
def checkTax(month,senderReceiver):
    prepare(month,'tax',getTable(senderReceiver),'Municipality_ID_'+senderReceiver,["IPI_Value", "PIS_Value", "COFINS_Value", "II_Value", "Product_Value", "ISSQN_Value"]) 
    
    
    
def prepare(month,field,table,city,value,cfop=None):
    print "Loading : table "+ table + " value for "+field+" in "+city  
    sql="SELECT a.id_ibge as id,sum("+field+") as val FROM "+table+" e, attrs_bra a where right(e.bra_id_s,8) = a.id and e.month="+month+" and a.id_ibge is not null group by 1"  
    
    dfDV = sql_to_df(sql,db)
    dfSent = read_from_csv("dados\\nfe\\2013_"+month+".csv",delimiter=";",cols=cols,usecols=usecols)
    
    if cfop:
        dfSent = dfSent[(dfSent['CFOP_ID']==cfop)]
    if type(value) is list:
        dfSent[value] = dfSent.apply(lambda f : sumColumns(f,value) , axis = 1)
    else:
        dfSent[value] = dfSent.apply(lambda f : to_number(f[value]) , axis = 1)
    dfSent[value] = dfSent[value].astype(np.float64)   
    
    run_check(dfDV,dfSent,city,month,value) 
    
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
@click.option('-m', '--month', prompt='month', help='chosse a month to run : 01 to 04 or all',required=False)
@click.option('-s', '--step', prompt='step', help='chosse a step to run. Use all or [purchase,transfer,devolution,icms, remit, icmstax,tax]',required=False)
@click.option('-c', '--city', prompt='city', help='inform if the city is Sender or Receiver',required=False)
def main(month=None, step=None,city=None):

    if not step:
        step='all'        

    if not step:
        step='all' 
            
    if not city:
        city='all'    
                   
    elif month=='all':
        for y in ('01','02','03','04'):
            runstepcity(y,city,step)
        return
    
    runstepcity(month,city,step)
        
def runstepcity(month,city,step):
    if city=='all':
        runsteps(month,'Sender',step) 
        runsteps(month,'Receiver',step)
    else:
        runsteps(month,city,step)
            
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