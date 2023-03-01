/*Transformações nos dados SECEX (exportações) 
    a partir da tabela SECEX_2021_EXP
*/

/*
    A tabela SECEX_[ANO]_EXP_STEP1 é criada para o passo 1 
    das transformações. No STEP1 serão feitas transformações 
    referentes à codificação de produtos
*/
drop table if exists SECEX_2021_EXP_STEP1;

create table SECEX_2021_EXP_STEP1 select * from SECEX_2021_EXP;

/*
    A tabela HS_2007 contendo todos os códigos HS de 2007
    é criada.
*/

/*
drop table if exists HS_2017_2007;

CREATE TABLE HS_2017_2007(
SH4_2017 varchar(4),
SH4_2007 varchar(4)
); 

load data local infile '/home/dev4/Desktop/HS17_HS07.txt'
into table HS_2017_2007
character set 'latin1'
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;
*/

/*
    Substituição dos codigos HS_2021 pelos HS_2007 usando a tabela de correspondencia
*/

update SECEX_2021_EXP_STEP1 left join HS_2017_2007
on SECEX_2021_EXP_STEP1.CO_SH4 = HS_2017_2007.SH4_2017
set SECEX_2021_EXP_STEP1.CO_SH4 = HS_2017_2007.SH4_2007;
-- 603 row(s) affected Rows matched: 1075522  Changed: 603  Warnings: 0
-- 673 segundos

 /*
 Criação das variáveis capitulo e seção de produtos.
*/  

alter table SECEX_2021_EXP_STEP1 add (SECAO varchar(2), CAPITULO varchar(2));

/*
drop table if exists CAPITULOS_SECOES;	

create table CAPITULOS_SECOES(
    PRODUTO varchar(4),
    CAPITULO varchar(2),
    SECAO varchar(2)
);

load data local infile '/home/rodrigo/Documents/Econ/DataViva/SECEX/HS/product_chapter_section.txt'
into table CAPITULOS_SECOES
character set 'latin1'
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;
*/

update SECEX_2021_EXP_STEP1 left join CAPITULOS_SECOES
on SECEX_2021_EXP_STEP1.CO_SH4 = CAPITULOS_SECOES.PRODUTO
set SECEX_2021_EXP_STEP1.CAPITULO = CAPITULOS_SECOES.CAPITULO,
    SECEX_2021_EXP_STEP1.SECAO = CAPITULOS_SECOES.SECAO;
-- 1075522 row(s) affected Rows matched: 1075522  Changed: 1075522  Warnings: 0
-- 738 segundos

-- drop table CAPITULOS_SECOES; 
 
/* 
Criação do STEP 2. As transformações no STEP 2 serão referentes
a variáveis geográficas.
*/
drop table if exists SECEX_2021_EXP_STEP2;

create table SECEX_2021_EXP_STEP2 select * from SECEX_2021_EXP_STEP1;

/* transformação do código de municípios do MDIC para código IBGE*/

/*
drop table if exists merge_mun;

create table merge_mun(cod_ibge char(7), cod_mdic char(7));

load data local infile '/home/rodrigo/Documents/Econ/DataViva/SECEX/HS/Municipios_ibge_mdic.txt'
into table merge_mun
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;
*/

alter table SECEX_2021_EXP_STEP2 add MUN_IBGE varchar(7);

update SECEX_2021_EXP_STEP2 left join merge_mun
on SECEX_2021_EXP_STEP2.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;
-- Query OK, 1075469 rows affected (52 min 32.17 sec)
-- Rows matched: 1075522  Changed: 1075469  Warnings: 0

/* 
    Códigos de regiões, mesorregiões e microrregiões do IBGE 
    são carregados na tabela MUNICIPIOS_2016.
*/

update SECEX_2021_EXP_STEP2 set MUN_IBGE = if(MUN_IBGE is NULL, CO_MUN_GEO, MUN_IBGE);

-- drop table merge_mun;


drop table if exists MUNICIPIOS_2021;

create table MUNICIPIOS_2021 (
    CO_REGIAO varchar(1),
    CO_UF varchar(2),
    CO_MESO varchar(4),
    CO_MICRO varchar(5),
    CO_MUNICIPIO varchar(7)
);

load data local infile '/home/rodrigo/Documents/Econ/DataViva/SECEX/Municipios_Micro_Meso_Regioes2021.csv'
into table MUNICIPIOS_2021
character set 'utf8'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;


alter table SECEX_2021_EXP_STEP2 add (REGIAO varchar(1), UF varchar(2), MESORREGIAO varchar(4),MICRORREGIAO varchar(5));

update SECEX_2021_EXP_STEP2 left join MUNICIPIOS_2021
on SECEX_2021_EXP_STEP2.MUN_IBGE = MUNICIPIOS_2021.CO_MUNICIPIO
set SECEX_2021_EXP_STEP2.REGIAO = MUNICIPIOS_2021.CO_REGIAO,
    SECEX_2021_EXP_STEP2.UF = MUNICIPIOS_2021.CO_UF,
    SECEX_2021_EXP_STEP2.MESORREGIAO = MUNICIPIOS_2021.CO_MESO,
    SECEX_2021_EXP_STEP2.MICRORREGIAO = MUNICIPIOS_2021.CO_MICRO;
