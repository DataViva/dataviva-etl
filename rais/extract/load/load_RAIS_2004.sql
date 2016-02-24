load data local infile 'H:/RAIS/Dados/2004/RAISCOMPL_SE_31122004.txt'
into table RAIS_2004
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2004/RAISCOMPL_NO_NE_CO_SU_31122004.txt'
into table RAIS_2004
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2004/RAISCOMPLINATIVOS2004.txt'
into table RAIS_2004
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;