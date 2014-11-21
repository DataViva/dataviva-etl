# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_3_indicators -m all
    If need to run just a specific check, run: python -m exportacao.step_3_indicators -m ECI
    
    Running one by one:
    
    python -m exportacao.check.step_3_indicators -m all
    python -m exportacao.check.step_3_indicators -m ECI > ECI.log
    python -m exportacao.check.step_3_indicators -m Diversity > Diversity.log
    python -m exportacao.check.step_3_indicators -m Growth > Growth.log
    python -m exportacao.check.step_3_indicators -m RCA > RCA.log
    python -m exportacao.check.step_3_indicators -m Distance > Distance.log
    python -m exportacao.check.step_3_indicators -m Opportunity > Opportunity.log
    python -m exportacao.check.step_3_indicators -m PCI > PCI.log
    python -m exportacao.check.step_3_indicators -m ValUSD > ValUSD.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    References about this check in https://github.com/DataViva/datavivaetl/wiki/Exportacao#indicators
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR,DATAVIVA_DB_USER,DATAVIVA_DB_PW,DATAVIVA_DB_NAME
from helpers import d, get_file, format_runtime,errorMessage,runCountQuery
import unittest
#from scripts import YEAR

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER, passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()

    
class ExportIndicators(unittest.TestCase):   
    #ECI: for all exports regions and all years
    def test_ValUSD(self):
        print "Entering in checkValUSD"
        
        total=0
        sql="select count(*) from secex_ymb where export_val is null or import_val is null;"
        total+=runCountQuery('checkValUSD', 'secex_ymb', sql,cursor,True) 
        
        sql="select count(*) from secex_ymbp where export_val is null or import_val is null;"
        total+=runCountQuery('checkValUSD', 'secex_ymbp', sql,cursor,True) 
        
        
        sql="select count(*) from secex_ymbpw where export_val is null or import_val is null;"
        total+=runCountQuery('checkValUSD', 'secex_ymbpw', sql,cursor,True) 
        
        sql="select count(*) from secex_ymbw where export_val is null or import_val is null;"
        total+=runCountQuery('checkValUSD', 'secex_ymbw', sql,cursor,True) 
        
        sql="select count(*) from secex_ymp where export_val is null or import_val is null;"
        total+=runCountQuery('checkValUSD', 'secex_ymp', sql,cursor,True) 
        
        self.assertEqual(total, 0)

        
    #ECI: for all exports regions and all years
    def test_ECI(self):
        print "Entering in checkECI"
        
        total=0
             
        sql="select count(*) from secex_ymb b where (b.eci is null or b.eci < -3.1 or b.eci > 3.1) \
            and b.export_val >0 and b.bra_id in (select bra_id from secex_ymbp where rca>=1 and month=b.month and year=b.year group by bra_id) "  
        total+=runCountQuery('checkECI', 'secex_ymb', sql,cursor,True)
        
            
        sql="select count(*) from secex_ymw where (eci is null or eci < -3.1 or eci > 3.1) and export_val >0"  
        total+=runCountQuery('checkECI', 'secex_ymw', sql,cursor,True)
        
        self.assertEqual(total, 0)
    
    
    #Diversity (HS / WLD / BRA): too for Ocupations (CBO) and ISIC
    def test_Diversity(self):  
        print "Entering in checkDiversity"
        
        total=0
    
        sql="select count(*) from secex_ymb where \
                (hs_diversity is null or hs_diversity <0 or \
                hs_diversity_eff is null or hs_diversity_eff<0 or \
                wld_diversity is null or wld_diversity<0 or \
                wld_diversity_eff is null or wld_diversity_eff<0) ;"
        total+=runCountQuery('checkDiversity', 'secex_ymb', sql,cursor,True)
        
    
        sql="select count(*) from secex_ymp where \
            bra_diversity is null or bra_diversity <0 or \
            bra_diversity_eff is null or bra_diversity_eff<0 or \
            wld_diversity is null or wld_diversity<0 or \
            wld_diversity_eff is null or wld_diversity_eff<0;"
        total+=runCountQuery('checkDiversity', 'secex_ymp', sql,cursor,True)
    
    
        sql="select count(*) from secex_ymw where \
                bra_diversity is null or bra_diversity<0 or \
                bra_diversity_eff is null or bra_diversity_eff<0 or \
                hs_diversity is null or hs_diversity<0 or \
                hs_diversity_eff is null or hs_diversity_eff<0; "
        total+=runCountQuery('checkDiversity', 'secex_ymw', sql,cursor,True)
        
        self.assertEqual(total, 0)
       
    
        
    #Growth's: for val_usd, number of employes, wage
    # How to calc considering year for 5 years growth and for 1 year gorwth ignore first year
    def test_Growth(self):  
        print "Entering in checkGrowth"
        
        total=0
        
        #Anual - Check 
        aggsP = ["secex_ymb","secex_ymbp","secex_ymbpw","secex_ymbw","secex_ymp","secex_ymw"]
        for aggs in aggsP:    
            sql="select count(*) from "+aggs+" s where export_val_growth_val is null and year > 2000"   
            #Check ir because all values that should be 0 is None  
            #runCountQuery('checkGrowth_val', aggs, sql)
    
    
        #Anuaal
        years = [("5","_5"),("1","")]
        for vals in years:
            year=vals[0]
            label=vals[1]   
            #YMB
            sql="select count(*) from secex_ymb s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymb interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2000"     
            total+=runCountQuery('checkGrowth_pct', "secex_ymb", sql,cursor,True)
        
            #YMW
            sql="select count(*) from secex_ymw s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymw interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id) >0 ) \
                ) and year > 2000"     
            total+=runCountQuery('checkGrowth', "secex_ymw", sql,cursor,True)
            
            #YMP
            sql="select count(*) from secex_ymp s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymp interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id) >0 ) \
                 ) and year > 2000" 
            total+=runCountQuery('checkGrowth', "secex_ymp", sql,cursor,True)
         
        
            #YMBP These 3 sql are taking too long! so disabled
            sql="select count(*) from secex_ymbp s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymbp interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2000" 
            #total+=runCountQuery('checkGrowth', "secex_ymbp", sql,cursor,True)    
            
            
            #YMBW
            sql="select count(*) from secex_ymbw s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymbw interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.bra_id = s.bra_id) >0 ) \
                 ) and year > 2000" 
            #total+=runCountQuery('checkGrowth', "secex_ymbw", sql,cursor,True)      
        
            #YMBPW
            sql="select count(*) from secex_ymbpw s where (  \
                (s.export_val_growth_pct"+label+" is null and (select export_val from secex_ymbpw interno where interno.month=s.month and interno.year=s.year-"+year+"  and interno.wld_id = s.wld_id and interno.hs_id = s.hs_id and interno.bra_id = s.bra_id) >0 ) \
                ) and year > 2000" 
            #total+=runCountQuery('checkGrowth', "secex_ymbpw", sql,cursor,True)     
        
        self.assertEqual(total, 0)
    
    #RCA: For all HS and all locations     
    #Comparar com val_usd > 0 ?       
    def test_RCA(self):  
        print "Entering in checkRCA" 
        
        total=0 
         
        sql="select count(*) from secex_ymbp where (export_val > 0 and (rca is null or rca<=0 or rca_wld is null or rca_wld<=0) ) \
             or (export_val =0 and ( rca_wld is not null or rca is not null ) ) ;"
        total+=runCountQuery('checkRCA', 'secex_ymbp', sql,cursor,True)
    
            
        sql="select count(*) from secex_ymp where (export_val > 0 and (rca_wld is null or rca_wld<=0) ) or (export_val =0 and rca_wld is not null);"
        total+=runCountQuery('checkRCA', 'secex_ymp', sql,cursor,True)
        
        self.assertEqual(total, 0)
            
    
    #Distance: For all HS and all locations 
    #Comparar com val_usd > 0 ?        
    def test_Distance(self):  
        print "Entering in checkDistance"    
        
        total=0
    
        sql="select count(*) from secex_ymbp where (distance_wld<0 or distance_wld>1 or distance<0 or distance>1 ) \
            or ( (distance_wld is null or distance is null)  and hs_id_len=6) or ( (distance_wld is not null or distance is not  null)  and hs_id_len<>6);" 
        total+=runCountQuery('checkDistance', 'secex_ymbp', sql,cursor,True)
        
        self.assertEqual(total, 0)
    
    
    #Opportunity: For all HS and all locations        
    def test_Opportunity(self):  
        print "Entering in checkOpportunity"
        
        total=0
        
        sql="select count(*) from secex_ymbp where (opp_gain < -3.1 or opp_gain > 3.1 or opp_gain_wld < -3.1 or opp_gain_wld > 3.1 ) \
                                   or ( (opp_gain is null or opp_gain_wld is null) and hs_id_len=6) or (  ( opp_gain_wld is not null or opp_gain is not null)  and hs_id_len<>6 ) "
        total+=runCountQuery('checkOpportunity', 'secex_ymbp', sql,cursor,True)
        
        self.assertEqual(total, 0)
    
    
    #PCI: For all HS    
    def test_PCI(self):  
        print "Entering in checkPCI"
        
        total=0
        
        sql="select count(*) from secex_ymp where (pci is null and hs_id_len=6) or (pci is not null and hs_id_len<>6) or (pci < -3.1 or pci > 3.1) ;"
        total+=runCountQuery('checkPCI', 'secex_ymp', sql,cursor,True)
        
        self.assertEqual(total, 0)
       
        
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: ECI,Diversity,Growth,RCA,Distance,Opportunity,PCI,ValUSD ',required=False)
#@click.argument('method', type=click.Path(exists=True))
def main(method):
    expclass=ExportIndicators()
    if not method or method=='all':
        expclass.test_ValUSD()
        expclass.test_ECI()
        expclass.test_Diversity()    
        expclass.test_Growth()
        expclass.test_RCA()
        expclass.test_Distance()
        expclass.test_Opportunity()
        expclass.test_PCI()
    elif method=="ValUSD":
        expclass.test_ValUSD()        
    elif method=="ECI":
        expclass.test_ECI()
    elif method=="Diversity":
        expclass.test_Diversity()
    elif method=="Growth":
        expclass.test_Growth()
    elif method=="RCA":
        expclass.test_RCA()
    elif method=="Distance":
        expclass.test_Distance()
    elif method=="Opportunity":
        expclass.test_Opportunity()
    elif method=="PCI":
        expclass.test_PCI()
                                
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