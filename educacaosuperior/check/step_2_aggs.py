# -*- coding: utf-8 -*-
"""
    Check all data in EI tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m nfe.check.step_2_aggs
    
    If need to run just a specific check, run: python -m emprego.step_2_aggs -m BRAID
    
    
    Running one by one:
    
    python -m nfe.check.step_2_aggs -m BRA > BRA.log
    
    YBIO - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    
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


class EducacaoSuperiorAggs(unittest.TestCase):  
    '''
        BRA_ID
    
        * excluding on air products (bra_id xx)
        * length with size 2 cant be compered with others.. values from state exports are different than municipality
        * To compare 7 with 4,8 necessary to use table attrs_bra_pr
    '''
    def test_BRA_ID(self):
    
        print "Entering in checkBRA_ID"
        total=0
        #YMR
        sql="SELECT * FROM ei_ymr r where length(r.bra_id_r) =3 and r.purchase_value <> \
        (SELECT sum(purchase_value) FROM ei_ymr s where length(s.bra_id_r) =9 \
         and left(s.bra_id_r,3)= r.bra_id_r and r.month=s.month and r.year=s.year)"
        total+=runCountQuery('checkBRA_ID', 'ei_ymr', sql,cursor,count=True)
    
        #YMRP
        sql="SELECT * FROM ei_ymrp r where length(r.bra_id_r) =3 and r.purchase_value <> \
        (SELECT sum(purchase_value) FROM ei_ymrp s where length(s.bra_id_r) =9 \
        and left(s.bra_id_r,3)= r.bra_id_r and r.month=s.month and r.year=s.year \
        and r.hs_id = s.hs_id)"
        total+=runCountQuery('checkBRA_ID', 'ei_ymrp', sql,cursor,count=True)
        
        self.assertEqual(total, 0)
        
        
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybd where d_id in ('A','B') and bra_id_len=9 group by 1,2;
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybc where course_id_len=6 and bra_id_len=9 group by 1,2;
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybu where bra_id_len=9 group by 1,2;  
    
    
    '''
    
    SELECT * FROM hedu_yc c where course_id_len=6 and enrolled<> (
        SELECT sum(b.enrolled) FROM hedu_ybc b where b.course_id_len=6 and b.bra_id_len=9 
        and b.course_id = c.course_id and b.year=c.year    group by b.year,b.course_id);
        
    SELECT * FROM hedu_yd c where  enrolled<> (
        SELECT sum(b.enrolled) FROM hedu_ybd b where b.bra_id_len=9 
        and b.d_id = c.d_id and b.year=c.year    group by b.year,b.d_id);
        
        
    SELECT * FROM hedu_ybu c where  enrolled<> (
        SELECT sum(b.enrolled) FROM hedu_ybuc b where b.bra_id_len=9 and b.course_id_len=6 
        and b.bra_id = c.bra_id and b.university_id = c.university_id and 
        b.year=c.year    group by b.year,b.bra_id,b.university_id);
        
        
    SELECT * FROM hedu_ybu c where c.bra_id_len=9 and  enrolled= (
        SELECT sum(b.enrolled) FROM hedu_ybucd b where b.bra_id_len=9 and b.course_id_len=6 
        and b.bra_id = c.bra_id and b.university_id = c.university_id and b.d_id in ('A','B') and
        b.year=c.year    group by b.year,b.bra_id,b.university_id,b.d_id);
    '''
                    
    '''
        BRA_ID x Planning Regions
        len 3 - state and len9 - 
    '''
    def test_BRA_IDPR(self):    
        
        print "Entering in checkBRA_IDPR"
    
        #YBPW ??    
    
    
    def test_CNAE_ID(self):
        print "Entering in checkCNAE_ID"
        total=0
        # YMR: Check cnae aggs
        aggsP = ['ei_ymrp', 'ei_ymsr']
        for aggs in aggsP:    
            sql="SELECT count(*) FROM ei_ymr r where r.purchase_value <> \
            (select sum(purchase_value) from "+aggs+" p where r.year=p.year and r.month=p.month \
            and r.bra_id_r = p.bra_id_r  and r.cnae_id_r = p.cnae_id_r);"
            total+=runCountQuery('test_CNAE_ID', 'ei_ymr: '+aggs, sql,cursor,count=True) 
            
        # YMP: Check cnae aggs
        aggsP = ['ei_ymrp', 'ei_ymsp']
        for aggs in aggsP:    
            sql="SELECT count(*) FROM ei_ymp r where r.purchase_value <> \
            (select sum(purchase_value) from "+aggs+" p where r.year=p.year and r.month=p.month \
            and r.hs_id = p.hs_id );"
            total+=runCountQuery('test_CNAE_ID', 'ei_ymp: '+aggs, sql,cursor,count=True) 
                
        # YMS: Check cnae aggs
        aggsP = ['ei_ymsp', 'ei_ymsr']
        for aggs in aggsP:    
            sql="SELECT count(*) FROM ei_yms r where r.purchase_value <> \
            (select sum(purchase_value) from "+aggs+" p where r.year=p.year and r.month=p.month \
            and r.bra_id_s = p.bra_id_s  and r.cnae_id_s = p.cnae_id_s);"
            total+=runCountQuery('test_CNAE_ID', 'ei_yms: '+aggs, sql,cursor,count=True) 
            
        self.assertEqual(total, 0)
            
            
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: BRA , CNAE, HSID ',required=False)
def main(method):
    cls=EducacaoSuperiorAggs()
    if not method or method=='all':
        cls.test_BRA_ID()
        cls.test_CNAE_ID()
        cls.test_HS_ID()  
    elif method=="BRA":
        cls.test_BRA_ID()     
    elif method=="CNAE":
        cls.test_CNAE_ID()
    elif method=="HSID":
        cls.test_HS_ID()

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;