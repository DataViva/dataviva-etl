load data local infile '/home/dev1/Desktop/comtrade_2017.csv'
into table COMTRADE_2017
character set 'latin1'
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
