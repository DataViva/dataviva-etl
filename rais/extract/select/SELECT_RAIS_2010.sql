
-- Select RAIS 2010

use dataviva_raw;

-- update RAIS_2010 set SEXO=right(SEXO,1);

-- STEP 1: Criando a tabela com as variávies selecionadas:

create table RAIS_2010_STEP1 SELECT PIS, IDENTIFICAD, MUNICIPIO_FONTE as MUNICIPIO, SEXO_FONTE as SEXO,
			 IDADE, RADIC_CNPJ as ETNIA, GRAU_INSTR_FONTE as ESCOLARIDADE, REM_DEZEMBRO as REMUNERACAO,
             CBO_2002_FONTE as CBO2002, CLAS_CNAE_20_FONTE as CNAE20, TAM_ESTAB_FONTE as TAM_ESTAB, 
             IND_SIMPLES_FONTE as SIMPLES, NATUR_JUR_FONTE as NATUR_JUR
             FROM RAIS_2010 WHERE EMP_31_12_FONTE = '1';

-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

drop table RAIS_2010_STEP2;


create table RAIS_2010_STEP2 select * from RAIS_2010_STEP1;

/* Recodificando a variável SEXO */

create table genero(FONTE varchar(15), SEXO int(1));
insert into genero values('MASCULINO',1),('FEMININO',0);

update RAIS_2010_STEP2 left join genero 
on RAIS_2010_STEP2.SEXO = genero.FONTE
set RAIS_2010_STEP2.SEXO = genero.SEXO;

drop table genero;

select SEXO, count(*) from RAIS_2010_STEP2 group by SEXO;

/* Recodificando a variável ETNIA */

create table etnia(
  FONTE int(1),
  ETNIA int(1)
);

insert into etnia values(1,1),(2,2),(4,4),(6,6),(8,8),(9,-1),(99,-1);

update RAIS_2010_STEP2 left join etnia 
on RAIS_2010_STEP2.ETNIA = etnia.FONTE
set RAIS_2010_STEP2.ETNIA = etnia.ETNIA;

drop table etnia;

update RAIS_2010_STEP2 set ETNIA=if(ETNIA is null,-1,ETNIA);


select ETNIA, count(*) from RAIS_2010_STEP2 group by ETNIA;



/* Renomeando a variável CBO2002 */

update RAIS_2010_STEP2 set CBO2002 = left(CBO2002,4);

update RAIS_2010_STEP2 set CBO2002 = 
if(CBO2002='0101' or CBO2002='0102' or CBO2002='0103' 
  or CBO2002='0201' or CBO2002='0202' or CBO2002='0203' or CBO2002='0211' 
    or CBO2002='0212' or CBO2002='0301' or CBO2002='0302' or CBO2002='0303'
  or CBO2002='0311' or CBO2002='0312' or CBO2002='0000','-1',CBO2002);

select CBO2002, count(*) from RAIS_2010_STEP2 group by CBO2002;

/* Renomeando a variável CNAE 2.0 */

select CNAE20, count(*) from RAIS_2010_STEP2 group by CNAE20;


/* *** Recodificando a variável ESCOLARIDADE *** */

create table escolaridade(
  FONTE varchar(2),
  ESCOLARIDADE int(1)
);

insert into escolaridade values('1',1),('2',2),('3',2),('4',2),('5',3),('6',4),
                 ('7',5),('8',6),('9',7),('10',7),('11',7);

update RAIS_2010_STEP2 left join escolaridade 
on RAIS_2010_STEP2.ESCOLARIDADE = escolaridade.FONTE
set RAIS_2010_STEP2.ESCOLARIDADE = escolaridade.ESCOLARIDADE;

drop table if exists escolaridade;

select ESCOLARIDADE, count(*) from RAIS_2010_STEP2 group by ESCOLARIDADE;

/* Renomeando a variável Simples */

select TAM_ESTAB, count(*) from RAIS_2010_STEP2 group by TAM_ESTAB;


/* *** Recodificando a variável TAMANHO DO ESTABELECIMENTO *** */

create table tamestab(
  FONTE int(2),
  TAM_ESTAB int(1)
);

insert into tamestab values('0',0),('1',1),('2',1),('3',1),('4',2),('5',2),
               ('6',3),('7',3),('8',4),('9',4);

update RAIS_2010_STEP2 left join tamestab 
on RAIS_2010_STEP2.TAM_ESTAB = tamestab.FONTE
set RAIS_2010_STEP2.TAM_ESTAB = tamestab.TAM_ESTAB;

drop table if exists tamestab;


/* *** Recodificando a variável NATUREZA JURIDICA *** */

drop table if exists natjur;

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

update RAIS_2010_STEP2 left join natjur 
on RAIS_2010_STEP2.NATUR_JUR = natjur.FONTE
set RAIS_2010_STEP2.NATUR_JUR = natjur.NATUR_JUR;

drop table if exists natjur;

select NATUR_JUR, count(*) from RAIS_2010_STEP2 group by NATUR_JUR;

/* *** Transformando a variável REMUNERACAO em variável numérica *** */
  
update RAIS_2010_STEP2 set REMUNERACAO = replace(REMUNERACAO,',','.');

alter table RAIS_2010_STEP2 change REMUNERACAO REMUNERACAO double(14,2);

/* *** Transformando a variável IDADE em variável numérica *** */

alter table RAIS_2010_STEP2 change IDADE IDADE int(3);

update RAIS_2010_STEP2 set IDADE=if(IDADE>100,0,IDADE);

-- STEP 3: Transformação e Padronização das variáveis selecionadas no STEP 2:

drop table if exists RAIS_2010_STEP3;
create table RAIS_2010_STEP3 select * from RAIS_2010_STEP2;




