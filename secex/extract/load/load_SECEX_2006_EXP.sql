load data local infile 'H:/secex/Dados/Exportacao/EXP_2006_MUN.csv'
into table SECEX_2006_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';