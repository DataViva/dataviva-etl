use dataviva_raw;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_CENTRO_OESTE.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_MG_ES_RJ.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_NORDESTE.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_NORTE.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_SP.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2021/RAIS_VINC_ID_SUL.txt'
into table RAIS_2021
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;