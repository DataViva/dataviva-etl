use dataviva_raw;

drop table if exists SECEX_2017_IMP;

CREATE TABLE SECEX_2017_IMP(
	CO_ANO integer,
	CO_MES integer,
	CO_SH4 varchar(4),
	CO_PAIS varchar(3),			
	CO_UF varchar(2),
	CO_PORTO varchar(4),		
	CO_MUN_GEO varchar(7),
	KG_LIQUIDO decimal (20,2),
	VL_FOB decimal (20,2)
); 

load data local infile '/home/dev4/Desktop/SECEX/IMP_2017_MUN.csv'
into table SECEX_2017_IMP
character set 'latin1'
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

/* 
    Transformações nos dados SECEX (importações) 
    a partir da tabela SECEX_2017_IMP
*/

/*
    A tabela SECEX_[ANO]_IMP_STEP1 é criada para o passo 1 
    das transformações. No STEP1 serão feitas transformações 
    referentes à codificação de produtos
*/
drop table if exists SECEX_2017_IMP_STEP1;

create table SECEX_2017_IMP_STEP1 select * from SECEX_2017_IMP;

/*
    A tabela HS_2007 contendo todos os códigos HS de 2007
    é criada.
*/

drop table if exists HS_2017_2007;

CREATE TABLE HS_2017_2007(
SH4_2017 varchar(4),
SH4_2007 varchar(4)
); 

load data local infile '/home/dev4/Desktop/SECEX/Correspondencia SH4_17xSH4_07.csv'
into table HS_2017_2007
character set 'latin1'
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;

/*
    Substituição dos codigos HS_2017 pelos HS_2007 usando a tabela de correspondencia
*/

update SECEX_2017_IMP_STEP1 left join HS_2017_2007
on SECEX_2017_IMP_STEP1.CO_SH4 = HS_2017_2007.SH4_2017
set SECEX_2017_IMP_STEP1.CO_SH4 = HS_2017_2007.SH4_2007;

 /*
 Criação das variáveis capitulo e seção de produtos.
*/  

alter table SECEX_2017_IMP_STEP1 add (SECAO varchar(2), CAPITULO varchar(2));

drop table if exists CAPITULOS_SECOES;	

create table CAPITULOS_SECOES(
    PRODUTO varchar(4),
    CAPITULO varchar(2),
    SECAO varchar(2)
);

load data local infile '/home/dev4/Desktop/SECEX/product_chapter_section.csv'
into table CAPITULOS_SECOES
character set 'latin1'
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

update SECEX_2017_IMP_STEP1 left join CAPITULOS_SECOES
on SECEX_2017_IMP_STEP1.CO_SH4 = CAPITULOS_SECOES.PRODUTO
set SECEX_2017_IMP_STEP1.CAPITULO = CAPITULOS_SECOES.CAPITULO,
    SECEX_2017_IMP_STEP1.SECAO = CAPITULOS_SECOES.SECAO;

drop table CAPITULOS_SECOES; 
 
/* 

Criação do STEP 2. As transformações no STEP 2 serão referentes
a variáveis geográficas.

*/
drop table if exists SECEX_2017_IMP_STEP2;

create table SECEX_2017_IMP_STEP2 select * from SECEX_2017_IMP_STEP1;

-- Homogeneização dos códigos de unidades federativas

drop table if exists merge_uf;

create table merge_uf(cod_ibge varchar(2), cod_mdic varchar(2));

load data local infile '/home/dev4/Desktop/SECEX/UF_ibge_mdic.txt'
into table merge_uf
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table SECEX_2017_IMP_STEP2 add UF_IBGE varchar(2);

update SECEX_2017_IMP_STEP2 left join merge_uf 
on SECEX_2017_IMP_STEP2.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_2017_IMP_STEP2 set UF_IBGE = if(UF_IBGE is NULL, CO_UF, UF_IBGE);

drop table merge_uf;

drop table if exists merge_mun;

create table merge_mun(cod_ibge char(7), cod_mdic char(7));

