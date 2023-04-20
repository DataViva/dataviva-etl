/*Transformações nos dados do RAIS 
    a partir da tabela RAIS_2019
*/

use dataviva_raw;

/*
    A tabela RAIS_STEP1 é criada para o passo 1 
    das transformações.
*/
drop table if exists RAIS_2019_STEP1;

create table RAIS_2019_STEP1 (
    PIS varchar(11),
    IDENTIFICAD varchar(14),
    MUNICIPIO varchar(7),
    SEXO varchar(1),
    IDADE integer,
    RACA_COR varchar(2),
    GR_INSTRUCAO varchar(2),
    REM_DEZ_RS numeric(17, 2),
    OCUP_2002 varchar(4),
    CLAS_CNAE_20 varchar(5),
    TAM_ESTAB varchar(2),
    IND_SIMPLES varchar(2),
    NATUR_JUR varchar(4),
    GRUPO_OCUPACAO varchar(1),
    DIVISAO varchar(2),
    SECAO varchar(1)
);

insert into RAIS_2019_STEP1
select PIS,
       IDENTIFICAD,
       MUNICIPIO,
       right(SEXO, 1), 
       IDADE,
       RACA_COR,
       right(GR_INSTRUCAO, 2),
       replace(REM_DEZ_RS,',','.'),
       left(OCUP_2002, 4),
       CLAS_CNAE_20,
       TAM_ESTAB,
       IND_SIMPLES,
       NATUR_JUR,
       NULL,
       NULL,
       NULL
from RAIS_2019 
where EMP_31_12 = 1;    


-- Recodificação da variável SEXO
update RAIS_2019_STEP1 set SEXO = if(SEXO = 2, 0, SEXO);

-- Recodificação da variável RACA_COR  
update RAIS_2019_STEP1 set RACA_COR = if(RACA_COR = -1 or RACA_COR = 9 or RACA_COR = 99, -1, right(RACA_COR,1));

-- Recodificação da variável GR_INSTRUCAO 
create table escolaridade(FONTE varchar(2), ESCOLARIDADE int(1));

insert into escolaridade values('01',1),('02',2),('03',2),('04',2),('05',3),('06',4),
                 ('07',5),('08',6),('09',7),('10',7),('11',7),('-1',-1);

update RAIS_2019_STEP1 left join escolaridade 
on RAIS_2019_STEP1.GR_INSTRUCAO = escolaridade.FONTE
set RAIS_2019_STEP1.GR_INSTRUCAO = escolaridade.ESCOLARIDADE;

drop table escolaridade;

-- Recodificação da variável TAM_ESTAB
create table tamestab(FONTE varchar(2), TAM_ESTAB int(1));

insert into tamestab values('00',0),('01',0),('02',1),('03',1),('04',1),('05',2),
               ('06',2),('07',3),('08',3),('09',4),('10',4),('-1',-1);

update RAIS_2019_STEP1 left join tamestab 
on RAIS_2019_STEP1.TAM_ESTAB = tamestab.FONTE
set RAIS_2019_STEP1.TAM_ESTAB = tamestab.TAM_ESTAB;

drop table tamestab;

/*
    Recodificação dos valores da variável OCUP_2002 para ocupações 
    referentes às forças armadas, polícia militar e corpo de bombeiros
*/
update RAIS_2019_STEP1 set OCUP_2002 = 
   if(OCUP_2002 IN ('0101', '0102', '0103', '0201', '0202', '0203', '0211', '0212',
  '0301', '0302', '0303', '0311', '0312', '0000'),'-1', OCUP_2002);

/*
    A tabela RAIS_2019_STEP2 é criada para o passo 2
    das transformações.
*/
drop table if exists RAIS_2019_STEP2;

create table RAIS_2019_STEP2 select * from RAIS_2019_STEP1;

drop table if exists natjur;

-- Recodificação da variável NATUR_JUR
create table natjur(
    FONTE int(4),
    DESCRICAO varchar(200),
    NATUR_JUR int(1)
);

load data local infile 'C:/Users/Administrator/Desktop/data/Merge_Natureza_Juridica_2018.csv'
into table natjur
character set 'latin1'
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

update RAIS_2019_STEP2 left join natjur 
on RAIS_2019_STEP2.NATUR_JUR = natjur.FONTE
set RAIS_2019_STEP2.NATUR_JUR = natjur.NATUR_JUR;

drop table natjur; 

/*
    Criação das variáveis divisão e seção da indústria 
    a partir de CLASS_CNAE_20
*/   
create table cnae (
    CLASSE varchar(5),
    DIVISAO varchar(2),
    SECAO varchar(1));

load data local infile 'C:/Users/Administrator/Desktop/data/estrutura_CNAE.txt'
into table cnae
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

update RAIS_2019_STEP2 left join cnae
on RAIS_2019_STEP2.CLAS_CNAE_20 = cnae.CLASSE
set RAIS_2019_STEP2.DIVISAO = cnae.DIVISAO, RAIS_2019_STEP2.SECAO = cnae.SECAO;

drop table cnae;

/*
    Criação da variável grupo de ocupação  
    a partir de OCUP_2002
*/
update RAIS_2019_STEP2 set GRUPO_OCUPACAO = left(OCUP_2002, 1);

-- Os códigos a seguir são para incluir um índice para as principais variáveis e otimizar o processo de select no futuro.

CREATE INDEX index_municipio ON dataviva_raw.RAIS_2019_STEP2 (MUNICIPIO);



/*
    A tabela RAIS_2019_STEP3 é criada para o passo 3
    das transformações.
*/
drop table if exists RAIS_2019_STEP3;

create table RAIS_2019_STEP3 (INDEX index_municipio (MUNICIPIO)) select * from RAIS_2019_STEP2;


/* 
    Códigos de municípios, mesorregiões e microrregiões do IBGE 
    (ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/)
    são carregados na tabela MUNICIPIOS_2017.
*/   
drop table if exists MUNICIPIOS_2017;

CREATE TABLE MUNICIPIOS_2017 (
    CO_MUN_6 varchar(6),
    CO_MUN_7 varchar(7),
    CO_REGIAO varchar(1),
    CO_UF varchar(2),
    CO_MESORREGIAO varchar(4),
    CO_MICRORREGIAO varchar(5),
    INDEX index_municipio (CO_MUN_6)   
);

load data local infile 'C:/Users/Administrator/Desktop/data/Municipios_Micro_Meso_Regioes.csv'
into table MUNICIPIOS_2017
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;


alter table RAIS_2019_STEP3 add (REGIAO varchar(1), UF varchar(2), 
                                 MESORREGIAO varchar(4), MICRORREGIAO varchar(5));

update RAIS_2019_STEP3 left join MUNICIPIOS_2017
on RAIS_2019_STEP3.MUNICIPIO = MUNICIPIOS_2017.CO_MUN_6
set RAIS_2019_STEP3.REGIAO = MUNICIPIOS_2017.CO_REGIAO,
    RAIS_2019_STEP3.UF = MUNICIPIOS_2017.CO_UF,
    RAIS_2019_STEP3.MESORREGIAO = MUNICIPIOS_2017.CO_MESORREGIAO,
    RAIS_2019_STEP3.MICRORREGIAO = MUNICIPIOS_2017.CO_MICRORREGIAO,
    RAIS_2019_STEP3.MUNICIPIO = MUNICIPIOS_2017.CO_MUN_7;

drop table MUNICIPIOS_2017;
