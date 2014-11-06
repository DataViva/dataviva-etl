from helpers import read_from_csv

''' Transform
convert all HS to 2007
'''
def transform(year):

    cols = ('ANO', 'MES', 'PAIS', 'ESTADO', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB', 'HS2007')

    source_file = 'dados/importacao/sent/' + str(year) + str('_extract.csv')

    print source_file

    df = read_from_csv(source_file, 1, None, cols, None)

    rdCols = ['HS2007']

    rd = read_from_csv('docs/classificacao/HS/anos/HS_Todos_Anos_IMP.csv', 1, ';', rdCols, converters={"HS2007": str})

    f2 = lambda x: [rd.HS2007 == str(x)]

    df.apply(f2)

    print df

if __name__ == "__main__":
    for x in xrange(2000, 2014):
        print "execute year: " + str(x)
        transform(x)