load data local infile '/home/dev4/Desktop/SECEX/Municipios_ibge_mdic.txt'
into table merge_mun
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table SECEX_2017_IMP_STEP2 add MUN_IBGE varchar(7) ;

update SECEX_2017_IMP_STEP2 left join merge_mun 
on SECEX_2017_IMP_STEP2.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

drop table merge_mun;

/* 
    Códigos de regiões, mesorregiões e microrregiões do IBGE 
    são carregados na tabela MUNICIPIOS_2016.
*/  
drop table if exists MUNICIPIOS_2016;

create table MUNICIPIOS_2016 (
    CO_MUN_6 varchar(6),
    CO_MUN_7 varchar(7),
    CO_REGIAO varchar(1),
    CO_MESORREGIAO varchar(4),
    CO_MICRORREGIAO varchar(5)   
);

load data local infile '/home/dev4/Desktop/SECEX/Municipios_Micro_Meso_Regioes.csv'
into table MUNICIPIOS_2016
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table SECEX_2017_IMP_STEP2 add (REGIAO varchar(1), 
                                 MESORREGIAO varchar(4), MICRORREGIAO varchar(5));

update SECEX_2017_IMP_STEP2 left join MUNICIPIOS_2016
on SECEX_2017_IMP_STEP2.MUN_IBGE = MUNICIPIOS_2016.CO_MUN_7
set SECEX_2017_IMP_STEP2.REGIAO = MUNICIPIOS_2016.CO_REGIAO,
    SECEX_2017_IMP_STEP2.MESORREGIAO = MUNICIPIOS_2016.CO_MESORREGIAO,
    SECEX_2017_IMP_STEP2.MICRORREGIAO = MUNICIPIOS_2016.CO_MICRORREGIAO;
    
drop table MUNICIPIOS_2016;
    
alter table SECEX_2017_IMP_STEP2 add (CO_CONTINENTE varchar(2));

drop table if exists CONTINENTES;

create table CONTINENTES (
    CO_CONTINENTE varchar(2),
    CO_PAIS_MDIC varchar(3),
    NO_CONTINENTE_EN varchar(20),
    NO_CONTINENTE_PT varchar(20)
);

load data local infile '/home/dev4/Desktop/SECEX/continents.csv'
into table CONTINENTES
character set 'latin1'
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

update SECEX_2017_IMP_STEP2 left join CONTINENTES
on SECEX_2017_IMP_STEP2.CO_PAIS = CONTINENTES.CO_PAIS_MDIC
set SECEX_2017_IMP_STEP2.CO_CONTINENTE = CONTINENTES.CO_CONTINENTE;

drop table CONTINENTES;

alter table SECEX_2017_IMP_STEP2 add (tipo varchar(7));

update SECEX_2017_IMP_STEP2 set SECEX_2017_IMP_STEP2.tipo = 'import';


/* criação do STEP3. O STEP 3 vai ajustar a tabela para 
   compatibilizar com o REDSHIFT*/

drop table if exists SECEX_2017_IMP_STEP3;
    
create table SECEX_2017_IMP_STEP3 (
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
  
  insert into SECEX_2017_IMP_STEP3 (
  type, year, month, continent, country, region, mesoregion, 
  microregion, state, municipality, port, product_section, 
  product_chapter, product, kg, value, hidden)
select tipo, CO_ANO, CO_MES, CO_CONTINENTE, CO_PAIS, REGIAO, MESORREGIAO, 
  MICRORREGIAO, UF_IBGE, MUN_IBGE, CO_PORTO, SECAO,
  CAPITULO, CO_SH4, KG_LIQUIDO, VL_FOB, true   
from SECEX_2017_IMP_STEP2; 


/* transformando as céluas Null e espaço vazio*/

update SECEX_2017_IMP_STEP3 set microregion = '' where microregion is null; 

update SECEX_2017_IMP_STEP3 set mesoregion = '' where mesoregion is null; 

update SECEX_2017_IMP_STEP3 set state = '' where municipality in (9400000, 9999999); 

update SECEX_2017_IMP_STEP3 set region = '' where municipality in (9400000, 9999999);
