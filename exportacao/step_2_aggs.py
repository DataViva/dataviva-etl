# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_2_aggs
    
    If need to run just a specific check, run: python -m exportacao.step_2_aggs -m BRAID
    
    
    Running one by one:
    
    python -m exportacao.step_2_aggs -m BRAID > BRAID.log
    python -m exportacao.step_2_aggs -m HSID > HSID.log
    python -m exportacao.step_2_aggs -m WLDID > WLDID.log
    
    YBPW - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    
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


'''
    BRA_ID

    * excluding on air products (bra_id xx)
    * length with size 2 cant be compered with others.. values from state exports are different than municipality
    * To compare 7 with 4,8 necessary to use table attrs_bra_pr
'''
def checkBRA_ID():

    print "Entering in checkBRA_ID"
    
    # YB: Check aggs 2 with 4
    sql="SELECT * FROM secex_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
        (SELECT sum(val_usd) FROM secex_yb \
        where length(bra_id)=8 and left(bra_id,4)=b.bra_id  and year=b.year \
        group by left(bra_id,4))"  
    runCountQuery('checkBRA_ID', 'secex_yb', sql,cursor)   


    
    #YBP - bra_id 2 x 4
    sql="SELECT * FROM secex_ybp as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(val_usd) FROM secex_ybp  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and hs_id=b.hs_id and year=b.year \
                    group by left(bra_id,4),length(hs_id),year)"
    runCountQuery('checkBRA_ID', 'secex_ybp', sql,cursor) 

    #YBW
    sql="SELECT * FROM secex_ybw as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(val_usd) FROM secex_ybw  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and wld_id=b.wld_id and year=b.year \
                    group by left(bra_id,4),length(wld_id),year)    "
    runCountQuery('checkBRA_ID', 'secex_ybw', sql,cursor) 
    

                
'''
    BRA_ID x Planning Regions
'''
def checkBRA_IDPR():    
    #YB 
    sql="SELECT * FROM secex_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=7 and b.val_usd <> \
        (SELECT sum(val_usd) FROM secex_yb s, attrs_bra_pr p \
        where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and \
            left(s.bra_id,4)=b.bra_id  and s.year=b.year group by left(s.bra_id,4))"
    runCountQuery('checkBRA_IDPR', 'secex_yb', sql,cursor) 

        
    #YBP - bra_id 2 x 4
    sql="SELECT * FROM secex_ybp as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(s.val_usd) FROM secex_ybp s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and  p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.hs_id=b.hs_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.hs_id),year)"
    runCountQuery('checkBRA_IDPR', 'secex_ybp', sql,cursor) 
    

    #YBW
    sql="SELECT * FROM secex_ybw as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(s.val_usd) FROM secex_ybw s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.wld_id=b.wld_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.wld_id),s.year)    "
    runCountQuery('checkBRA_IDPR', 'secex_ybw', sql,cursor) 
    


    #YBPW ??

def checkHS_ID():
    print "Entering in checkHS_ID"
    aggsP = [(2, 4),(4, 6)]
    for aggs in aggsP:    
        
        # YP: Check HS aggs 2 with 4
        sql="SELECT * FROM secex_yp as b where length(b.hs_id)="+str(aggs[0])+" and b.val_usd <> \
               (SELECT sum(val_usd) FROM secex_yp \
            where length(hs_id)="+str(aggs[1])+" and left(hs_id,"+str(aggs[0])+")=b.hs_id  and year=b.year \
            group by left(hs_id,"+str(aggs[0])+"))" 
        runCountQuery('checkHS_ID', 'secex_yp', sql,cursor) 
            
        
        # YBP: Check HS aggs 2 with 4
        sql="SELECT * FROM secex_ybp as b where length(b.hs_id)="+str(aggs[0])+" and b.val_usd <> \
               (SELECT sum(val_usd) FROM secex_ybp \
            where length(hs_id)="+str(aggs[1])+" and left(hs_id,"+str(aggs[0])+")=b.hs_id and bra_id=b.bra_id  and year=b.year \
            group by left(hs_id,"+str(aggs[0])+"),length(bra_id),year)"   
        runCountQuery('checkHS_ID', 'secex_ybp', sql,cursor) 
                    

    #YBPW

def checkWLD_ID():
    
    print "Entering in checkWLD_ID"
    
    # YW: Check WLD aggs 2 with 5
    sql="SELECT * FROM secex_yw as b where length(b.wld_id)=2 and b.val_usd <> \
           (SELECT sum(val_usd) FROM secex_yw \
        where length(wld_id)=5 and left(wld_id,2)=b.wld_id  and year=b.year \
        group by left(wld_id,2))"    
    runCountQuery('checkWLD_ID', 'secex_yw', sql,cursor) 

        

    # YBW: Check WLD aggs 2 with 5
    sql="SELECT * FROM secex_ybw as b where length(b.wld_id)=2 and b.val_usd <> \
           (SELECT sum(val_usd) FROM secex_ybw \
        where length(wld_id)=5 and left(wld_id,2)=b.wld_id and bra_id=b.bra_id  and year=b.year \
        group by left(wld_id,2),length(bra_id),year)"   
    runCountQuery('checkWLD_ID', 'secex_ybw', sql,cursor) 
    
            
    #YPBW ??


@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: BRAID , HSID ,WLDID ',required=False)
def main(method):
    if not method or method=='all':
        checkBRA_ID()
        checkHS_ID()
        checkWLD_ID()  
    elif method=="BRAID":
        checkBRA_ID()        
    elif method=="HSID":
        checkHS_ID()
    elif method=="WLDID":
        checkWLD_ID()

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;