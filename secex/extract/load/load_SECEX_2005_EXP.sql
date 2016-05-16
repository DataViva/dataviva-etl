load data local infile 'H:/secex/Dados/Exportacao/EXP_2005_MUN.csv'
into table SECEX_2005_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';
