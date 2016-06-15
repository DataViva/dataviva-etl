load data local infile 'H:/comtrade/Dados/comtrade_1998.csv'
into table COMTRADE_1998
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;