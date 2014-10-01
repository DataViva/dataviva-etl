from helpers import read_from_csv

''' Transform '''
def transform(year):

    cols = ['ANO','MES','HS','PAIS','UF','PORTO','MUNICIPIO','UNIDADE','QUANTIDADE','KGLIQUIDO','VALORFOB',]

    source_file = 'dados/exportacao/sent/' + str(year) + str('_extract.csv')

    print source_file
    df = read_from_csv(source_file, 1, None, cols, None)

    if year == 2000 or year == 2001:
        ## 1996x2002
        rdCols = ['HS96', 'HS02']
        rd = read_from_csv('docs/classificacao/HS/anos/1996x2002.csv', 1, ';', rdCols, converters={"HS96": str})

        f = lambda x: rd['HS02'][rd.HS96 == str(x)]
        df.apply(f)

        # CONVERT TO 2007

        rdCols2 = ['HS2007']
        rd2 = read_from_csv('docs/classificacao/HS/anos/2007.csv', 1, ';', rdCols2, converters={"HS2007": str})

        f2 = lambda x: [rd2.HS96 == str(x)]
        df.apply(f2)

        print df

    elif year > 2001 and year <= 2006:
        ##
        rdCols = ['HS02', 'HS07']
        rd = read_from_csv('docs/classificacao/HS/anos/2002x2007.csv', 1, ';', rdCols, converters={"HS07": str})

        f = lambda x: rd['HS02'][rd.HS07 == str(x)]
        df.apply(f)

        rdCols2 = ['HS2007']
        rd2 = read_from_csv('docs/classificacao/HS/anos/2007.csv', 1, ';', rdCols2, converters={"HS2007": str})

        f2 = lambda x: [rd2.HS2007 == str(x)]
        df.apply(f2)

        print df

    elif year >= 2007 and year <= 2011:

        rdCols = ['HS2012', 'HS2007']
        rd = read_from_csv('docs/classificacao/HS/anos/2012x2007.csv', 1, ';', rdCols, converters={"HS2007": str})

        f = lambda x: rd['HS2012'][rd.HS2007 == str(x)]
        df.apply(f)

        print df

    elif year >= 2012 and year <= 2014:

        rdCols = ['HS2012', 'HS2007']
        rd = read_from_csv('docs/classificacao/HS/anos/2012x2007.csv', 1, ';', rdCols, converters={"HS2007": str})

        f = lambda x: rd['HS2012'][rd.HS2007 == str(x)]
        df.apply(f)

        print df


if __name__ == "__main__":
    transform(2002)

