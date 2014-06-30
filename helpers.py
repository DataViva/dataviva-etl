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
    