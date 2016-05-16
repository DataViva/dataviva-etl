load data local infile 'H:/secex/Dados/Importacao/IMP_2007_MUN.csv'
into table SECEX_2007_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';
