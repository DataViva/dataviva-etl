load data local infile 'H:/RAIS/Dados/2008/RAISCOMPL_NO_NE_CO_SU_31122008.txt'
into table RAIS_2008
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2008/RAISCOMPL_SE_31122008.txt'
into table RAIS_2008
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2008/RAISCOMPLINATIVOS2008.txt'
into table RAIS_2008
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;