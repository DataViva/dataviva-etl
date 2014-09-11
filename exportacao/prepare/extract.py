from helpers import fixed_to_csv

def loadCSV():
	return True

def extract(year):
	"""
	Keyword arguments:
    filefixed -- path of a file containg data in fixed register. ex.: filefixed='/fixedregister.txt'
    columns -- map of the positions of each column. ex.: columns = ((0,5),(5,18))
    csvfile -- name of the result of this operation, where CSV will be written. ex.: csvfile='/fixedregister.csv'
    headers -- name of each column to be written in CSV file. ex.: headers = ('ANO_CENSO','PK_COD_MATRICULA')
    """
	if(year == 2012):
		fixed_to_csv('dados/exportacao/raw/Exportacao_2012.txt', ((1,4), (5,6), (7,14), (15,17), (18,19), (20,23), (24,30), (31,32), (33,47), (48,62), (63,67)),
				'dados/exportacao/sent/2012.csv', ('ANO', 'MES', 'HS', 'PAIS', 'UF', 'PORTO', 'MUNICIPIO', 'UNIDADE', 'QUANTIDADE', 'KGLIQUIDO', 'VALORFOB'))
		



def greaterThan():
	return "ano maior que 2012"

def lessThan():
	return "ano menor que 2012"

def equal():
	return "ano igual a 2012"	

if __name__ == "__main__":
    extract(2012)
    