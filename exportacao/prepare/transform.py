from helper import read_from_csv


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
        2014 : '2014_extract.csv',
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

    if year == 2000 or year == 2001:
        cols['HS'] = str(2002)

    elif year > 2001 and year <= 2006:
        cols['HS'] = str(2007)

    elif year > 2007 and year <= 2011:
        cols['HS'] = str(2007)

    elif year > 2012 and year <= 2014:
        cols['HS'] = str(2007)


    read_from_csv(csv_files[year], None, None, cols)
