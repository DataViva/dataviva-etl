# -*- coding: utf-8 -*-
"""
    Check all data in rais tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_3_indicators -m all
    If need to run just a specific check, run: python -m emprego.step_3_indicators -m ECI
    
    Running one by one:
    
    python -m emprego.step_3_indicators -m ECI > ECI.log
    python -m emprego.step_3_indicators -m Diversity > Diversity.log
    python -m emprego.step_3_indicators -m Growth > Growth.log
    python -m emprego.step_3_indicators -m RCA > RCA.log
    python -m emprego.step_3_indicators -m Distance > Distance.log
    python -m emprego.step_3_indicators -m Opportunity > Opportunity.log
    python -m emprego.step_3_indicators -m PCI > PCI.log
    python -m emprego.step_3_indicators -m ValUSD > ValUSD.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    References about this check in https://github.com/DataViva/datavivaetl/wiki/emprego#indicators
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR
from helpers import d, get_file, format_runtime,errorMessage,runCountQuery
#from scripts import YEAR

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=environ["DATAVIVA_DB_USER"], 
                        passwd=environ["DATAVIVA_DB_PW"], 
                        db=environ["DATAVIVA_DB_NAME"])
db.autocommit(1)
cursor = db.cursor()



#ECI: for all exports regions and all years
def checkValUSD():
    print "Entering in checkValUSD"
    
    sql="select * from rais_yb where val_usd is null;"
    runCountQuery('checkValUSD', 'rais_yb', sql,cursor) 
    
    sql="select * from rais_ybp where val_usd is null;"
    runCountQuery('checkValUSD', 'rais_ybp', sql,cursor) 
    
    sql="select * from rais_ybpw where val_usd is null;"
    runCountQuery('checkValUSD', 'rais_ybpw', sql,cursor) 
    
    sql="select * from rais_ybw where val_usd is null;"
    runCountQuery('checkValUSD', 'rais_ybw', sql,cursor) 
    
    sql="select * from rais_yp where val_usd is null;"
    runCountQuery('checkValUSD', 'rais_yp', sql,cursor) 

    
#ECI: for all exports regions and all years
def checkECI():
    print "Entering in checkECI"
         
    sql="select * from rais_yb b where (b.eci is null or b.eci < -3.1 or b.eci > 3.1) \
        and b.val_usd >0 and b.bra_id in (select bra_id from rais_ybp where rca>=1 and year=b.year group by bra_id) "  
    runCountQuery('checkECI', 'rais_yb', sql,cursor)
    
        
    sql="select * from rais_yw where (eci is null or eci < -3.1 or eci > 3.1) and val_usd >0"  
    runCountQuery('checkECI', 'rais_yw', sql,cursor)


#Diversity (HS / WLD / BRA): too for Ocupations (CBO) and ISIC
def checkDiversity():  
    print "Entering in checkDiversity"

    sql="select * from rais_yb where \
            (hs_diversity is null or hs_diversity <0 or \
            hs_diversity_eff is null or hs_diversity_eff<0 or \
            wld_diversity is null or wld_diversity<0 or \
            wld_diversity_eff is null or wld_diversity_eff<0) ;"
    runCountQuery('checkDiversity', 'rais_yb', sql,cursor)
    

    sql="select * from rais_yp where \
        bra_diversity is null or bra_diversity <0 or \
        bra_diversity_eff is null or bra_diversity_eff<0 or \
        wld_diversity is null or wld_diversity<0 or \
        wld_diversity_eff is null or wld_diversity_eff<0;"
    runCountQuery('checkDiversity', 'rais_yp', sql,cursor)


    sql="select * from rais_yw where \
            bra_diversity is null or bra_diversity<0 or \
            bra_diversity_eff is null or bra_diversity_eff<0 or \
            hs_diversity is null or hs_diversity<0 or \
            hs_diversity_eff is null or hs_diversity_eff<0; "
    runCountQuery('checkDiversity', 'rais_yw', sql,cursor)
   

    
#Growth's: for val_usd, number of employes, wage
# How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
def checkGrowth():  
    print "Entering in checkGrowth"
    
    #Anual - Check 
    aggsP = ["rais_yb","rais_ybp","rais_ybpw","rais_ybw","rais_yp","rais_yw"]
    for aggs in aggsP:    
        sql="select * from "+aggs+" s where val_usd_growth_val is null and year > 2000"   
        #Check ir because all values that should be 0 is None  
        #runCountQuery('checkGrowth_val', aggs, sql)


    #Anuaal
    years = [("5","_5"),("1","")]
    for vals in years:
        year=vals[0]
        label=vals[1]   
        #YB
        sql="select * from rais_yb s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_yb interno where interno.year=s.year-"+year+"  and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth_pct', "rais_yb", sql,cursor)
    
        #YW
        sql="select * from rais_yw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_yw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth', "rais_yw", sql,cursor)
        
        #YP
        sql="select * from rais_yp s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_yp interno where interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_yp", sql,cursor)
     
    
        #YBP
        sql="select * from rais_ybp s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_ybp interno where interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybp", sql,cursor)    
        
        
        #YBW
        sql="select * from rais_ybw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_ybw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.bra_id = s.bra_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybw", sql,cursor)      
    
        #YBPW
        sql="select * from rais_ybpw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from rais_ybpw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybw", sql,cursor)     
    

#RCA: For all HS and all locations     
#Comparar com val_usd > 0 ?       
def checkRCA():  
    print "Entering in checkRCA"  
     
    sql="select * from rais_ybp where (val_usd > 0 and (rca is null or rca<=0 or rca_wld is null or rca_wld<=0) ) \
         or (val_usd =0 and ( rca_wld is not null or rca is not null ) ) ;"
    runCountQuery('checkRCA', 'rais_ybp', sql,cursor)

        
    sql="select * from rais_yp where (val_usd > 0 and (rca_wld is null or rca_wld<=0) ) or (val_usd =0 and rca_wld is not null);"
    runCountQuery('checkRCA', 'rais_yp', sql,cursor)
    
        

#Distance: For all HS and all locations 
#Comparar com val_usd > 0 ?        
def checkDistance():  
    print "Entering in checkDistance"    

    sql="select * from rais_ybp where (distance_wld<0 or distance_wld>1 or distance<0 or distance>1 ) \
        or ( (distance_wld is null or distance is null)  and length(hs_id)=6) or ( (distance_wld is not null or distance is not  null)  and length(hs_id)<>6);" 
    runCountQuery('checkDistance', 'rais_ybp', sql,cursor)


#Opportunity: For all HS and all locations        
def checkOpportunity():  
    print "Entering in checkOpportunity"
    
    sql="select * from rais_ybp where (opp_gain < -3.1 or opp_gain > 3.1 or opp_gain_wld < -3.1 or opp_gain_wld > 3.1 ) \
                               or ( (opp_gain is null or opp_gain_wld is null) and length(hs_id)=6) or (  ( opp_gain_wld is not null or opp_gain is not null)  and length(hs_id)<>6 ) "
    runCountQuery('checkOpportunity', 'rais_ybp', sql,cursor)


#PCI: For all HS    
def checkPCI():  
    print "Entering in checkPCI"
    
    sql="select * from rais_yp where (pci is null and length(hs_id)=6) or (pci is not null and length(hs_id)<>6) or (pci < -3.1 or pci > 3.1) ;"
    runCountQuery('checkPCI', 'rais_yp', sql,cursor)
   
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: ECI,Diversity,Growth,RCA,Distance,Opportunity,PCI,ValUSD ',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method):
    if not method or method=='all':
        checkValUSD()
        checkECI()
        checkDiversity()    
        checkGrowth()
        checkRCA()
        checkDistance()
        checkOpportunity()
        checkPCI()
    elif method=="ValUSD":
        checkValUSD()        
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