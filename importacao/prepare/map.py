from helpers import read_from_csv

HS_96_2002 = read_from_csv("docs/classificacao/HS/HS_96_2002.csv")
print HS_96_2002

Dados2000 = read_from_csv("dados/exportacao/raw/Exportacao_2012.txt",delimiter='|')
print Dados2000['CO_NCM']