-- Query OK, 1075469 rows affected (1 hour 3 min 5.06 sec)
-- Rows matched: 1075522  Changed: 1075469  Warnings: 0
    
-- drop table MUNICIPIOS_2021;
    
/* inserindo código de continentes na tabela*/

alter table SECEX_2021_EXP_STEP2 add (CO_CONTINENTE varchar(2));

/*
drop table if exists CONTINENTES;

create table CONTINENTES (
    CO_CONTINENTE varchar(2),
    CO_PAIS_MDIC varchar(3),
    NO_CONTINENTE_EN varchar(20),
    NO_CONTINENTE_PT varchar(20)
);

load data local infile '/home/rodrigo/Documents/Econ/DataViva/SECEX/HS/continents.csv'
into table CONTINENTES
character set 'utf8'
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;
*/

update SECEX_2021_EXP_STEP2 left join CONTINENTES
on SECEX_2021_EXP_STEP2.CO_PAIS = CONTINENTES.CO_PAIS_MDIC
set SECEX_2021_EXP_STEP2.CO_CONTINENTE = CONTINENTES.CO_CONTINENTE;
-- Query OK, 1075406 rows affected (2 min 53.48 sec)
-- Rows matched: 1075522  Changed: 1075406  Warnings: 0

-- drop table CONTINENTES;

alter table SECEX_2021_EXP_STEP2 add (tipo varchar(7));

update SECEX_2021_EXP_STEP2 set SECEX_2021_EXP_STEP2.tipo = 'export';


/* criação do STEP3. O STEP 3 vai ajustar a tabela para 
   compatibilizar com o REDSHIFT*/

drop table if exists SECEX_2021_EXP_STEP3;
    
create table SECEX_2021_EXP_STEP3 (
    type varchar(6),
    year integer,
    month integer,
    continent varchar(2),
    country varchar(3),
    region varchar(3),
    mesoregion varchar(4),
    microregion varchar(5),
    state varchar(2),
    municipality varchar(7),
    port varchar(4),
    product_section varchar(2),
    product_chapter varchar(2),
    product varchar(4),
    kg bigint,
    value bigint,
    hidden boolean
);
  
insert into SECEX_2021_EXP_STEP3 (
	type, year, month, continent, country, region, mesoregion, 
	microregion, state, municipality, port, product_section, 
	product_chapter, product, kg, value, hidden)
select tipo, CO_ANO, CO_MES, CO_CONTINENTE, CO_PAIS, REGIAO, MESORREGIAO, 
	MICRORREGIAO, UF, MUN_IBGE, '', SECAO,
	CAPITULO, CO_SH4, KG_LIQUIDO, VL_FOB, true   
from SECEX_2021_EXP_STEP2; 
-- Query OK, 1075522 rows affected (7.74 sec)
-- Records: 1075522  Duplicates: 0  Warnings: 0

/* transformando as céluas Null e espaço vazio*/

update SECEX_2021_EXP_STEP3 set municipality = '' where municipality is null;

update SECEX_2021_EXP_STEP3 set microregion = '' where microregion is null; 

update SECEX_2021_EXP_STEP3 set mesoregion = '' where mesoregion is null; 

update SECEX_2021_EXP_STEP3 set state = '' where municipality in (9400000, 9999999); 

update SECEX_2021_EXP_STEP3 set region = '' where municipality in (9400000, 9999999); 

update SECEX_2021_EXP_STEP3 set region = '' where region is null;

update SECEX_2021_EXP_STEP3 set state = '' where region is null;   

update SECEX_2021_EXP_STEP3 set continent = '' where continent is null; 

/*
mysql> update SECEX_2021_EXP_STEP3 set municipality = '' where municipality is null;
Query OK, 0 rows affected (1.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set microregion = '' where microregion is null; 
Query OK, 53 rows affected (0.99 sec)
Rows matched: 53  Changed: 53  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set mesoregion = '' where mesoregion is null; 
Query OK, 53 rows affected (1.02 sec)
Rows matched: 53  Changed: 53  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set state = '' where municipality in (9400000, 9999999); 
Query OK, 0 rows affected (1.06 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set region = '' where municipality in (9400000, 9999999); 
Query OK, 0 rows affected (1.06 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set region = '' where region is null;
Query OK, 53 rows affected (0.98 sec)
Rows matched: 53  Changed: 53  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set state = '' where region is null;   
Query OK, 0 rows affected (0.98 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> 
mysql> update SECEX_2021_EXP_STEP3 set continent = '' where continent is null; 
Query OK, 116 rows affected (1.00 sec)
Rows matched: 116  Changed: 116  Warnings: 0
*/

/*testando se as transformações tiveram sucesso - conferir com os resultados disponibilizados
no site do mdic: http://www.mdic.gov.br/comercio-exterior/estatisticas-de-comercio-exterior/comex-vis*/

/*
select municipality, sum(value) from SECEX_2021_EXP_STEP3 where state = 31 group by municipality;

select product, sum(value) from SECEX_2021_EXP_STEP3 where municipality = 3550308 group by product;

select state, sum(value) from SECEX_2021_EXP_STEP3 group by state;

select mesoregion, sum(value) from SECEX_2021_EXP_STEP3 group by mesoregion;

select microregion, sum(value) from SECEX_2021_EXP_STEP3 group by microregion;
*/
