load data local infile 'H:/comtrade/Dados/comtrade_2005.csv'
into table COMTRADE_2005
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;