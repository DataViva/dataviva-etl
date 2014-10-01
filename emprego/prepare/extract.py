from helpers import *

''' Extract CSV file by year'''
def extract(year):

    source_file = 'dados/rais/raw/' + 'Rais' + str(year) + '.csv'
    export_file = 'dados/rais/sent/' + str(year) + '_extract.csv'

    cols = ('ANO', 'MES', 'PAIS', 'ESTADO', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB', 'HS2007')

    df = read_from_csv(source_file, 1,"|", cols, None)

    df_to_csv(df, export_file, None)

    print df

if __name__ == '__main__':
    extract(2011)
