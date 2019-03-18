use secex;

drop table if exists SECEX_2018_IMP;

CREATE TABLE SECEX_2018_IMP(
	CO_ANO integer,
	CO_MES integer,
	CO_SH4 varchar(4),
	CO_PAIS varchar(3),			
	CO_UF varchar(2),
		CO_MUN_GEO varchar(7),
	KG_LIQUIDO decimal (20,2),
	VL_FOB decimal (20,2)
); 