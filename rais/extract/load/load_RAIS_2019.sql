use dataviva_raw;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_CENTRO_OESTE.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_MG_ES_RJ.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_NORDESTE.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_NORTE.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_SP.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile 'C:/Users/Administrator/Desktop/data/2019/RAIS_VINC_ID_SUL.txt'
into table RAIS_2019
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

-- Os códigos a seguir são para incluir um índice para as principais variáveis e otimizar o processo de select no futuro.

CREATE INDEX index_municipio ON dataviva_raw.RAIS_2019 (MUNICIPIO);
CREATE INDEX index_cnae ON dataviva_raw.RAIS_2019 (CLAS_CNAE_20);
CREATE INDEX index_cbo ON dataviva_raw.RAIS_2019 (OCUP_2002);
CREATE INDEX index_emp3112 ON dataviva_raw.RAIS_2019 (EMP_31_12);
CREATE INDEX index_mun_cnae_cbo_emp ON dataviva_raw.RAIS_2019 (MUNICIPIO, CLAS_CNAE_20, OCUP_2002, EMP_31_12);
