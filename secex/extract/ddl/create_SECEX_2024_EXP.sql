drop table if exists SECEX_2024_EXP;

CREATE TABLE SECEX_2024_EXP(
	CO_ANO integer,
	CO_MES integer,
	SH4 varchar(4),
	CO_PAIS varchar(3),			
	SG_UF_MUN varchar(2),		
	CO_MUN varchar(7),
	KG_LIQUIDO decimal (20,2),
	VL_FOB decimal (20,2)
)