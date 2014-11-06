import unittest
from helpers import *

"Check export data. if the errors are greater than 1 percent of hits, tests will don't pass"
class TestCheck(unittest.TestCase):

    def setUp(self):
        True

    def test_years(self):
        for x in xrange(2000,2014):
            if(self.prepare(x)):
                assert True
            else:
                assert False

    def prepare(self, year):

        print "Check year: " + str(year)

        files = {
            2000 : 'EPEMG_BREX2000_v201008',
            2001 : 'EPEMG_BREX2001_v201008',
            2002 : 'EPEMG_BREX2002_v201008',
            2003 : 'EPEMG_BREX2003_v201008',
            2004 : 'EPEMG_BREX2004_v201008',
            2005 : 'EPEMG_BREX2005_v201008',
            2006 : 'EPEMG_BREX2006_v201008',
            2007 : 'EPEMG_BREX2007_v201008',
            2008 : 'EPEMG_BREX2008_v201008',
            2009 : 'EPEMG_BREX2009_v201008',
            2010 : 'EPEMG_BREX201012_v201205',
            2011 : 'EPEMG_BREX201112_v201205',
            2012 : 'Exportacao_2012',
            2013 : 'EXP_2013',
            2014 : 'EXP_2014',
        }

        source_file = 'dados/exportacao/raw/' + files[year] + '.txt'
        exported_file = 'dados/exportacao/sent/' + str(year) + '_extract.csv'

        usecols = ['ANO', 'MUNICIPIO', 'HS2007', 'VALORFOB']

        if year < 2012:

            columns = ((0,4), (4,6), (6,14), (14,17), (18,20), (19,23), (23,30), (30,32), (32,47), (47,62), (62,78))

            cols = ['ANO', 'MES', 'HS2007', 'PAIS', 'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB']

            df = read_from_fixed(source_file, columns, cols)

        elif year == 2012:

            cols = ['ANO', 'MES', 'HS2007', 'NO_NCM', 'PAIS', 'NO_PAIS', 'UF', 'NO_UF', 'MUNICIPIO', 'NO_MUN', 'PORTO', 'NO_PORTO', 'UNIDADE', 'NO_UNID', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB']

            df = read_from_csv(source_file, 1,"|", cols, None, usecols)

        else:

            cols = ['ANO', 'MES', 'HS2007', 'PAIS',  'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB']

            df = read_from_csv(source_file, 1,"|", cols, None, usecols)

        colsexported = ['ID', 'ANO', 'MES', 'HS2007', 'PAIS',  'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB']


        dfexported = read_from_csv(exported_file, 1,",", colsexported, None)

        df['key'] = df['ANO'] + df['HS2007'] + df['MUNICIPIO']
        dfexported['key'] = dfexported['ANO'] + dfexported['MUNICIPIO']

        dfgroup = df.groupby(["key"])
        dfgroupex = dfexported.groupby(["key"])


        a = 0
        b = 0
        for i in df.groupby(['key']).groups:
            try:

                exported = dfgroupex.get_group(i)['VALORFOB'].sum()
                source = dfgroup.get_group(i)['VALORFOB'].sum()

                if exported - source != 0:
                    a += 1

            except Exception, e:
                print "error: "  + str(i) + '\n'
                return False

            finally:
                b += 1

        if((b / 100) > a):
            print "a : " + str(a) + '\n'
            print "b : " + str(b) + '\n'
            return True
        else:
            return False

if __name__ == '__main__':
    unittest.main()
