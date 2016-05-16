load data local infile 'H:/secex/Dados/Exportacao/EXP_2004_MUN.csv'
into table SECEX_2004_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';