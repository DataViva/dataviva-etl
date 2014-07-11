# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_3_indicators -m all
    If need to run just a specific check, run: python -m exportacao.step_3_indicators -m ECI
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    References about this check in https://github.com/DataViva/datavivaetl/wiki/Exportacao#indicators
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR
from helpers import d, get_file, format_runtime
#from scripts import YEAR

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=environ["DATAVIVA_DB_USER"], 
                        passwd=environ["DATAVIVA_DB_PW"], 
                        db=environ["DATAVIVA_DB_NAME"])
db.autocommit(1)
cursor = db.cursor()



def errorMessage(step, table, size):
    global total_error
    global msg_error
    if size>0:          
        msg="Found {0} Errors in {1} for {2}".format(size,step,table)
        msg_error.append(msg)
        print msg        
        total_error=total_error+size

def runCountQuery(step, table, sql):
    print "---------------------------"
    cursor.execute(sql)
    values=cursor.fetchall()
    size=len(values)
    errorMessage(step, table, size)
    
    
#ECI: for all exports regions and all years
def checkECI():
    print "Entering in checkECI"
         
    sql="select * from secex_yb where (eci is null or eci < -3.1 or eci > 3.1) and val_usd >0 "  
    runCountQuery('checkECI', 'secex_yb', sql)
    
        
    sql="select * from secex_yw where (eci is null or eci < -3.1 or eci > 3.1) and val_usd >0"  
    runCountQuery('checkECI', 'secex_yw', sql)


#Diversity (HS / WLD / BRA): too for Ocupations (CBO) and ISIC
def checkDiversity():  
    print "Entering in checkDiversity"

    sql="select * from secex_yb where \
            (hs_diversity is null or hs_diversity <0 or \
            hs_diversity_eff is null or hs_diversity_eff<0 or \
            wld_diversity is null or wld_diversity<0 or \
            wld_diversity_eff is null or wld_diversity_eff<0) ;"
    runCountQuery('checkDiversity', 'secex_yb', sql)
    

    sql="select * from secex_yp where \
        bra_diversity is null or bra_diversity <0 or \
        bra_diversity_eff is null or bra_diversity_eff<0 or \
        wld_diversity is null or wld_diversity<0 or \
        wld_diversity_eff is null or wld_diversity_eff<0;"
    runCountQuery('checkDiversity', 'secex_yp', sql)


    sql="select * from secex_yw where \
            bra_diversity is null or bra_diversity<0 or \
            bra_diversity_eff is null or bra_diversity_eff<0 or \
            hs_diversity is null or hs_diversity<0 or \
            hs_diversity_eff is null or hs_diversity_eff<0; "
    runCountQuery('checkDiversity', 'secex_yw', sql)
   

    
#Growth's: for val_usd, number of employes, wage
# How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
def checkGrowth():  
    print "Entering in checkGrowth"
    
    aggsP = ["secex_yb","secex_ybp","secex_ybpw","secex_ybw","secex_yp","secex_yw"]
    for aggs in aggsP:    
        sql="select * from "+aggs+" where (val_usd_growth_pct is null or val_usd_growth_pct_5 is null or \
                                      val_usd_growth_val is null or val_usd_growth_val_5 is null ) and year > 2004"     
        runCountQuery('checkGrowth', aggs, sql)


#RCA: For all HS and all locations     
#Comparar com val_usd > 0 ?       
def checkRCA():  
    print "Entering in checkRCA"  
     
    sql="select * from secex_ybp where (rca is null or rca<0 or rca_wld is null or rca_wld<0) and val_usd > 0;"
    runCountQuery('checkRCA', 'secex_ybp', sql)

        
    sql="select * from secex_yp where (rca_wld is null or rca_wld<0) and val_usd > 0;"
    runCountQuery('checkRCA', 'secex_yp', sql)
    
        

#Distance: For all HS and all locations 
#Comparar com val_usd > 0 ?        
def checkDistance():  
    print "Entering in checkDistance"    

    sql="select * from secex_ybp where \
        (distance_wld is null or distance_wld<0 or distance_wld>1 or \
         distance is null or distance<0 or distance>1 ) \
        and val_usd > 0 ;" 
    runCountQuery('checkDistance', 'secex_ybp', sql)


#Opportunity: For all HS and all locations        
def checkOpportunity():  
    print "Entering in checkOpportunity"
    
    sql="select * from secex_ybp where (opp_gain is null or opp_gain < -3.1 or opp_gain > 3.1 \
                                or opp_gain_wld is null or opp_gain_wld < -3.1 or opp_gain_wld > 3.1 ) and val_usd >0"
    runCountQuery('checkOpportunity', 'secex_ybp', sql)


#PCI: For all HS    
def checkPCI():  
    print "Entering in checkPCI"
    
    sql="select * from secex_yp where (pci is null or pci < -3.1 or pci > 3.1) ;"
    runCountQuery('checkPCI', 'secex_yp', sql)
   
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: ECI,Diversity,Growth,RCA,Distance,Opportunity,PCI ',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method):
    if not method or method=='all':
        checkECI()
        checkDiversity()    
        checkGrowth()
        checkRCA()
        checkDistance()
        checkOpportunity()
        checkPCI()
        
    elif method=="ECI":
        checkECI()
    elif method=="Diversity":
        checkDiversity()
    elif method=="Growth":
        checkGrowth()
    elif method=="RCA":
        checkRCA()
    elif method=="Distance":
        checkDistance()
    elif method=="Opportunity":
        checkOpportunity()
    elif method=="PCI":
        checkPCI()
                                
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