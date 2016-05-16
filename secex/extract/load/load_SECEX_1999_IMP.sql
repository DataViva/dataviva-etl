load data local infile 'H:/secex/Dados/Importacao/IMP_1999_MUN.csv'
into table SECEX_1999_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';