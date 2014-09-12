from helpers import fixed_to_csv

''' Extract CSV file by year'''
def extract(year):
	if year < 2012:
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
			2011 : 'EPEMG_BREX201112_v201205'
		}

		source_file = 'dados/exportacao/raw/' + files[year] + '.txt'
		export_file = 'dados/exportacao/sent/' + str(year) + '_extract.csv'

		data = fixed_to_csv(source_file, ((0,4), (4,6), (6,14), (14,17), (18,20), (19,23), (23,30), (30,32), (32,47), (47,62), (62,78)), export_file, ('ANO', 'MES', 'HS', 'PAIS', 'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB'))


if __name__ == "__main__":
	extract(2000)

