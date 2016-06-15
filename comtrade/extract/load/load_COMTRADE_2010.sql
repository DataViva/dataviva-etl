load data local infile 'H:/comtrade/Dados/comtrade_2010.csv'
into table COMTRADE_2010
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;