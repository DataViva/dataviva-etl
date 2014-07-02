import csv, sys, os, argparse, time, bz2
from collections import defaultdict
from os import environ
from config import DATA_DIR
import pandas as pd


#python -m censoescolar.step_1_extract
#raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '../', filename))
#columns = ((0,10),(11,14),(15,18),(19,22),(23,29),(30,35),(36,44),(45,45),(46,49),(50,55),(56,61),(62,67),(68,73),(74,79),(80,80),(81,86),(87,87),(88,108))
#raw_file = get_file(raw_file_path)
def fixed_to_csv(filefixed,columns,csvfile,headers):
    
    #raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '', filefixed))  
    raw_file_path = os.path.abspath( filefixed) 
        
    data = pd.read_fwf(raw_file_path, colspecs = columns, header=None)
    
    with open(csvfile, "w") as f:
        #dw.writerow(headers)
        data.to_csv(f, header=headers)

def read_from_csv(file):
    df = pd.read_csv(file, index_col=False, header=0);  
    return df

def df_to_csv(data , file,headers=None):
    
    with open(file, "w") as f:
        #dw.writerow(headers)
        data.to_csv(f, header=headers)



'''
    SIMPLE COMPUTED COLUMNS
    
    df["novo"]=df["ANO_CENSO"] + df["NUM_IDADE"]
    
'''


'''
    COMPLEX COMPUTED COLUMNS
    Day that you need to create a new column that the value is a calc using others values in the same row, you can  use as above.
    In this example we are converting string F and M for sex type and puting a number in place
    
    First you need to declare the transform function:
    def sexo_to_number(entrada):
        x = entrada["TP_SEXO"]
        if x=="F":
            return 1
        else:
            return 2        
    
    Then you apply in the Dataframe:
    df["NOVOANO"] = df.apply(sexo_to_number,axis=1)


'''


'''
    MAP COMPUTED COLUMNS
    When you need to create a new column as a map, like a key value, you can use:
    
    
    df["A1"], df["A2"] = zip(*df["ANO_CENSO"].map(calculate))

    def calculate(x):
        return x*2, x*3

'''


'''
   MERGE
   If you have 2 dataframes and wants to make a join, you can:
   df2.merge(df1)
   
   Example: 
   * http://stackoverflow.com/questions/17450857/using-python-pandas-lookup-another-dataframe-and-return-corresponding-values
   
'''