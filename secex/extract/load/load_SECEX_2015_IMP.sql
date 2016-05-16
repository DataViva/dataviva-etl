load data local infile 'H:/secex/Dados/Importacao/IMP_2015_MUN.csv'
into table SECEX_2015_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';