load data local infile '/home/dev2/Desktop/EXP_2017_MUN.csv'
into table SECEX_2017_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;