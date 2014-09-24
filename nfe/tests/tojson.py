from helpers import read_from_csv,df_to_csv,left_df,floatvert,printTime,csv_to_json
import pandas as pd
import numpy as np
import time
import sys

run=''
#C:\Python27-64\python -m nfe.tests.tojson
def main(run):
    fieldnames = ("Municipality_ID_Receiver","Municipality_ID_Sender","Product_Value","Municipio")      
    csv_to_json("dados/nfe/NFE_teste_2013_01.csv","dados/nfe/NFE_teste_2013_01.json",fieldnames)      
     


#entrada = "dados/nfe/NFE_teste_2013_01.csv"
#saida = "dados/nfe/NFE_teste_2013_01.json"

    
    
   
main(run)