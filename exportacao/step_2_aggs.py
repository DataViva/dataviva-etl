# -*- coding: utf-8 -*-
"""
    Check all data in SECEX tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m exportacao.step_2_aggs
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2
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

# BRA_ID
def checkBRA_ID():

    print "Entering in checkBRA_ID"
    # YB: Check aggs 2 with 4, excluding on air products (bra_id xx)
    sql="SELECT * FROM secex_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
        (SELECT sum(val_usd) FROM secex_yb \
        where length(bra_id)=8 and left(bra_id,4)=b.bra_id  and year=b.year \
        group by left(bra_id,4))"  
    print sql  
    cursor.execute(sql)
    values=cursor.fetchall()
    size=len(values)
    if size>0:          
        print "checkBRA_ID: Error in YB"

    #YBP - bra_id 4 x 8
    sql="SELECT * FROM secex_ybp as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(val_usd) FROM secex_ybp  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and hs_id=b.hs_id and year=b.year \
                    group by left(bra_id,4),length(hs_id),year)"
    print sql
    cursor.execute(sql)
    values=cursor.fetchall()
    size=len(values)
    if size>0:          
        print "checkBRA_ID: Error in YBP "

    #YBW
    sql="SELECT * FROM secex_ybw as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.val_usd <> \
            (SELECT sum(val_usd) FROM secex_ybw  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and wld_id=b.wld_id and year=b.year \
                    group by left(bra_id,4),length(wld_id),year)    "
    print sql
    cursor.execute(sql)
    values=cursor.fetchall()
    size=len(values)
    if size>0:          
        print "checkBRA_ID: Error in YBP "
                
    
    #YBPW


def checkHS_ID():
    print "Entering in checkHS_ID"
    aggsP = [(2, 4),(4, 6)]
    for aggs in aggsP:    
    
        # YP: Check HS aggs 2 with 4
        sql="SELECT * FROM secex_yp as b where length(b.hs_id)="+str(aggs[0])+" and b.val_usd <> \
               (SELECT sum(val_usd) FROM secex_yp \
            where length(hs_id)="+str(aggs[1])+" and left(hs_id,"+str(aggs[0])+")=b.hs_id  and year=b.year \
            group by left(hs_id,"+str(aggs[0])+"))"   
        print sql 
        cursor.execute(sql)
        values=cursor.fetchall()
        size=len(values)
        if size>0:          
            print "Error checkYB , BRA_ID"
            

    #YBP
    #YBPW

def checkWLD_ID():
    
    print "Entering in checkWLD_ID"
    # YW: Check WLD aggs 2 with 5
    sql="SELECT * FROM secex_yw as b where length(b.wld_id)=2 and b.val_usd <> \
           (SELECT sum(val_usd) FROM secex_yw \
        where length(wld_id)=5 and left(wld_id,2)=b.wld_id  and year=b.year \
        group by left(wld_id,2))"    
    cursor.execute(sql)
    values=cursor.fetchall()
    size=len(values)
    if size>0:          
        print "checkWLD_ID: Error in YW"  
        

    #YBW
    #YPBW


if __name__ == "__main__":
    start = time.time()

    checkBRA_ID()
    #checkHS_ID()
    #checkWLD_ID()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;