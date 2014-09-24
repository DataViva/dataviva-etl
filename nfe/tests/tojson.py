from helpers import read_from_csv,df_to_csv,left_df,floatvert,printTime
import pandas as pd
import numpy as np
import time
import sys


run=''
#C:\Python27-64\python -m nfe.tests.tojson
def main(run):
          
    csv_to_json("dados/nfe/NFE_teste_2013_01.csv","dados/nfe/NFE_teste_2013_01.json")      

def mainDF(run):
    sys.setrecursionlimit(1000000)    
    orig_cols = ['Municipality_ID_Receiver','Municipality_ID_Sender','Product_Value','Municipio']
    delimiter=";"
    dados = read_from_csv("dados/nfe/NFE_teste_2013_01.csv",delimiter=delimiter,cols=orig_cols,header=1)
    print dados
    dados.to_json()
    dados.to_json("dados/nfe/NFE_teste_2013_01.json")
     

import csv
import json

#entrada = "dados/nfe/NFE_teste_2013_01.csv"
#saida = "dados/nfe/NFE_teste_2013_01.json"
def csv_to_json(entrada,saida):
    csvfile = open(entrada, 'r')
    jsonfile = open(saida, 'w')
    
    fieldnames = ("Municipality_ID_Receiver","Municipality_ID_Sender","Product_Value","Municipio")
    reader = csv.DictReader( csvfile, fieldnames,delimiter=';')
    for row in reader:
        #print row #.encode("utf8")
        json.dump(row, jsonfile, ensure_ascii=False)
    jsonfile.write('\n')
    
    
   
main(run)