# -*- coding: utf-8 -*-
"""
    Check all data in rais tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_3_indicators -m all
    If need to run just a specific check, run: python -m emprego.step_3_indicators -m ECI
    
    Run all methods for all years:
    python -m emprego.step_3_indicators -m all > ALlSecex.log
    
    
    Running one by one:
    
    python -m emprego.check.step_3_indicators -m Importance > Importance.log
    python -m emprego.check.step_3_indicators -m Diversity > Diversity.log
    python -m emprego.check.step_3_indicators -m Growth > Growth.log
    python -m emprego.check.step_3_indicators -m GrowthAnual > GrowthAnual.log    
    python -m emprego.check.step_3_indicators -m RCA > RCA.log
    python -m emprego.check.step_3_indicators -m Distance > Distance.log
    python -m emprego.check.step_3_indicators -m Opportunity > Opportunity.log
    python -m emprego.check.step_3_indicators -m Required > Required.log
    python -m emprego.check.step_3_indicators -m Wage > Wage.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    References about this check in https://github.com/DataViva/datavivaetl/wiki/emprego#indicators
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR,DATAVIVA_DB_USER,DATAVIVA_DB_PW,DATAVIVA_DB_NAME
from helpers import d, get_file, format_runtime,errorMessage,runCountQuery
import unittest

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER,  passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()


class EmpregoIndicators(unittest.TestCase):
        
    #ECI: for all exports regions and all years
    def test_Wage(self):
        print "Entering in checkWage"
        
        total=0
        sql="select count(*) from rais_yb where wage is null;"
        total+=runCountQuery('checkWage', 'rais_yb', sql,cursor,count=True) 
        
        sql="select count(*) from rais_ybi where wage is null;"
        total+=runCountQuery('checkWage', 'rais_ybi', sql,cursor,count=True) 
        
        sql="select count(*) from rais_ybio where wage is null;"
        total+=runCountQuery('checkWage', 'rais_ybio', sql,cursor,count=True) 
        
        sql="select count(*) from rais_ybo where wage is null;"
        total+=runCountQuery('checkWage', 'rais_ybo', sql,cursor,count=True) 
        
        sql="select count(*) from rais_yi where wage is null;"
        total+=runCountQuery('checkWage', 'rais_yi', sql,cursor,count=True) 
    
        sql="select count(*) from rais_yo where wage is null;"
        total+=runCountQuery('checkWage', 'rais_yo', sql,cursor,count=True) 
        
        self.assertEqual(total, 0)
        
    #ECI: for all exports regions and all years
    def test_Importance(self):
        print "Entering in checkImportance"
             
        sql="select count(*) from rais_yio where  cnae_id_len=5 and cbo_id_len=4 and ( (importance < 0 or importance > 1 ) \
        or ( importance is null  and num_emp>0) or (   importance is not null  and num_emp=0 ) ) "  
        total=runCountQuery('checkImportance', 'rais_yio', sql,cursor,count=True)
        self.assertEqual(total, 0)
    
    
    #Diversity (HS / WLD / BRA): too for Ocupations (CBO) and cnae
    def test_Diversity(self):  
        print "Entering in checkDiversity"
    
        total=0
        sql="SELECT count(*) FROM rais_yi where num_emp >0 and not (cbo_diversity >0 and cbo_diversity_eff >0 and bra_diversity>0  and bra_diversity_eff>0 );"
        total+=runCountQuery('checkDiversity', 'rais_yi', sql,cursor,count=True)
    
        sql="SELECT count(*) FROM rais_yb where num_emp >0 and not (cbo_diversity >0 and cbo_diversity_eff >0 and cnae_diversity>0  and cnae_diversity_eff>0 );"
        total+=runCountQuery('checkDiversity', 'rais_yb', sql,cursor,count=True)
    
        sql="SELECT count(*) FROM rais_yo where num_emp >0 and not (bra_diversity >0 and bra_diversity_eff >0 and cnae_diversity>0  and cnae_diversity_eff>0 );"
        total+=runCountQuery('checkDiversity', 'rais_yo', sql,cursor,count=True)
        
        self.assertEqual(total, 0)
       
    
        
    #Growth's: for wage, number of employes, wage
    # How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
    def test_GrowthAnual(self):  
        print "Entering in checkGrowthAnual"
        
        total=0
        #Anual - Check 
        aggsP = ["rais_yb","rais_ybi","rais_ybio","rais_ybo","rais_yi","rais_yo"]
        for aggs in aggsP:    
            sql="select count(*) from "+aggs+" s where ((wage_growth is null and s.wage is not null)  or ( s.num_emp is not null and  num_emp_growth is null)) and year > 2002"   
            #Check ir because all values that should be 0 is None  
            total+=runCountQuery('checkGrowth', aggs, sql,cursor,count=True)
            
        self.assertEqual(total, 0)
    
        
    def test_Growth(self):  
        print "Entering in checkGrowth"
        
        total=0
        
        #Anuaal
        years = [("5","_5"),("1","")]
        for vals in years:
            year=vals[0]
            label=vals[1]   
            #YB
            sql="select count(*) from rais_yb s where (  s.wage is not null and   \
                (s.wage_growth"+label+" is null and (select wage from rais_yb interno where interno.year=s.year-"+year+"  and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2002"     
            total+=runCountQuery('checkGrowth', "rais_yb:"+year+":"+label, sql,cursor,count=True)
        
            #YO
            sql="select count(*) from rais_yo s where (  s.wage is not null and   \
                (s.wage_growth"+label+" is null and (select wage from rais_yo interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id) >0 ) \
                ) and year > 2002"     
            total+=runCountQuery('checkGrowth', "rais_yo:"+year+":"+label, sql,cursor,count=True)
            
            #YI
            sql="select count(*) from rais_yi s where (  s.wage is not null and   \
                (s.wage_growth"+label+" is null and (select wage from rais_yi interno where interno.year=s.year-"+year+"  and interno.cnae_id = s.cnae_id) >0 ) \
                 ) and year > 2002" 
            total+=runCountQuery('checkGrowth', "rais_yi:"+year+":"+label, sql,cursor,count=True)
         
        
            #YBI
            sql="select count(*) from rais_ybi s where (  s.wage is not null and   (  (s.wage_growth"+label+" is null or s.num_emp_growth"+label+" is null )  \
               and (select wage from rais_ybi interno where interno.year=s.year-"+year+"  and interno.cnae_id = s.cnae_id and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2002" 
            total+=runCountQuery('checkGrowth', "rais_ybi:"+year+":"+label, sql,cursor,count=True)    
            
            
            #YBO
            sql="select count(*) from rais_ybo s where (  s.wage is not null and   ( (s.wage_growth"+label+" is null or s.num_emp_growth"+label+" is null )  \
                and (select wage from rais_ybo interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id and interno.bra_id = s.bra_id) >0 ) \
                 ) and year > 2002" 
            total+=runCountQuery('checkGrowth', "rais_ybo:"+year+":"+label, sql,cursor,count=True)      
        
            #YBIO
            sql="select count(*) from rais_ybio s where (  s.wage is not null and    (   (s.wage_growth"+label+" is null or s.num_emp_growth"+label+" is null )  \
               and (select wage from rais_ybio interno where interno.year=s.year-"+year+"  and interno.cbo_id = s.cbo_id and interno.cnae_id = s.cnae_id and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2002" 
            total+=runCountQuery('checkGrowth', "rais_ybio:"+year+":"+label, sql,cursor,count=True)    
            
        self.assertEqual(total, 0) 
        
    
    #RCA: For all HS and all locations     
    #Comparar com wage > 0 ?       
    def test_RCA(self):  
        print "Entering in checkRCA"  
         
        sql="SELECT count(*) FROM rais_ybi where (num_emp > 0 and (rca is null or rca<=0) ) or (num_emp =0 and  rca is not null  );"
        total=runCountQuery('checkRCA', 'rais_ybi', sql,cursor,count=True)

        self.assertEqual(total, 0)
            
    
    #Distance: For all HS and all locations 
    #Comparar com wage > 0 ?        
    def test_Distance(self):  
        print "Entering in checkDistance"    
    
        sql="select count(*) from rais_ybi where (distance<0 or distance>1 ) \
            or ( distance is null  and cnae_id_len=5) or ( distance is not  null  and cnae_id_len<>5);" 
        total=runCountQuery('checkDistance', 'rais_ybi', sql,cursor,count=True)
        
        self.assertEqual(total, 0)
    
    
    #Opportunity: For all HS and all locations        
    def test_Opportunity(self):  
        print "Entering in checkOpportunity"
        
        sql="select count(*) from rais_ybi where  ( opp_gain is null  and cnae_id_len=5) or (   opp_gain is not null  and cnae_id_len<>5) "
        total=runCountQuery('checkOpportunity', 'rais_ybi', sql,cursor,count=True)
        
        self.assertEqual(total, 0)
    
    
    #PCI: For all HS    
    def test_Required(self):  
        print "Entering in checkRequired"
        
        sql="select count(*) from rais_ybio r where (required < 0 ) or ( required is null  and num_emp>0 and \
        (select importance from rais_yio where cnae_id=r.cnae_id and cbo_id=r.cbo_id)>=0.2) ;"
        total=runCountQuery('checkRequired', 'rais_ybio', sql,cursor,count=True)
        
        self.assertEqual(total, 0)
       
            
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: Importance,Diversity,Growth,GrowthAnual,RCA,Distance,Opportunity,Required,Wage ',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method):
    cls=EmpregoIndicators()
    if not method or method=='all':
        cls.test_Wage()
        cls.test_Importance()
        cls.test_Diversity()    
        cls.test_Growth()
        cls.test_GrowthAnual()
        cls.test_RCA()
        cls.test_Distance()
        cls.test_Opportunity()
        #checkRequired()
    elif method=="Wage":
        cls.test_Wage()        
    elif method=="Importance":
        cls.test_Importance()
    elif method=="Diversity":
        cls.test_Diversity()
    elif method=="Growth":
        cls.test_Growth()
    elif method=="GrowthAnual":
        cls.test_GrowthAnual()
    elif method=="RCA":
        cls.test_RCA()
    elif method=="Distance":
        cls.test_Distance()
    elif method=="Opportunity":
        cls.test_Opportunity()
    elif method=="Required":
        cls.test_Required()
                                
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