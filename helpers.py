import csv, sys, os, argparse, time, bz2,time
from collections import defaultdict
from os import environ
from config import DATA_DIR
import pandas as pd
import pandas.io.sql as psql
import csv
import json
import numpy as np


''' Import statements '''
import sys, bz2, gzip, zipfile, os
from decimal import Decimal, ROUND_HALF_UP
from os.path import splitext, basename, exists

""" read Files in folder """
import glob
import os

total_error=0

'''
    Used for finding environment variables through configuration
    if a default is not given, the site will raise an exception
'''
def get_env_variable(var_name, default=-1):
    try:
        return os.environ[var_name]
    except KeyError:
        if default != -1:
            return default
        error_msg = "Set the %s os.environment variable" % var_name
        raise Exception(error_msg)

def d(x):
  return Decimal(x).quantize(Decimal(".01"), rounding=ROUND_HALF_UP)

def get_file(file_path):
    file_name = basename(file_path)
    file_path, file_ext = splitext(file_path)
    extensions = [
        {'ext': file_ext+'.bz2', 'io':bz2.BZ2File},
        {'ext': file_ext+'.gz', 'io':gzip.open},
        {'ext': file_ext+'.zip', 'io':zipfile.ZipFile},
        {'ext': file_ext, 'io':open}
    ]
    for e in extensions:
        file_path_w_ext = file_path + e["ext"]
        if exists(file_path_w_ext):
            file = e["io"](file_path_w_ext)
            if '.zip' in e["ext"]:
                file = zipfile.ZipFile.open(file, file_name)
            print "Reading from file", file_path_w_ext
            return file
    print "ERROR: unable to find file named {0}[.zip, .bz2, .gz] " \
            "in directory specified.".format(file_name)
    return None

def get_files_in_folder(folder, extension):
    """Get a list of all files in folder by extension.

    Keyword arguments:
    folder -- path of folder. ex.: folder='/dados/raw/db/2013'
    extension -- extension os files without dot ex.: extension = csv
    """
    os.chdir(folder)
    extension.replace(".", "")
    return glob.glob("*." + str(extension))


def format_runtime(x):
    # convert to hours, minutes, seconds
    m, s = divmod(x, 60)
    h, m = divmod(m, 60)
    if h:
        return "{0} hours and {1} minutes".format(int(h), int(m))
    if m:
        return "{0} minutes and {1} seconds".format(int(m), int(s))
    if s < 1:
        return "< 1 second"
    return "{0} seconds".format(int(s))



def fixed_to_csv(filefixed,columns,csvfile,headers):
    """Convert a file containg data in Fixed Register format to a CSV format.

    Keyword arguments:
    filefixed -- path of a file containg data in fixed register. ex.: filefixed='/fixedregister.txt'
    columns -- map of the positions of each column. ex.: columns = ((0,5),(5,18))
    csvfile -- name of the result of this operation, where CSV will be written. ex.: csvfile='/fixedregister.csv'
    headers -- name of each column to be written in CSV file. ex.: headers = ('ANO_CENSO','PK_COD_MATRICULA')
    """

    data = read_from_fixed(filefixed,columns)
    with open(csvfile, "w") as f:
        data.to_csv(f, header=headers)
    return data


def read_from_fixed(filefixed,columns,names =None):

    """Read from a Fixed Register format to a Dataframe (pandas).

Keyword arguments:
filefixed -- path of a file containg data in fixed register. ex.: filefixed='/fixedregister.txt'
columns -- map of the positions of each column. ex.: columns = ((0,5),(5,18))
names -- map of the name of each column. ex.: names = ('ID','NOME')
"""

    raw_file_path = os.path.abspath( filefixed)
    data = pd.read_fwf(raw_file_path, colspecs = columns, header=None,names =names )
    return data

def read_from_csv(file,header=None,delimiter=None,cols=None,converters=None,usecols=None):
    """Read contents from a CSV to a Dataframe, that can be accessed with python scripts.

    Keyword arguments:
    file -- path of a CSV file to read and that will be the source of dataframe. ex.: filefixed='/fixedregister.txt'
    header - it says how many lines its used to be the name of the columns
    cols -- name of the columns used. ex.: cols= ['TransactedProduct_ID_NCM','TransactedProduct_ID_HS']
    converters -- functions to convert values in the column. ex.: converters = {"TransactedProduct_ID_NCM": bra_replace, "TransactedProduct_ID_HS": str}
    usecols -- array of columns wich you like to read. ex.: cols= ['TransactedProduct_ID_NCM','TransactedProduct_ID_HS']
    Return:
    dataframe -- python object containing data from the CSV file
    """
    if not header:
        header=0
    df = pd.read_csv(file, index_col=False,delimiter =delimiter,names=cols, converters=converters,header=header,usecols=usecols);  #, header=header

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


