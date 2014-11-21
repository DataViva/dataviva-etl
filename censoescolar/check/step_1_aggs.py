# -*- coding: utf-8 -*-
"""
    Check all data in SC tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m censoescolar.step_1_aggs
    
    If need to run just a specific check, run: python -m censoescolar.step_1_aggs -m BRAID
    
    
    Running one by one:
    python -m censoescolar.check.step_1_aggs -m all > allstep2exp.log
    python -m censoescolar.check.step_1_aggs -m BRAID > BRAID.log
    python -m censoescolar.check.step_1_aggs -m HSID > HSID.log
    python -m censoescolar.check.step_1_aggs -m WLDID > WLDID.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    
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
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER, passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()

class CensoEscolarAggs(unittest.TestCase):     
    '''
        BRA_ID
    '''
    def test_BRA_ID():
    
        print "Entering in checkBRA_ID"
        
        # YMB: Check aggs 2 with 4 (2,7,8)
        sql="SELECT count(*) FROM sc_ybscd b where length(b.bra_id)=2 and b.enrolled <> ( \
        select sum(enrolled) from sc_ybscd where length(bra_id)=8 and left(bra_id,2)=b.bra_id and \
        b.d_id=d_id and b.year=year and b.course_id=course_id and b.school_id=school_id  \
        group by year,bra_id,school_id,course_id,d_id limit 1)"  
        runCountQuery('checkBRA_ID', 'secex_ymb', sql,cursor,count=True)   
    
    
    
                    
    '''
        BRA_ID x Planning Regions
    '''
    def test_BRA_IDPR():    
        #YB 
        sql="SELECT count(*) FROM secex_ymb as b where left(bra_id,2)<>'xx' and b.bra_id_len=7 and concat(CAST(b.import_val AS CHAR),CAST(b.export_val AS CHAR )) <> \
            (SELECT concat(CAST(import_val AS CHAR),CAST(export_val AS CHAR )) FROM secex_ymb s, attrs_bra_pr p \
            where p.bra_id = s.bra_id and p.pr_id = b.bra_id and s.bra_id_len=8 and \
                left(s.bra_id,4)=b.bra_id  and s.year=b.year and s.month=b.month group by left(s.bra_id,4))"
        runCountQuery('checkBRA_IDPR', 'secex_ymb', sql,cursor,count=True) 
    
           
    
    def test_HS_ID():
        print "Entering in checkHS_ID"
        aggsP = [(2, 6)]#2,6  [(2, 4),(4, 6)]
        for aggs in aggsP:    
            
            # YP: Check HS aggs 2 with 4
            sql="SELECT count(*) FROM secex_ymp as b where b.hs_id_len="+str(aggs[0])+" and concat(CAST(b.import_val AS CHAR),CAST(b.export_val AS CHAR )) <> \
                   (SELECT concat(CAST(import_val AS CHAR),CAST(export_val AS CHAR )) FROM secex_ymp \
                where hs_id_len="+str(aggs[1])+" and left(hs_id,"+str(aggs[0])+")=b.hs_id and month=b.month  and year=b.year \
                group by left(hs_id,"+str(aggs[0])+"))" 
            runCountQuery('checkHS_ID', 'secex_ymp:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 
                
            
    
    def test_WLD_ID():
        
        print "Entering in checkWLD_ID"
        
        # YMW: Check WLD aggs 2 with 5
        sql="SELECT count(*) FROM secex_ymw as b where b.wld_id_len=2 and concat(CAST(b.import_val AS CHAR),CAST(b.export_val AS CHAR )) <> \
               (SELECT concat(CAST(import_val AS CHAR),CAST(export_val AS CHAR )) FROM secex_ymw \
            where wld_id_len=5 and left(wld_id,2)=b.wld_id and month=b.month  and year=b.year \
            group by left(wld_id,2))"    
        runCountQuery('checkWLD_ID', 'secex_ymw', sql,cursor,count=True)
            

@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: BRAID , HSID ,WLDID ',required=False)
def main(method):
    cls=CensoEscolarAggs()
    if not method or method=='all':
        cls.test_BRA_ID()
        cls.test_HS_ID()
        cls.test_WLD_ID()  
    elif method=="BRAID":
        cls.test_BRA_ID()        
    elif method=="HSID":
        cls.test_HS_ID()
    elif method=="WLDID":
        cls.test_WLD_ID()

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;