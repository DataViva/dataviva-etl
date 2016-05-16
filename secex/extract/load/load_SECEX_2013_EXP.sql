load data local infile 'H:/secex/Dados/Exportacao/EXP_2013_MUN.csv'
into table SECEX_2013_EXP
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
