load data local infile 'H:/secex/Dados/Importacao/IMP_2010_MUN.csv'
into table SECEX_2010_IMP
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;