# -*- coding: utf-8 -*-
"""
    Check Data from SECEX Website with Dataviva 
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
    Running one by one:
    
    C:\Python27-64\python -m exportacao.check.step_5_site > step_5_site.log
    C:\Python27-64\Scripts\py.test exportacao\check\step_5_site.py
    
"""


''' Import statements '''
import csv, sys, os, argparse, MySQLdb, time, bz2,click
from collections import defaultdict
from os import environ
from decimal import Decimal, ROUND_HALF_UP
from config import DATA_DIR,DATAVIVA_DB_USER,DATAVIVA_DB_PW,DATAVIVA_DB_NAME
from helpers import d, get_file, format_runtime,find_in_df,sql_to_df,read_from_csv,read_from_fixed
import pandas as pd
from pandas import DataFrame
import pandas.io.sql as psql
#import allure

''' Connect to DB '''
db = MySQLdb.connect(host="localhost", user=DATAVIVA_DB_USER, passwd=DATAVIVA_DB_PW, db=DATAVIVA_DB_NAME)
db.autocommit(1)
cursor = db.cursor()
import unittest

class ExportSite(unittest.TestCase):  
    def test_checkExports(self):
        print "Entering in checkExports" 
        arquivo='dados/exportacao/site/dados.txt'
        checkExportsImports(arquivo,'exports')
        
    
    def test_checkImports(self):
        print "Entering in checkExports" 
        arquivo='dados/exportacao/site/imports.txt'
        checkExportsImports(arquivo,'imports')
    
    
    
    def checkExportsImports(self,arquivo,variavel):
        # Ano    1 até 4  , Mês   5 até 7   , Mês em Número     8 até 9  , US$     10 até 31 , Kg Líquido    32 até 53   , Quantidade   54 até 75   
        columns = ((0,4),(4,7),(7,9),(9,31),(31,53),(53,75))
        names =('year','monthname','month','valor','kg','qty')
        dfSite = read_from_fixed(arquivo,columns,names)
            
        sql="SELECT sum(export_val) as exports,sum(import_val) as imports,month,year,concat(month,'-',year) as monthyear FROM dataviva2.secex_ymb where bra_id_len=8 and month>0 group by month,year;"
        dfDV = sql_to_df(sql,db)
        
        print dfDV
        for monthyear in dfDV['monthyear']:
            month = dfDV[dfDV['monthyear']==monthyear]['month'].values[0]
            year = dfDV[dfDV['monthyear']==monthyear]['year'].values[0]
            exports = dfDV[dfDV['monthyear']==monthyear][variavel].values[0]
            
            exportsSite = dfSite[ (dfSite['month']==month) & (dfSite['year']==year)]
            exportsSite = exportsSite['valor'].values[0]
            
             
            diff = exportsSite - exports
            if diff>10 or diff < -10:
                print "Error on "+str(month)+"/"+str(year)+" : "+str(diff)
                print "Site: " +str(exportsSite)
                print "DV2: " + str(exports)
                print "-----------------"
        assert True
 
  
@click.command()
def main():
    cls=ExportSite()
    cls.test_checkExports()
    cls.test_checkImports()
                                              
if __name__ == "__main__":
    main()
    
''''''