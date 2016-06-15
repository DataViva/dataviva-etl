load data local infile 'H:/comtrade/Dados/comtrade_2000.csv'
into table COMTRADE_2000
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;