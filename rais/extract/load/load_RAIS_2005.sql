load data local infile 'H:/RAIS/Dados/2005/RAISCOMPL_SE_31122005.txt'
into table RAIS_2005
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2005/RAISCOMPL_NO_NE_CO_SU_31122005.txt'
into table RAIS_2005
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2005/RAISCOMPLINATIVOS2005.txt'
into table RAIS_2005
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;