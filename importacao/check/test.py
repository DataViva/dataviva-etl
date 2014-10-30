import unittest
from helpers import *

"Check import data. if the errors are greater than 1 percent of hits, tests will don't pass"
class TestSequenceFunctions(unittest.TestCase):

    def setUp(self):
        self.seq = range(10)

    def test_prepare(self):
        source_file = 'dados/importacao/raw/' + 'MDIC_' + str(2002) + '.csv'
        exported_file = 'dados/importacao/sent/' + str(2002) + '_extract.csv'

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
                assert False

            finally:
                b += 1

        if((b / 100) > a):
            assert True
        else:
            assert False


if __name__ == '__main__':
    unittest.main()
