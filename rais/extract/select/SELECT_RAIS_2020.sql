/*Transformações nos dados do RAIS 
    a partir da tabela RAIS_2020
*/

use dataviva_raw;

/*
    A tabela RAIS_STEP1 é criada para o passo 1 
    das transformações.
*/
drop table if exists RAIS_2020_STEP1;

create table RAIS_2020_STEP1 (
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

insert into RAIS_2020_STEP1
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
from RAIS_2020 
where EMP_31_12 = 1;    


-- Recodificação da variável SEXO
update RAIS_2020_STEP1 set SEXO = if(SEXO = 2, 0, SEXO);

-- Recodificação da variável RACA_COR  
update RAIS_2020_STEP1 set RACA_COR = if(RACA_COR = -1 or RACA_COR = 9 or RACA_COR = 99, -1, right(RACA_COR,1));

-- Recodificação da variável GR_INSTRUCAO 
create table escolaridade(FONTE varchar(2), ESCOLARIDADE int(1));

insert into escolaridade values('01',1),('02',2),('03',2),('04',2),('05',3),('06',4),
                 ('07',5),('08',6),('09',7),('10',7),('11',7),('-1',-1);

update RAIS_2020_STEP1 left join escolaridade 
on RAIS_2020_STEP1.GR_INSTRUCAO = escolaridade.FONTE
set RAIS_2020_STEP1.GR_INSTRUCAO = escolaridade.ESCOLARIDADE;

drop table escolaridade;

-- Recodificação da variável TAM_ESTAB
create table tamestab(FONTE varchar(2), TAM_ESTAB int(1));

insert into tamestab values('00',0),('01',0),('02',1),('03',1),('04',1),('05',2),
               ('06',2),('07',3),('08',3),('09',4),('10',4),('-1',-1);

update RAIS_2020_STEP1 left join tamestab 
on RAIS_2020_STEP1.TAM_ESTAB = tamestab.FONTE
set RAIS_2020_STEP1.TAM_ESTAB = tamestab.TAM_ESTAB;

drop table tamestab;

/*
    Recodificação dos valores da variável OCUP_2002 para ocupações 
    referentes às forças armadas, polícia militar e corpo de bombeiros
*/
update RAIS_2020_STEP1 set OCUP_2002 = 
   if(OCUP_2002 IN ('0101', '0102', '0103', '0201', '0202', '0203', '0211', '0212',
  '0301', '0302', '0303', '0311', '0312', '0000'),'-1', OCUP_2002);
