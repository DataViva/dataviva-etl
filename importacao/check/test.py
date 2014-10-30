import unittest
from helpers import *

"Check import data. if the errors are greater than 1 percent of hits, tests will don't pass"
class TestCheck(unittest.TestCase):

    def setUp(self):
        True

    def test_years(self):
        for x in xrange(2002,2011):
            if(self.prepare(x)):
                assert True
            else:
                assert False

    def prepare(self, year):

        print "Check year: " + str(year)

        source_file = 'dados/importacao/raw/' + 'MDIC_' + str(year) + '.csv'
        exported_file = 'dados/importacao/sent/' + str(year) + '_extract.csv'

        cols = ['ANO', 'MES', 'PAIS', 'ESTADO', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB', 'HS2007']

        colsexported = ['ID', 'ANO', 'MES', 'PAIS', 'ESTADO', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB', 'HS2007']

        usecols = ['ANO', 'MUNICIPIO', 'HS2007', 'VALORFOB']

        df = read_from_csv(source_file, 1,"|", cols, None, usecols)
        dfexported = read_from_csv(exported_file, 1,",", colsexported, None)
        df['key'] = df['ANO'] + df['MUNICIPIO']
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
