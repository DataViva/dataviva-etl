from helpers import *

''' Extract CSV file by year'''
def extract(year):

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
	export_file = 'dados/exportacao/sent/' + str(year) + '_extract.csv'

	if year < 2012:

		columns = ((0,4), (4,6), (6,14), (14,17), (18,20), (19,23), (23,30), (30,32), (32,47), (47,62), (62,78))

		headers = ('ANO', 'MES', 'HS', 'PAIS', 'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB')
		data = fixed_to_csv(source_file, columns, export_file, headers)

	elif year == 2012:

		cols = ('ANO', 'MES', 'HS', 'NO_NCM', 'PAIS', 'NO_PAIS', 'UF', 'NO_UF', 'MUNICIPIO', 'NO_MUN', 'PORTO', 'NO_PORTO', 'UNIDADE', 'NO_UNID', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB')

		df = read_from_csv(source_file, 1,"|", cols, None)
		df = df.drop(['NO_NCM', 'NO_PAIS', 'NO_UF', 'NO_PORTO', 'NO_MUN', 'NO_UNID'], 1)
		df_to_csv(df, export_file, None)

	else:

		cols = ('ANO', 'MES', 'HS', 'PAIS',  'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB')
		df = read_from_csv(source_file, 1,"|", cols, None)
		df_to_csv(df, export_file, None)


if __name__ == "__main__":
	extract(2012)

