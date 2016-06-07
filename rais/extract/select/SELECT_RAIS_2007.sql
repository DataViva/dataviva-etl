-- Select RAIS 2007

use dataviva_raw;

-- STEP 1: Criando a tabela com as variávies selecionadas:

-- update RAIS_2007 set EMP_31_12 = if(EMP_31_12 is NULL,'1',EMP_31_12);

create table RAIS_2007_STEP1 SELECT PIS, IDENTIFICAD, MUNICIPIO, SEXO, IDADE, RACA_COR as ETNIA, 
		GR_INSTRUCAO as ESCOLARIDADE, REM_DEZ_RS as REMUNERACAO, OCUP_2002 as CBO2002, 
        CLAS_CNAE_20 as CNAE20, TAM_ESTAB, IND_SIMPLES as SIMPLES, NATUR_JUR
        FROM RAIS_2007 WHERE EMP_31_12='1';


-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

drop table RAIS_2007_STEP2;
create table RAIS_2007_STEP2 select * from RAIS_2007_STEP1 where CBO2002 is not null;



/* Recodificando a variável SEXO */

create table genero(FONTE varchar(13), SEXO int(1));
insert into genero values('MASCULINO',1),('FEMININO',0);

update RAIS_2007_STEP2 left join genero 
on RAIS_2007_STEP2.SEXO = genero.FONTE
set RAIS_2007_STEP2.SEXO = genero.SEXO;

drop table genero;

/* Recodificando a variável ETNIA */

update RAIS_2007_STEP2 set ETNIA = if(ETNIA is null, '-1', ETNIA);

create table etnia(
  FONTE int(1),
  ETNIA int(1)
);

insert into etnia values(1,1),(2,2),(4,4),(6,6),(8,8),(9,-1),(-1,-1);

update RAIS_2007_STEP2 left join etnia 
on RAIS_2007_STEP2.ETNIA = etnia.FONTE
set RAIS_2007_STEP2.ETNIA = etnia.ETNIA;

drop table etnia;


/* Renomeando a variável CBO2002 */

select * from RAIS_2007 where CBO2002 is null;


select * from RAIS_2007_STEP2 where CBO2002 is null;

update RAIS_2007_STEP2 set CBO2002 = if(CBO2002='NORA', '-1', CBO2002);


update RAIS_2007_STEP2 set CBO2002 = right(CBO2002,6);

update RAIS_2007_STEP2 set CBO2002 = left(CBO2002,4);

update RAIS_2007_STEP2 set CBO2002 = 
if(CBO2002='0101' or CBO2002='0102' or CBO2002='0103' 
	or CBO2002='0201' or CBO2002='0202' or CBO2002='0203' or CBO2002='0211' 
    or CBO2002='0212' or CBO2002='0301' or CBO2002='0302' or CBO2002='0303'
	or CBO2002='0311' or CBO2002='0312','-1',CBO2002);

update RAIS_2007_STEP2 set CBO2002 = if(CBO2002 is null or CBO2002='NORA', '-1', CBO2002);


/* Renomeando a variável CNAE 2.0 */

update RAIS_2007_STEP2 set CNAE20 = if(CNAE20 is null, '-1', CNAE20);

/* *** Recodificando a variável ESCOLARIDADE *** */

create table escolaridade(
  FONTE int(1),
  ESCOLARIDADE int(1)
);

insert into escolaridade values(1,1),(2,2),(3,2),(4,2),(5,3),(6,4),(7,5),(8,6),(9,7),(10,7),(11,7),(-1,-1);

update RAIS_2007_STEP2 left join escolaridade 
on RAIS_2007_STEP2.ESCOLARIDADE = escolaridade.FONTE
set RAIS_2007_STEP2.ESCOLARIDADE = escolaridade.ESCOLARIDADE;

drop table if exists escolaridade;

/* Renomeando a variável Simples */


/* *** Recodificando a variável TAMANHO DO ESTABELECIMENTO *** */

create table tamestab(
  FONTE int(1),
  TAM_ESTAB int(1)
);

insert into tamestab values(0,0),(1,1),(2,1),(3,1),(4,2),(5,2),(6,3),(7,3),(8,4),(9,4),(-1,-1);

update RAIS_2007_STEP2 left join tamestab 
on RAIS_2007_STEP2.TAM_ESTAB = tamestab.FONTE
set RAIS_2007_STEP2.TAM_ESTAB = tamestab.TAM_ESTAB;

drop table if exists tamestab;

/* *** Recodificando a variável NATUREZA JURIDICA *** */

create table natjur(
  FONTE int(4),
  DESCRICAO varchar(200),
  NATUR_JUR int(1)
);

load data local infile 'Z:/Correspondencias_Classificacoes/Natureza_Juridica/Merge_Natureza_Juridica_Total.txt'
into table natjur
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

update RAIS_2007_STEP2 left join natjur 
on RAIS_2007_STEP2.NATUR_JUR = natjur.FONTE
set RAIS_2007_STEP2.NATUR_JUR = natjur.NATUR_JUR;

drop table if exists natjur;

/* *** Transformando a variável REMUNERACAO em variável numérica *** */

update RAIS_2007_STEP2 set REMUNERACAO = replace(REMUNERACAO,',','.');

alter table RAIS_2007_STEP2 change REMUNERACAO REMUNERACAO double(14,2);

/* *** Transformando a variável IDADE em variável numérica *** */

alter table RAIS_2007_STEP2 change IDADE IDADE int(3);

select IDADE, count(*) from RAIS_2007_STEP2 group by IDADE;


-- STEP 3: Transformação e Padronização das variáveis selecionadas no STEP 2:

create table RAIS_2007_STEP3 select * from RAIS_2007_STEP2;

