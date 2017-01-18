load data local infile 'Z:/secex/EXP_2016_MUN.csv'
into table SECEX_2016_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';
