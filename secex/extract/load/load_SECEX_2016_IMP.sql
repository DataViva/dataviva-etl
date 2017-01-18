load data local infile 'Z:/secex/IMP_2016_MUN.csv'
into table SECEX_2016_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n';