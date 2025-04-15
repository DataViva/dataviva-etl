LOAD DATA LOCAL INFILE 'D:\\Dataviva\\dados\\EXP_2024_MUN.csv'
into table SECEX_2024_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
(CO_ANO,CO_MES,CO_SH4,CO_PAIS,CO_UF,CO_MUN_GEO,KG_LIQUIDO,VL_FOB);
