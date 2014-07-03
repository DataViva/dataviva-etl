import csv, sys, os, argparse, time, bz2
from collections import defaultdict
from os import environ
from config import DATA_DIR
import pandas as pd


def fixed_to_csv(filefixed,columns,csvfile,headers):
    """Convert a file containg data in Fixed Register format to a CSV format.

    Keyword arguments:
    filefixed -- path of a file containg data in fixed register. ex.: filefixed='/fixedregister.txt'
    columns -- map of the positions of each column. ex.: columns = ((0,5),(5,18))
    csvfile -- name of the result of this operation, where CSV will be written. ex.: csvfile='/fixedregister.csv'
    headers -- name of each column to be written in CSV file. ex.: headers = ('ANO_CENSO','PK_COD_MATRICULA')
    """
    
    raw_file_path = os.path.abspath( filefixed) 
    print raw_file_path
    data = pd.read_fwf(raw_file_path, colspecs = columns, header=None)
    with open(csvfile, "w") as f:
        data.to_csv(f, header=headers)

def read_from_csv(file,header=None):
    """Read contents from a CSV to a Dataframe, that can be accessed with python scripts.

    Keyword arguments:
    file -- path of a CSV file to read and that will be the source of dataframe. ex.: filefixed='/fixedregister.txt'
    
    Return:
    dataframe -- python object containing data from the CSV file
    """
    if not header:
        header=0
    df = pd.read_csv(file, index_col=False);  #, header=header
    return df

def df_to_csv(data , file,header=None):
    """Convert a dataframe object containing data to a CSV file.

    Keyword arguments:
    data -- dataframe came from a CSV ( read_from_csv ), Fixed or others 
    file -- path of a CSV file that will be written using information in dataframe argument. ex.: filefixed='/fixedregister.csv'
    """   
    if not header:
        header=True
    with open(file, "w") as f:
        #dw.writerow(headers)
        data.to_csv(f, header=header)



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
    REPLACE PART COLUMN
    
    If you want to replace just a part of a string in a column, use:
    misc['product_desc'] = misc['product_desc'].str.replace('\n', '')
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

#python -m censoescolar.step_1_extract
#raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '../', filename))
#columns = ((0,10),(11,14),(15,18),(19,22),(23,29),(30,35),(36,44),(45,45),(46,49),(50,55),(56,61),(62,67),(68,73),(74,79),(80,80),(81,86),(87,87),(88,108))
#raw_file = get_file(raw_file_path)
#w['female'] = w['female'].map({'female': 1, 'male': 0})
#raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '', filefixed)) 
#mapping = {'set': 1, 'test': 2}
#df.replace({'set': mapping, 'tesst': mapping})