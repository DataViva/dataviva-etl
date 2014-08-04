# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_3_indicators -m all
    If need to run just a specific check, run: python -m exportacao.step_3_indicators -m ECI
    
    Running one by one:
    
    python -m exportacao.step_3_indicators -m ECI > ECI.log
    python -m exportacao.step_3_indicators -m Diversity > Diversity.log
    python -m exportacao.step_3_indicators -m Growth > Growth.log
    python -m exportacao.step_3_indicators -m RCA > RCA.log
    python -m exportacao.step_3_indicators -m Distance > Distance.log
    python -m exportacao.step_3_indicators -m Opportunity > Opportunity.log
    python -m exportacao.step_3_indicators -m PCI > PCI.log
    python -m exportacao.step_3_indicators -m ValUSD > ValUSD.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    References about this check in https://github.com/DataViva/datavivaetl/wiki/Exportacao#indicators
    
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
    
    sql="select * from secex_yb where val_usd is null;"
    runCountQuery('checkValUSD', 'secex_yb', sql,cursor) 
    
    sql="select * from secex_ybp where val_usd is null;"
    runCountQuery('checkValUSD', 'secex_ybp', sql,cursor) 
    
    sql="select * from secex_ybpw where val_usd is null;"
    runCountQuery('checkValUSD', 'secex_ybpw', sql,cursor) 
    
    sql="select * from secex_ybw where val_usd is null;"
    runCountQuery('checkValUSD', 'secex_ybw', sql,cursor) 
    
    sql="select * from secex_yp where val_usd is null;"
    runCountQuery('checkValUSD', 'secex_yp', sql,cursor) 

    
#ECI: for all exports regions and all years
def checkECI():
    print "Entering in checkECI"
         
    sql="select * from secex_yb b where (b.eci is null or b.eci < -3.1 or b.eci > 3.1) \
        and b.val_usd >0 and b.bra_id in (select bra_id from secex_ybp where rca>=1 and year=b.year group by bra_id) "  
    runCountQuery('checkECI', 'secex_yb', sql,cursor)
    
        
    sql="select * from secex_yw where (eci is null or eci < -3.1 or eci > 3.1) and val_usd >0"  
    runCountQuery('checkECI', 'secex_yw', sql,cursor)


#Diversity (HS / WLD / BRA): too for Ocupations (CBO) and ISIC
def checkDiversity():  
    print "Entering in checkDiversity"

    sql="select * from secex_yb where \
            (hs_diversity is null or hs_diversity <0 or \
            hs_diversity_eff is null or hs_diversity_eff<0 or \
            wld_diversity is null or wld_diversity<0 or \
            wld_diversity_eff is null or wld_diversity_eff<0) ;"
    runCountQuery('checkDiversity', 'secex_yb', sql,cursor)
    

    sql="select * from secex_yp where \
        bra_diversity is null or bra_diversity <0 or \
        bra_diversity_eff is null or bra_diversity_eff<0 or \
        wld_diversity is null or wld_diversity<0 or \
        wld_diversity_eff is null or wld_diversity_eff<0;"
    runCountQuery('checkDiversity', 'secex_yp', sql,cursor)


    sql="select * from secex_yw where \
            bra_diversity is null or bra_diversity<0 or \
            bra_diversity_eff is null or bra_diversity_eff<0 or \
            hs_diversity is null or hs_diversity<0 or \
            hs_diversity_eff is null or hs_diversity_eff<0; "
    runCountQuery('checkDiversity', 'secex_yw', sql,cursor)
   

    
#Growth's: for val_usd, number of employes, wage
# How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
def checkGrowth():  
    print "Entering in checkGrowth"
    
    #Anual - Check 
    aggsP = ["secex_yb","secex_ybp","secex_ybpw","secex_ybw","secex_yp","secex_yw"]
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
        sql="select * from secex_yb s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_yb interno where interno.year=s.year-"+year+"  and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth_pct', "secex_yb", sql,cursor)
    
        #YW
        sql="select * from secex_yw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_yw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth', "secex_yw", sql,cursor)
        
        #YP
        sql="select * from secex_yp s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_yp interno where interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "secex_yp", sql,cursor)
     
    
        #YBP
        sql="select * from secex_ybp s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_ybp interno where interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "secex_ybp", sql,cursor)    
        
        
        #YBW
        sql="select * from secex_ybw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_ybw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.bra_id = s.bra_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "secex_ybw", sql,cursor)      
    
        #YBPW
        sql="select * from secex_ybpw s where (  \
            (s.val_usd_growth_pct"+label+" is null and (select val_usd from secex_ybpw interno where interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "secex_ybw", sql,cursor)     
    

#RCA: For all HS and all locations     
#Comparar com val_usd > 0 ?       
def checkRCA():  
    print "Entering in checkRCA"  
     
    sql="select * from secex_ybp where (val_usd > 0 and (rca is null or rca<=0 or rca_wld is null or rca_wld<=0) ) \
         or (val_usd =0 and ( rca_wld is not null or rca is not null ) ) ;"
    runCountQuery('checkRCA', 'secex_ybp', sql,cursor)

        
    sql="select * from secex_yp where (val_usd > 0 and (rca_wld is null or rca_wld<=0) ) or (val_usd =0 and rca_wld is not null);"
    runCountQuery('checkRCA', 'secex_yp', sql,cursor)
    
        

#Distance: For all HS and all locations 
#Comparar com val_usd > 0 ?        
def checkDistance():  
    print "Entering in checkDistance"    

    sql="select * from secex_ybp where (distance_wld<0 or distance_wld>1 or distance<0 or distance>1 ) \
        or ( (distance_wld is null or distance is null)  and length(hs_id)=6) or ( (distance_wld is not null or distance is not  null)  and length(hs_id)<>6);" 
    runCountQuery('checkDistance', 'secex_ybp', sql,cursor)


#Opportunity: For all HS and all locations        
def checkOpportunity():  
    print "Entering in checkOpportunity"
    
    sql="select * from secex_ybp where (opp_gain < -3.1 or opp_gain > 3.1 or opp_gain_wld < -3.1 or opp_gain_wld > 3.1 ) \
                               or ( (opp_gain is null or opp_gain_wld is null) and length(hs_id)=6) or (  ( opp_gain_wld is not null or opp_gain is not null)  and length(hs_id)<>6 ) "
    runCountQuery('checkOpportunity', 'secex_ybp', sql,cursor)


#PCI: For all HS    
def checkPCI():  
    print "Entering in checkPCI"
    
    sql="select * from secex_yp where (pci is null and length(hs_id)=6) or (pci is not null and length(hs_id)<>6) or (pci < -3.1 or pci > 3.1) ;"
    runCountQuery('checkPCI', 'secex_yp', sql,cursor)
   
        
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