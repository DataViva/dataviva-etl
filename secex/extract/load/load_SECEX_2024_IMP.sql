LOAD DATA LOCAL INFILE 'D:\\Dataviva\\dados\\IMP_2024_MUN.csv'
into table SECEX_2024_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines

