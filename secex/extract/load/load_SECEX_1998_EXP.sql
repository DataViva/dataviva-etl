load data local infile 'H:/secex/Dados/Exportacao/EXP_1998_MUN.csv'
into table SECEX_1998_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';