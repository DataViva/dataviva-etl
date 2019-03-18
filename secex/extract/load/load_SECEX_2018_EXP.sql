use secex;

load data local infile 'C:/Users/E003004/Desktop/EXP_2018_MUN.csv'
into table SECEX_2018_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
