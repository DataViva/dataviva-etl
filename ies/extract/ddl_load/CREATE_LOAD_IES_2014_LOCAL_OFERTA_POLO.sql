use dataviva_raw;

drop table if exists IES_2014_LOCAL_OFERTA_POLO;
create table IES_2014_LOCAL_OFERTA_POLO(
CO_LOCAL_OFERTA_IES varchar(8),
NO_LOCAL_OFERTA varchar(255),
CO_IES varchar(8),
CO_UF_LOCAL_OFERTA varchar(8),
SGL_UF_LOCAL_OFERTA varchar(2),
CO_MUNICIPIO_LOCAL_OFERTA varchar(8),
NO_MUNICIPIO_LOCAL_OFERTA varchar(150),
DS_LOGRADOUR0 varchar(200),
NO_BAIRRO varchar(200),
DS_COMPLEMENTO varchar(100),
NU_ENDERECO varchar(20),
NU_CEP varchar(15),
IN_SEDE varchar(15),
CO_CURSO_POLO varchar(15),
CO_CURSO varchar(15),
IN_LOCAL_OFERTA_NEAD varchar(8),
IN_LOCAL_OFERTA_UAB varchar(8),
IN_LOCAL_OFERTA_REITORIA varchar(8),
IN_LOCAL_OFERTA_POLO varchar(8),
IN_LOCAL_OFERTA_UNID_ACADEMICA varchar(8),
DT_INICIO_FUNCIONAMENTO varchar(30)
);

load data local infile 'H:/HEDU/Dados/2014/Dados/DM_LOCAL_OFERTA.csv'
into table IES_2014_LOCAL_OFERTA_POLO
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

select * from IES_2014_LOCAL_OFERTA_POLO;

