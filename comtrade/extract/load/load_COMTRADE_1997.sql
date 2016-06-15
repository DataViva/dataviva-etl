load data local infile 'H:/comtrade/Dados/comtrade_1997.csv'
into table COMTRADE_1997
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;