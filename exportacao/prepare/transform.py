from helpers import read_from_csv

''' Transform '''
def transform(year):
    csv_files = {
        2000 : '2000_extract.csv',
        2001 : '2001_extract.csv',
        2002 : '2002_extract.csv',
        2003 : '2003_extract.csv',
        2004 : '2004_extract.csv',
        2005 : '2005_extract.csv',
        2006 : '2006_extract.csv',
        2007 : '2007_extract.csv',
        2008 : '2008_extract.csv',
        2009 : '2009_extract.csv',
        2010 : '2010_extract.csv',
        2011 : '2011_extract.csv',
        2012 : '2012_extract.csv',
        2013 : '2013_extract.csv',
        2014 : '2014_extract.csv'
    }
    cols = [
        'ANO',
        'MES',
        'HS',
        'PAIS',
        'UF',
        'PORTO',
        'MUNICIPIO',
        'UNIDADE',
        'QUANTIDADE',
        'KGLIQUIDO',
        'VALORFOB',
    ]

    source_file = 'dados/exportacao/sent/' + str(csv_files[year])
    df = read_from_csv(source_file, 1, None, cols, None)

    if year == 2000 or year == 2001:
        ## 1996x2002
        rdCols = ['HS96', 'HS02']
        rd = read_from_csv('docs/classificacao/HS/anos/1996x2002.csv', 1, ';', rdCols, converters={"HS96": str})

        f = lambda x: rd['HS02'][rd.HS96 == str(x)]
        df.apply(f)

        # CONVERT TO 2001

        # CONVERT TO 2007


        print df

    elif year > 2001 and year <= 2006:
        ##
        rdCols = ['HS02', 'HS07']
        rd = read_from_csv('docs/classificacao/HS/HS_2002_2007.csv', 1, ';', rdCols, converters={"HS07": str})

        f = lambda x: rd['HS02'][rd.HS07 == str(x)]
        df.apply(f)

        print df

    elif year >= 2007 and year <= 2011:

        rdCols = ['HS2012', 'HS2007']
        rd = read_from_csv('docs/classificacao/HS/HS_2007X2012.csv', 1, ';', rdCols, converters={"HS2007": str})

        f = lambda x: rd['HS2012'][rd.HS2007 == str(x)]
        df.apply(f)

        print df

    elif year >= 2012 and year <= 2014:

        rdCols = ['HS2012', 'HS2007']
        ## PROCURAR ARQUIVO
        rd = read_from_csv('docs/classificacao/HS/HS_2007X2012.csv', 1, ';', rdCols, converters={"HS2007": str})

        f = lambda x: rd['HS2012'][rd.HS2007 == str(x)]
        df.apply(f)

        print df


if __name__ == "__main__":
    transform(2000)

