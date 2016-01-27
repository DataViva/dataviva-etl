
load data local infile 'H:/RAIS/Dados/2006/RAISCOMPL_SE_31122006.txt'
into table RAIS_2006
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2006/RAISCOMPL_NO_NE_CO_SU_31122006.txt'
into table RAIS_2006
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

