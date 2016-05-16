load data local infile 'H:/secex/Dados/Exportacao/EXP_1999_MUN.csv'
into table SECEX_1999_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';