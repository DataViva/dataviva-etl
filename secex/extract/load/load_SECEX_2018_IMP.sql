use secex;

load data local infile '/home/dev4/Desktop/IMP_2018_MUN.csv'
into table SECEX_2018_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
