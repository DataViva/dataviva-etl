# -*- coding: utf-8 -*-
"""
    Check all data in RAIS tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_2_aggs
    
    If need to run just a specific check, run: python -m emprego.step_2_aggs -m BRAID
    
    
    Running one by one:
    
    python -m emprego.step_2_aggs -m BRAID > BRAID.log
    python -m emprego.step_2_aggs -m ISICID > ISICID.log
    python -m emprego.step_2_aggs -m CBOID > CBOID.log
    
    YBIO - Is the only table that is not in this check script. We need to find a viable way to do this check in this hude table
    
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
    sql="SELECT * FROM rais_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
        (SELECT sum(wage) FROM rais_yb \
        where length(bra_id)=8 and left(bra_id,4)=b.bra_id  and year=b.year \
        group by left(bra_id,4))"  
    runCountQuery('checkBRA_ID', 'rais_yb', sql,cursor)   


    
    #YBP - bra_id 2 x 4
    sql="SELECT * FROM rais_ybi as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(wage) FROM rais_ybi  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and isic_id=b.isic_id and year=b.year \
                    group by left(bra_id,4),length(isic_id),year)"
    runCountQuery('checkBRA_ID', 'rais_ybi', sql,cursor) 

    #YBW
    sql="SELECT * FROM rais_ybo as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(wage) FROM rais_ybo  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and cbo_id=b.cbo_id and year=b.year \
                    group by left(bra_id,4),length(cbo_id),year)    "
    runCountQuery('checkBRA_ID', 'rais_ybo', sql,cursor) 
    

                
'''
    BRA_ID x Planning Regions
'''
def checkBRA_IDPR():    
    #YB 
    sql="SELECT * FROM rais_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=7 and b.wage <> \
        (SELECT sum(wage) FROM rais_yb s, attrs_bra_pr p \
        where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and \
            left(s.bra_id,4)=b.bra_id  and s.year=b.year group by left(s.bra_id,4))"
    runCountQuery('checkBRA_IDPR', 'rais_yb', sql,cursor) 

        
    #YBP - bra_id 2 x 4
    sql="SELECT * FROM rais_ybi as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(s.wage) FROM rais_ybp s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and  p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.isic_id=b.isic_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.isic_id),year)"
    runCountQuery('checkBRA_IDPR', 'rais_ybp', sql,cursor) 
    

    #YBW
    sql="SELECT * FROM rais_ybo as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(s.wage) FROM rais_ybo s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.cbo_id=b.cbo_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.cbo_id),s.year)    "
    runCountQuery('checkBRA_IDPR', 'rais_ybw', sql,cursor) 
    


    #YBPW ??

def checkISIC_ID():
    print "Entering in checkISIC_ID"
    aggsP = [(2, 4),(4, 6)]
    for aggs in aggsP:    
        
        # YP: Check HS aggs 2 with 4
        sql="SELECT * FROM rais_yi as b where length(b.isic_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_yi \
            where length(isic_id)="+str(aggs[1])+" and left(isic_id,"+str(aggs[0])+")=b.isic_id  and year=b.year \
            group by left(isic_id,"+str(aggs[0])+"))" 
        runCountQuery('checkHS_ID', 'rais_yp', sql,cursor) 
            
        
        # YBP: Check HS aggs 2 with 4
        sql="SELECT * FROM rais_ybi as b where length(b.isic_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_ybi \
            where length(isic_id)="+str(aggs[1])+" and left(isic_id,"+str(aggs[0])+")=b.isic_id and bra_id=b.bra_id  and year=b.year \
            group by left(isic_id,"+str(aggs[0])+"),length(bra_id),year)"   
        runCountQuery('checkHS_ID', 'rais_ybp', sql,cursor) 
                    

    #YBPW

def checkCBO_ID():
    
    print "Entering in checkCBO_ID"
    
    # YW: Check WLD aggs 2 with 5
    sql="SELECT * FROM rais_yo as b where length(b.cbo_id)=2 and b.wage <> \
           (SELECT sum(wage) FROM rais_yo \
        where length(cbo_id)=5 and left(cbo_id,2)=b.cbo_id  and year=b.year \
        group by left(cbo_id,2))"    
    runCountQuery('checkWLD_ID', 'rais_yw', sql,cursor) 

        

    # YBW: Check WLD aggs 2 with 5
    sql="SELECT * FROM rais_ybo as b where length(b.cbo_id)=2 and b.wage <> \
           (SELECT sum(wage) FROM rais_ybo \
        where length(cbo_id)=5 and left(cbo_id,2)=b.cbo_id and bra_id=b.bra_id  and year=b.year \
        group by left(cbo_id,2),length(bra_id),year)"   
    runCountQuery('checkWLD_ID', 'rais_ybw', sql,cursor) 
    
            
    #YPBW ??


@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: BRAID , ISICID ,CBOID ',required=False)
def main(method):
    if not method or method=='all':
        checkBRA_ID()
        checkISIC_ID()
        checkCBO_ID()  
    elif method=="BRAID":
        checkBRA_ID()        
    elif method=="ISICID":
        checkISIC_ID()
    elif method=="CBOID":
        checkCBO_ID()

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;