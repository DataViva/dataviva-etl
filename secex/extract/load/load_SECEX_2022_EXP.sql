load data local infile '/home/rodrigo/Documents/Econ/DataViva/SECEX/exports/EXP_2022_MUN.csv'
into table SECEX_2022_EXP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
(CO_ANO,CO_MES,CO_SH4,CO_PAIS,CO_UF,CO_MUN_GEO,KG_LIQUIDO,VL_FOB);
