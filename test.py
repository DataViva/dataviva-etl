import csv, sys, os, argparse, time, bz2
from collections import defaultdict
from os import environ
from os.path import splitext, basename, exists
from config import DATA_DIR
import pandas as pd
from helpers import fixed_to_csv,read_from_csv,df_to_csv


#python -m test
def main():
    dirFile =  'teste.txt'
    dirCSV =  'teste.txt.csv'
    

    headers = ('ANO_CENSO','PK_COD_MATRICULA','FK_COD_ALUNO','NUM_IDADE', 'TP_SEXO', \
               'TP_COR_RACA', 'FK_COD_ESTADO_END', 'SIGLA_END', 'FK_COD_MUNICIPIO_END', 'ID_ZONA_RESIDENCIAL', \
               'FK_COD_MOD_ENSINO', 'FK_COD_ETAPA_ENSINO', 'PK_COD_TURMA', 'FK_COD_CURSO_PROF', 'PK_COD_ENTIDADE', \
               'FK_COD_ESTADO_ESCOLA', 'SIGLA_ESCOLA', 'COD_MUNICIPIO_ESCOLA', 'ID_LOCALIZACAO_ESC', 'ID_DEPENDENCIA_ADM_ESC')
                  
    #Coluna começa com 0
    columns = ((0,5),(5,18),(18,32),(43,47),(65,66), \
               (66,67),(86,89),(89,91),(91,100),(100,101), \
               (129,132),(132,136),(136,147),(147,156),(161,170), \
                   (170,173),(173,175),(175,184),(184,193),(193,194))
    
    
    fixed_to_csv(dirFile,columns,dirCSV,headers)
    
    df = read_from_csv(dirCSV)
    
    
    df["novo"]=df["ANO_CENSO"] + df["NUM_IDADE"]
    
    df["NOVOANO"] = df.apply(sexo_to_number,axis=1)
    
    

    #df_to_csv(df,dirCSV)

    #mapping = {'set': 1, 'test': 2}

    #df.replace({'set': mapping, 'tesst': mapping})
    
    df_to_csv(df , dirCSV)

def sexo_to_number(entrada):
    x = entrada["TP_SEXO"]
    if x=="F":
        return 1
    else:
        return 2     
              
if __name__ == "__main__":
    
    main()
    

    
