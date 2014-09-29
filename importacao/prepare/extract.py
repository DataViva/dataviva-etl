from helpers import *

''' Extract CSV file by year'''
def extract(year):

    source_file = 'dados/importacao/raw/' + files[year] + '.txt'
    export_file = 'dados/importacao/sent/' + str(year) + '_extract.csv'

    headers = ('ANO', 'MES', 'HS', 'PAIS', 'UF', 'MUNICIPIO', 'PORTO',
    'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB')

    data = fixed_to_csv(source_file, columns, export_file, headers)

if __name__ == '__main__':
    extract(2014)
