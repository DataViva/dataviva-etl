import csv, sys, os, argparse, time, bz2
from collections import defaultdict
from os import environ
from config import DATA_DIR
import pandas as pd
from helpers import fixed_to_csv,read_from_csv,df_to_csv


#python -m censoescolar.step_1_extract
def main(year):
    dirFile = DATA_DIR + "censoescolar/" + year+"/"+'teste.txt'
    dirCSV = DATA_DIR + "censoescolar/" + year+"/"+'teste.txt.csv'
    
    #
    headers = ('ANO_CENSO','PK_COD_MATRICULA','FK_COD_ALUNO','NUM_IDADE', 'TP_SEXO', \
               'TP_COR_RACA', 'FK_COD_ESTADO_END', 'SIGLA_END', 'FK_COD_MUNICIPIO_END', 'ID_ZONA_RESIDENCIAL', \
               'FK_COD_MOD_ENSINO', 'FK_COD_ETAPA_ENSINO', 'PK_COD_TURMA', 'FK_COD_CURSO_PROF', 'PK_COD_ENTIDADE', \
               'FK_COD_ESTADO_ESCOLA', 'SIGLA_ESCOLA', 'COD_MUNICIPIO_ESCOLA', 'ID_LOCALIZACAO_ESC', 'ID_DEPENDENCIA_ADM_ESC')
                  
    #Coluna começa com 0
    columns = ((0,5),(6,18),(19,32),(44,47),(65,66), \
               (66,67),(87,89),(89,91),(92,100),(100,101), \
               (130,132),(133,136),(137,147),(148,156),(162,170), \
               (171,173),(174,175),(176,184),(185,193),(194,195))
    
    fixed_to_csv(dirFile,columns,dirCSV,headers)
    
    df = read_from_csv(dirCSV)
    df["novo"]=df["ANO_CENSO"] + df["NUM_IDADE"]

    df_to_csv(df,dirCSV)

    #mapping = {'set': 1, 'test': 2}

    #df.replace({'set': mapping, 'tesst': mapping})
           
if __name__ == "__main__":
    start = time.time()
    YEAR="2012"
    main(YEAR)
    
    total_run_time = (time.time() - start) / 60
    print; print;
    print "Total runtime: {0} minutes".format(int(total_run_time))
    print; print;
    