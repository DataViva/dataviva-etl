load data local infile '/home/dev2/Desktop/IMP_2017_MUN.csv'
into table SECEX_2017_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
