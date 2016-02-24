
load data local infile 'H:/RAIS/Dados/2003/RAISCOMPL_SE_31122003.txt'
into table RAIS_2003
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


load data local infile 'H:/RAIS/Dados/2003/RAISCOMPL_NO_NE_CO_SU_31122003.txt'
into table RAIS_2003
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'H:/RAIS/Dados/2003/RAISCOMPLINATIVOS2003.txt'
into table RAIS_2003
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;
