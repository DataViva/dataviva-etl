# -*- coding: utf-8 -*-
"""
    Check all data in SC tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Running one by one:
    python -m censoescolar.check.step_1_aggs -m all > allstep2cs.log
    python -m censoescolar.check.step_1_aggs -m enrolled > enrolled.log
    python -m censoescolar.check.step_1_aggs -m classes > classes.log
    python -m censoescolar.check.step_1_aggs -m distortionage > distortionage.log
    
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


#verificar a distorcao serie idade, q nao pode ser nulo para cursos nao profissionalizantes (nao é melhor criar uma flag em attrs_course_sc do q fazer um left xx?)
#so exibir avg idade qd houver curso
# distorcao idade por localidade, curso e etinia (d_id)
class CensoEscolarAggs(unittest.TestCase):     

    def test_enrolled(self):    
        total=self.exectest("enrolled")
        self.assertEqual(total, 0)

    def test_classes(self):    
        total=self.exectest("classes")
        self.assertEqual(total, 0)

    def test_distortionage(self):    
        print "Entering in test_distortionage"
        total=0
        aggsP = ['sc_yc', 'sc_ybc']
        for aggs in aggsP:        
            sql="SELECT * FROM sc_yc where distortion_rate is null and \
                left(course_id,2)='xx' and course_id not in ('xx015','xx020','xx021','xx022');"
            total+=runCountQuery("check_"+campo, 'sc_yd x sc_yd', sql,cursor,count=True) 
        self.assertEqual(total, 0)
        
                           
    #enrolled or classes
    def exectest(self,campo):
        print "Entering in test_"+campo
        total=0
                
        sql="SELECT count(*) FROM sc_yd b where  b."+campo+" <> \
        (  select sum("+campo+") from sc_yd where  d_id=b.d_id and b.year=year  )"
        total+=runCountQuery("check_"+campo, 'sc_yd x sc_yd', sql,cursor,count=True) 
        
        
        sql="SELECT count(*) FROM sc_yb b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_yb where b.bra_id_len=9 and  \
        left(bra_id,3)=b.bra_id and b.year=year  )"
        total+=runCountQuery("check_"+campo, 'sc_yb x sc_yb', sql,cursor,count=True) 
        
        
        sql="SELECT count(*) FROM sc_ybc b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_ybc where b.bra_id_len=9 and  \
        left(bra_id,3)=b.bra_id and b.year=year and b.course_id=course_id  )"
        total+=runCountQuery("check_"+campo, 'sc_ybc x sc_ybc', sql,cursor,count=True) 
        
        sql="SELECT count(*) FROM sc_ybd b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_ybd where b.bra_id_len=9 and \
        left(bra_id,3)=b.bra_id and b.year=year and b.d_id=d_id  )"
        total+=runCountQuery("check_"+campo, 'sc_ybd x sc_ybd', sql,cursor,count=True) 
        
        sql="SELECT count(*) FROM sc_ybs b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_ybs where b.bra_id_len=9 and  \
        left(bra_id,3)=b.bra_id and b.year=year and b.school_id=school_id )"
        total+=runCountQuery("check_"+campo, 'sc_ybs x sc_ybs', sql,cursor,count=True) 
        
        
        sql="SELECT count(*) FROM sc_ybc b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_ybd where b.bra_id_len=9 and \
        left(bra_id,3)=b.bra_id and b.year=year )"
        total+=runCountQuery("check_"+campo, 'sc_ybc x sc_ybd', sql,cursor,count=True) 
        
        sql="SELECT count(*) FROM sc_ybc b where b.bra_id_len=3 and b."+campo+" <> \
        (  select sum("+campo+") from sc_ybs where b.bra_id_len=9 and \
        left(bra_id,3)=b.bra_id and b.year=year )"
        total+=runCountQuery("check_"+campo, 'sc_ybc x sc_ybs', sql,cursor,count=True) 
        
        sql="SELECT count(*) FROM sc_yc b where b."+campo+" <> \
        (  select sum("+campo+") from sc_ybc where course_id=b.course_id and b.year=year )"
        total+=runCountQuery("check_"+campo, 'sc_yc x sc_ybc', sql,cursor,count=True) 
        
        
        sql="SELECT count(*) FROM sc_yb b where b."+campo+" <>  \
        (  select sum("+campo+") from sc_ybc where bra_id=b.bra_id and b.year=year )"
        total+=runCountQuery("check_"+campo, 'sc_yb x sc_ybc', sql,cursor,count=True) 
        
        sql="SELECT count(*) FROM sc_yd b where b."+campo+" <> \
        (  select sum("+campo+") from sc_ybd where d_id=b.d_id and b.year=year )"
        total+=runCountQuery("check_"+campo, 'sc_yd x sc_ybd', sql,cursor,count=True) 
        
        return total
    

            

@click.command()
@click.option('-m', '--method', prompt='Method', help='chosse a specific method to run: enrolled, classes and distortionage ',required=False)
def main(method):
    cls=CensoEscolarAggs()
    if not method or method=='all':
        cls.test_enrolled()
        cls.test_classes()
        cls.test_distortionage()
    elif method=="enroll":
        cls.test_enrolled()        
    elif method=="classes":
        cls.test_classes()
    elif method=="distortionage":
        cls.test_distortionage()
        
if __name__ == "__main__":
    start = time.time()
    
    main()
    
    total_run_time = time.time() - start
    print; print;
    print "Total runtime: " + format_runtime(total_run_time)
    print; print;