# -*- coding: utf-8 -*-
"""
    Check all data in EI tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    How to run: python -m educacaosuperior.check.step_2_aggs
    
    
    python -m educacaosuperior.check.step_2_aggs -m all
    
    python -m tests.runtests -d educacaosuperior > tests\educacaosuperior.html

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

    #
    def checkcampo(self,campo):
    
        total=0
        
        titulo="check_"+campo
        sql="SELECT count(*) FROM hedu_ybc b where b.bra_id_len=3 and b."+campo+" <>  \
        (  select sum("+campo+") from hedu_ybc where b.bra_id_len=9  \
        and b.course_id=course_id and left(bra_id,3)=b.bra_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_ybc', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_ybd b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from hedu_ybd where b.bra_id_len=9  \
        and b.d_id=d_id and left(bra_id,3)=b.bra_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_ybd', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_ybu b where b.bra_id_len=3 and b."+campo+" <>  \
        (  select sum("+campo+") from hedu_ybu where b.bra_id_len=9  \
        and b.university_id=university_id and left(bra_id,3)=b.bra_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_ybu', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_yc b where b."+campo+" <>  \
        (  select sum("+campo+") from hedu_yc where  b.course_id=course_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_yc', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_yd b where b."+campo+" <>  \
        (  select sum("+campo+") from hedu_yd where  b.d_id=d_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_yd', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_yd b where b."+campo+" <>  \
        (  select sum("+campo+") from hedu_ybd where d_id=b.d_id and b.year=year )"
        total+=runCountQuery(titulo, 'hedu_yd x hedu_ybd', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_yc b where b."+campo+" <>  \
        (  select sum("+campo+") from hedu_ybc where course_id=b.course_id and b.year=year )"
        total+=runCountQuery(titulo, 'hedu_yc x hedu_ybc', sql,cursor,count=True)

        sql="SELECT count(*) FROM hedu_ybuc b where b.bra_id_len=3 and b."+campo+" <>  \
        (  select sum("+campo+") from hedu_ybuc where b.bra_id_len=9 and course_id=b.course_id \
        and b.university_id=university_id and left(bra_id,3)=b.bra_id and b.year=year  )"
        total+=runCountQuery(titulo, 'hedu_ybuc', sql,cursor,count=True)

        # hedu_ybucd - muito longo
        
        return total
    

    def test_sum(self):
        print "Entering in test_sum"
        total=0

        aggsP = ["enrolled","students","graduates","entrants","morning","afternoon","night","full_time"]
        for aggs in aggsP:    
            total+=self.checkcampo(aggs)
            
        self.assertEqual(total, 0)
    
       
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybd where d_id in ('A','B') and bra_id_len=9 group by 1,2;
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybc where course_id_len=6 and bra_id_len=9 group by 1,2;
    #SELECT bra_id,year,sum(enrolled) FROM hedu_ybu where bra_id_len=9 group by 1,2;  

            
@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: sum ',required=False)
def main(method):
    cls=EducacaoSuperiorAggs()
    if not method or method=='all':
        cls.test_sum()
    elif method=="sum":
        cls.test_sum()     

if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;