def sql_to_df(sql,db):
    """Execute a query and with the results create a Dataframe .

    Keyword arguments:
    sql             -- SQL Query
    db            -- Connection to the database


    Example:
    find_in_df(df,'id','2000_010101','val_usd')
    """
    df = psql.frame_query(sql, db)
    return df

def find_in_df(df,idlabel,idsearch,valuelabel):
    """Find the value from a column searching for a id value.

    Keyword arguments:
    df             -- Dataframe
    idlabel        -- name of the column that has the id that will be searched
    idsearch       -- value to be found in id column
    valuelabel     -- name of the column of the value that will be found

    Example:
    find_in_df(df,'id','2000_010101','val_usd')
    """

    d2 = df[(df[idlabel]==idsearch)]
    if d2.empty==False and  valuelabel in d2:
        return d2[valuelabel]


def errorMessage(step, table, size):
    global total_error
    global msg_error
    if size>0:
        msg="Found {0} Errors in {1} for {2}".format(size,step,table)
        print msg
        total_error=total_error+size

def runCountQuery(step, table, sql,cursor,count=None):
    print step + " : "+table
    print "---------------------------"
    cursor.execute(sql)
    values=cursor.fetchall()
    if not count:
        size=len(values)
    else:
        size=values[0][0]
    errorMessage(step, table+" - SQL: "+sql, size)
    return size
    

'''

df = left_df(df,'id',4)
'''
def left_df(df,column_entrada,size,column_saida=None,maxSize=None):
    if not column_saida:
        column_saida=column_entrada

    def left_(s,size):
        try:
            s=str(s)
            s1 = s[0:size]
            return s1
        except ValueError:
            print "erro"
            return s

    df[column_saida] = df.apply(lambda f : left_(f[column_entrada],size) , axis = 1)
    return df

def to_int(s):
    if s is None:
        return False
    try:
        ret=int(s)
        return ret
    except ValueError:
        print "Erro to_int"+str(s)
        return False

def to_number(s):
    try:
        s=str(s)
        s=s.replace(',', '.')
        s1 = float(s)
        return s1
    except ValueError:
        print "Erro to_number"+str(s)
        return 0

def fill_zeros(s):
    try:
        s1 =s.zfill(3)
        return s1
    except ValueError:
        print "Error fill_zeros"+str(s)
        return 0


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


'''

df = df.drop(['NO_NCM', 'NO_PAIS', 'NO_UF', 'NO_PORTO', 'NO_MUN', 'NO_UNID'], 1)


ybio = dados.groupby(["year", "bra_id", "cnae_id", "cbo_id"]) \
.agg({"wage": np.sum, "num_emp": pd.Series.count, "num_est": pd.Series.count,\
"num_emp_m": np.sum, "wage_m": np.sum, "wage_f": np.sum})

'''

def floatvert(x):
    x = x.replace(',', '.')
    try:
        return float(x)
    except:
        return np.nan


'''
Ex.:
First line:
    start=time.time()

Second time and beyond:
    start=printTime("agregate",start)
'''
def printTime(name,start=None):
    if not start:
        start = time.time()
    print; print;
    print "Total runtime - " +name+ ": {0} minutes".format(int((time.time() - start) / 60))
    print "Total runtime - " +name+ ": {0} seconds".format(int((time.time() - start) ))
    return time.time()

'''

Example:

    fieldnames = ("Municipality_ID_Receiver","Municipality_ID_Sender","Product_Value","Municipio")
    csv_to_json("dados/nfe/NFE_teste_2013_01.csv","dados/nfe/NFE_teste_2013_01.json",fieldnames)

'''
def csv_to_json(entrada,saida,fieldnames,delimiter=None):
    csvfile = open(entrada, 'r')
    jsonfile = open(saida, 'w')

    if not delimiter:
        delimiter=";"

    reader = csv.DictReader( csvfile, fieldnames,delimiter=';')
    for row in reader:
        #print row #.encode("utf8")
        json.dump(row, jsonfile, ensure_ascii=False)
        jsonfile.write(', \n ')
    jsonfile.write('\n')


#python -m censoescolar.step_1_extract
#raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '../', filename))
#columns = ((0,10),(11,14),(15,18),(19,22),(23,29),(30,35),(36,44),(45,45),(46,49),(50,55),(56,61),(62,67),(68,73),(74,79),(80,80),(81,86),(87,87),(88,108))
#raw_file = get_file(raw_file_path)
#w['female'] = w['female'].map({'female': 1, 'male': 0})
#raw_file_path = os.path.abspath(os.path.join(DATA_DIR, '', filefixed))
#mapping = {'set': 1, 'test': 2}
#df.replace({'set': mapping, 'tesst': mapping})
