load data local infile 'H:/RAIS/Dados/2010/RAISCOMPL_NO_NE_CO_SU_3112.txt'
into table RAIS_2010
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2010/RAISCOMPL_SE_3112.txt'
into table RAIS_2010
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2010/RAISCOMPLINATIVOS.txt'
into table RAIS_2010
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;