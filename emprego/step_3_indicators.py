# -*- coding: utf-8 -*-
"""
    Check all data in rais tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_3_indicators -m all
    If need to run just a specific check, run: python -m emprego.step_3_indicators -m ECI
    
    Running one by one:
    
    python -m emprego.step_3_indicators -m Importance > Importance.log
    python -m emprego.step_3_indicators -m Diversity > Diversity.log
    python -m emprego.step_3_indicators -m Growth > Growth.log
    python -m emprego.step_3_indicators -m GrowthAnual > GrowthAnual.log    
    python -m emprego.step_3_indicators -m RCA > RCA.log
    python -m emprego.step_3_indicators -m Distance > Distance.log
    python -m emprego.step_3_indicators -m Opportunity > Opportunity.log
    python -m emprego.step_3_indicators -m Required > Required.log
    python -m emprego.step_3_indicators -m Wage > Wage.log
    
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
def checkWage():
    print "Entering in checkWage"
    
    sql="select count(*) from rais_yb where wage is null;"
    runCountQuery('checkWage', 'rais_yb', sql,cursor,count=True) 
    
    sql="select count(*) from rais_ybi where wage is null;"
    runCountQuery('checkWage', 'rais_ybi', sql,cursor,count=True) 
    
    sql="select count(*) from rais_ybio where wage is null;"
    runCountQuery('checkWage', 'rais_ybio', sql,cursor,count=True) 
    
    sql="select count(*) from rais_ybo where wage is null;"
    runCountQuery('checkWage', 'rais_ybo', sql,cursor,count=True) 
    
    sql="select count(*) from rais_yi where wage is null;"
    runCountQuery('checkWage', 'rais_yi', sql,cursor,count=True) 

    sql="select count(*) from rais_yo where wage is null;"
    runCountQuery('checkWage', 'rais_yo', sql,cursor,count=True) 
    
#ECI: for all exports regions and all years
def checkImportance():
    print "Entering in checkImportance"
         
    sql="select count(*) from rais_yio where (importance < 0 or importance > 1 ) \
    or ( importance is null  and num_emp>0) or (   importance is not null  and num_emp=0 ) "  
    runCountQuery('checkImportance', 'rais_yio', sql,cursor,count=True)


#Diversity (HS / WLD / BRA): too for Ocupations (CBO) and ISIC
def checkDiversity():  
    print "Entering in checkDiversity"

    sql="SELECT count(*) FROM rais_yi where num_emp >0 and not (cbo_diversity >0 and cbo_diversity_eff >0 and bra_diversity>0  and bra_diversity_eff>0 );"
    runCountQuery('checkDiversity', 'rais_yi', sql,cursor,count=True)

    sql="SELECT count(*) FROM rais_yb where num_emp >0 and not (cbo_diversity >0 and cbo_diversity_eff >0 and isic_diversity>0  and isic_diversity_eff>0 );"
    runCountQuery('checkDiversity', 'rais_yb', sql,cursor,count=True)

    sql="SELECT count(*) FROM rais_yo where num_emp >0 and not (bra_diversity >0 and bra_diversity_eff >0 and isic_diversity>0  and isic_diversity_eff>0 );"
    runCountQuery('checkDiversity', 'rais_yo', sql,cursor,count=True)
   

    
#Growth's: for wage, number of employes, wage
# How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
def checkGrowthAnual():  
    print "Entering in checkGrowthAnual"
    
    #Anual - Check 
    aggsP = ["rais_yb","rais_ybi","rais_ybio","rais_ybo","rais_yi","rais_yo"]
    for aggs in aggsP:    
        sql="select count(*) from "+aggs+" s where (wage_growth_val is null or num_emp_growth_val is null) and year > 2000"   
        #Check ir because all values that should be 0 is None  
        runCountQuery('checkGrowth_val', aggs, sql,cursor,count=True)

    
def checkGrowth():  
    print "Entering in checkGrowth"
    #Anuaal
    years = [("5","_5"),("1","")]
    for vals in years:
        year=vals[0]
        label=vals[1]   
        #YB
        sql="select count(*) from rais_yb s where (  \
            (s.wage_growth_pct"+label+" is null and (select wage from rais_yb interno where interno.year=s.year-"+year+"  and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth_pct', "rais_yb", sql,cursor,count=True)
    
        #YW
        sql="select count(*) from rais_yo s where (  \
            (s.wage_growth_pct"+label+" is null and (select wage from rais_yo interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id) >0 ) \
            ) and year > 2000"     
        runCountQuery('checkGrowth', "rais_yo", sql,cursor,count=True)
        
        #YP
        sql="select count(*) from rais_yi s where (  \
            (s.wage_growth_pct"+label+" is null and (select wage from rais_yi interno where interno.year=s.year-"+year+"  and interno.isic_id = s.isic_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_yi", sql,cursor,count=True)
     
    
        #YBP
        sql="select count(*) from rais_ybi s where (  (  (s.wage_growth_pct"+label+" is null or s.num_emp_growth_pct"+label+" is null )  \
           and (select wage from rais_ybi interno where interno.year=s.year-"+year+"  and interno.isic_id = s.isic_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybi", sql,cursor,count=True)    
        
        
        #YBW
        sql="select count(*) from rais_ybo s where ( ( (s.wage_growth_pct"+label+" is null or s.num_emp_growth_pct"+label+" is null )  \
            and (select wage from rais_ybo interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id and interno.bra_id = s.bra_id) >0 ) \
             ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybo", sql,cursor,count=True)      
    
        #YBPW
        sql="select count(*) from rais_ybio s where (   (   (s.wage_growth_pct"+label+" is null or s.num_emp_growth_pct"+label+" is null )  \
           and (select wage from rais_ybio interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id and interno.isic_id = s.isic_id and interno.bra_id = s.bra_id) >0 ) \
            ) and year > 2000" 
        runCountQuery('checkGrowth', "rais_ybio", sql,cursor,count=True)     
    

#RCA: For all HS and all locations     
#Comparar com wage > 0 ?       
def checkRCA():  
    print "Entering in checkRCA"  
     
    sql="SELECT count(*) FROM rais_ybi where (num_emp > 0 and (rca is null or rca<=0) ) or (num_emp =0 and  rca is not null  );"
    runCountQuery('checkRCA', 'rais_ybi', sql,cursor,count=True)

        

#Distance: For all HS and all locations 
#Comparar com wage > 0 ?        
def checkDistance():  
    print "Entering in checkDistance"    

    sql="select count(*) from rais_ybi where (distance<0 or distance>1 ) \
        or ( distance is null  and length(isic_id)=5) or ( distance is not  null  and length(isic_id)<>5);" 
    runCountQuery('checkDistance', 'rais_ybi', sql,cursor,count=True)


#Opportunity: For all HS and all locations        
def checkOpportunity():  
    print "Entering in checkOpportunity"
    
    sql="select count(*) from rais_ybi where (opp_gain < -3.1 or opp_gain > 3.1 ) \
    or ( opp_gain is null  and length(isic_id)=4) or (   opp_gain is not null  and length(isic_id)<>6 ) "
    runCountQuery('checkOpportunity', 'rais_ybi', sql,cursor,count=True)


#PCI: For all HS    
def checkRequired():  
    print "Entering in checkRequired"
    
    sql="select count(*) from rais_ybio r where (required < 0 ) or ( required is null  and num_emp>0 and \
    (select importance from rais_yio where isic_id=r.isic_id and cbo_id=r.cbo_id)>=0.2) ;"
    runCountQuery('checkRequired', 'rais_ybio', sql,cursor,count=True)
   
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: Importance,Diversity,Growth,GrowthAnual,RCA,Distance,Opportunity,Required,Wage ',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method):
    if not method or method=='all':
        checkWage()
        checkImportance()
        checkDiversity()    
        checkGrowth()
        checkGrowthAnual()
        checkRCA()
        checkDistance()
        checkOpportunity()
        checkRequired()
    elif method=="Wage":
        checkWage()        
    elif method=="Importance":
        checkImportance()
    elif method=="Diversity":
        checkDiversity()
    elif method=="Growth":
        checkGrowth()
    elif method=="GrowthAnual":
        checkGrowthAnual()
    elif method=="RCA":
        checkRCA()
    elif method=="Distance":
        checkDistance()
    elif method=="Opportunity":
        checkOpportunity()
    elif method=="Required":
        checkRequired()
                                
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