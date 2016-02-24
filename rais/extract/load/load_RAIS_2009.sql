load data local infile 'H:/RAIS/Dados/2009/RAISCOMPL_NO_NE_CO_SU_31122009.txt'
into table RAIS_2009
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2009/RAISCOMPL_SE_31122009.txt'
into table RAIS_2009
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2009/RAISCOMPLINATIVOS2009.txt'
into table RAIS_2009
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;
