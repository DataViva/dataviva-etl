# -*- coding: utf-8 -*-
"""
    Check all data in RAIS tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m emprego.step_2_aggs
    
    If need to run just a specific check, run: python -m emprego.step_2_aggs -m BRAID
    
    
    Running one by one:
    
    python -m emprego.step_2_aggs -m BRA > BRA.log
    python -m emprego.step_2_aggs -m BRAPR > BRAPR.log
    python -m emprego.step_2_aggs -m CNAE > CNAE.log
    python -m emprego.step_2_aggs -m CBO > CBO.log
    
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


    
    #YBI - bra_id 2 x 4
    sql="SELECT * FROM rais_ybi as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(wage) FROM rais_ybi  \
                    where length(bra_id)=8 and left(bra_id,4)=b.bra_id \
                    and cnae_id=b.cnae_id and year=b.year \
                    group by left(bra_id,4),length(cnae_id),year)"
    runCountQuery('checkBRA_ID', 'rais_ybi', sql,cursor) 

    #YBO
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
    
    print "Entering in checkBRA_IDPR"
    #YB 
    sql="SELECT * FROM rais_yb as b where left(bra_id,2)<>'xx' and length(b.bra_id)=7 and b.wage <> \
        (SELECT sum(wage) FROM rais_yb s, attrs_bra_pr p \
        where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and \
            left(s.bra_id,4)=b.bra_id  and s.year=b.year group by left(s.bra_id,4))"
    runCountQuery('checkBRA_IDPR', 'rais_yb', sql,cursor) 

        
    #YBI - bra_id 2 x 4
    sql="SELECT * FROM rais_ybi as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(s.wage) FROM rais_ybi s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and  p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.cnae_id=b.cnae_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.cnae_id),year)"
    runCountQuery('checkBRA_IDPR', 'rais_ybi', sql,cursor) 
    

    #YBO
    sql="SELECT * FROM rais_ybo as b \
        where left(bra_id,2)<>'xx' and length(b.bra_id)=4 and b.wage <> \
            (SELECT sum(s.wage) FROM rais_ybo s, attrs_bra_pr p   \
                    where p.bra_id = s.bra_id and p.pr_id = b.bra_id and length(s.bra_id)=8 and left(s.bra_id,4)=b.bra_id \
                    and s.cbo_id=b.cbo_id and s.year=b.year \
                    group by left(s.bra_id,4),length(s.cbo_id),s.year)    "
    runCountQuery('checkBRA_IDPR', 'rais_ybo', sql,cursor) 
    


    #YBPW ??

def checkCNAE_ID():
    print "Entering in checkCNAE_ID"
    aggsP = [(1, 3),(3, 5)]
    for aggs in aggsP:    
        
        # YI: Check cnae aggs 
        sql="SELECT count(*) FROM rais_yi as b where length(b.cnae_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_yi \
            where length(cnae_id)="+str(aggs[1])+" and left(cnae_id,"+str(aggs[0])+")=b.cnae_id  and year=b.year \
            group by left(cnae_id,"+str(aggs[0])+"))" 
        #runCountQuery('checkcnae_ID', 'rais_yi:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 
            
        
        # YBI: Check cnae aggs 
        sql="SELECT count(*) FROM rais_ybi as b where length(b.cnae_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_ybi \
            where length(cnae_id)="+str(aggs[1])+" and left(cnae_id,"+str(aggs[0])+")=b.cnae_id and bra_id=b.bra_id  and year=b.year \
            group by left(cnae_id,"+str(aggs[0])+"),length(bra_id),year)"   
        #runCountQuery('checkcnae_ID', 'rais_ybi:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 
                    
        #YBIO
        sql="SELECT count(*) FROM rais_ybio as b where length(b.cnae_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_ybio \
            where length(cnae_id)="+str(aggs[1])+" and left(cnae_id,"+str(aggs[0])+")=b.cnae_id and bra_id=b.bra_id and cbo_id=b.cbo_id  \
            and cbo_id=b.cbo_id and year=b.year   group by left(cnae_id,"+str(aggs[0])+"),length(bra_id),length(cbo_id),year)"   
        runCountQuery('checkcnae_ID', 'rais_ybio:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 
        
        # YIO: Check cnae aggs 
        sql="SELECT count(*) FROM rais_yio as b where length(b.cnae_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_yio \
            where length(cnae_id)="+str(aggs[1])+" and left(cnae_id,"+str(aggs[0])+")=b.cnae_id and cbo_id=b.cbo_id  and year=b.year \
            group by left(cnae_id,"+str(aggs[0])+"),length(cbo_id),year)"   
        runCountQuery('checkcnae_ID', 'rais_ybi:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True)     

def checkCBO_ID():
    
    print "Entering in checkCBO_ID"

    #Checking aggs in same table
    aggsP = [(1, 2),(2, 4)]
    for aggs in aggsP: 
            
        # YO: Check WLD aggs 2 with 4
        sql="SELECT count(*) FROM rais_yo as b where length(b.cbo_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_yo \
            where length(cbo_id)="+str(aggs[1])+" and left(cbo_id,"+str(aggs[0])+")=b.cbo_id  and year=b.year \
            group by left(cbo_id,"+str(aggs[0])+"))"    
        runCountQuery('checkCBO_ID', 'rais_yo:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True)     
            
    
        # YBO: Check WLD aggs 2 with 4
        sql="SELECT count(*) FROM rais_ybo as b where length(b.cbo_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_ybo \
            where length(cbo_id)="+str(aggs[1])+" and left(cbo_id,"+str(aggs[0])+")=b.cbo_id and bra_id=b.bra_id  and year=b.year \
            group by left(cbo_id,"+str(aggs[0])+"),length(bra_id),year)"   
        runCountQuery('checkCBO_ID', 'rais_ybo:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 

    
        # YBIO: Check WLD aggs 2 with 4
        sql="SELECT count(*) FROM rais_ybio as b where length(b.cbo_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_ybio \
            where cbo_id=b.cbo_id and  length(cbo_id)="+str(aggs[1])+" and left(cbo_id,"+str(aggs[0])+")=b.cbo_id and bra_id=b.bra_id and cnae_id=b.cnae_id   and year=b.year \
            group by left(cbo_id,"+str(aggs[0])+"),length(bra_id),length(cnae_id),year)"   
        runCountQuery('checkCBO_ID', 'rais_ybio:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 

        # YIO: Check WLD aggs 2 with 4
        sql="SELECT count(*) FROM rais_yio as b where length(b.cbo_id)="+str(aggs[0])+" and b.wage <> \
               (SELECT sum(wage) FROM rais_yio \
            where cbo_id=b.cbo_id and  length(cbo_id)="+str(aggs[1])+" and left(cbo_id,"+str(aggs[0])+")=b.cbo_id and cnae_id=b.cnae_id  and year=b.year \
            group by left(cbo_id,"+str(aggs[0])+"),length(cnae_id),year)"   
        runCountQuery('checkCBO_ID', 'rais_yio:'+str(aggs[0])+":"+str(aggs[1]), sql,cursor,count=True) 
            
    #Checking aggs in different tables
    #YO x YBO
    sql="SELECT count(*) FROM rais_yo as b where length(b.cbo_id)=1 and b.wage <> \
           (SELECT sum(wage) FROM rais_ybo \
        where length(cbo_id)=2 and left(cbo_id,1)=b.cbo_id and year=b.year  and length(bra_id)=8  \
        group by left(cbo_id,1),year)"   
    runCountQuery('checkCBO_ID', 'rais_ybo x rais_yo', sql,cursor,count=True) 

    #YO x YBIO
    sql="SELECT count(*) FROM rais_yo as b where length(b.cbo_id)=1 and b.wage <> \
           (SELECT sum(wage) FROM rais_ybio \
        where length(cbo_id)=2 and left(cbo_id,1)=b.cbo_id and year=b.year  and length(bra_id)=8  and length(cnae_id)=5  \
        group by left(cbo_id,1),year)"   
    runCountQuery('checkCBO_ID', 'rais_ybio x rais_yo', sql,cursor,count=True) 


@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: BRA , BRAPR, CNAE ,CBO ',required=False)
def main(method):
    if not method or method=='all':
        checkBRA_ID()
        checkCNAE_ID()
        checkCBO_ID()  
        checkBRA_IDPR()
    elif method=="BRA":
        checkBRA_ID()        
    elif method=="BRAPR":
        checkBRA_IDPR()    
    elif method=="CNAE":
        checkCNAE_ID()
    elif method=="CBO":
        checkCBO_ID()

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;