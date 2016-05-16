load data local infile 'H:/secex/Dados/Exportacao/EXP_2002_MUN.csv'
into table SECEX_2002_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';