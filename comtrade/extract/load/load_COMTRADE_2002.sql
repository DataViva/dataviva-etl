load data local infile 'H:/comtrade/Dados/comtrade_2002.csv'
into table COMTRADE_2002
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;