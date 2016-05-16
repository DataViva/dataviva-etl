load data local infile 'H:/secex/Dados/Exportacao/EXP_2010_MUN.csv'
into table SECEX_2010_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';