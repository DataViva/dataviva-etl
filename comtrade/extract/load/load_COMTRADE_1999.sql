load data local infile 'H:/comtrade/Dados/comtrade_1999.csv'
into table COMTRADE_1999
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

