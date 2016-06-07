-- Select RAIS 2005

use dataviva_raw;

-- STEP 1: Criando a tabela com as variávies selecionadas:

create table RAIS_2005_STEP1 SELECT PIS, IDENTIFICAD, MUNICIPIO_FONTE, SEXO as SEXO_FONTE, IDADE, RACA_COR_FONTE, GRAU_INSTR_FONTE,
		REM_DEZ_RS, CBO_2002_FONTE, CLAS_CNAE_95, TAM_ESTAB_FONTE, IND_SIMPLES_FONTE, NATUR_JUR_FONTE
        FROM RAIS_2005 WHERE EMP_31_12_FONTE='1';


-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

create table RAIS_2005_STEP2 select * from RAIS_2005_STEP1;

/* Renomeando a variável MUNICIPIO */

alter table RAIS_2005_STEP2 change MUNICIPIO_FONTE MUNICIPIO VARCHAR(6);

/* Recodificando a variável SEXO */

create table genero(FONTE varchar(13), SEXO int(1));
insert into genero values('MASCULINO',1),('FEMININO',0);

alter table RAIS_2005_STEP2 add SEXO int(1);

update RAIS_2005_STEP2 left join genero 
on RAIS_2005_STEP2.SEXO_FONTE = genero.FONTE
set RAIS_2005_STEP2.SEXO = genero.SEXO;

alter table RAIS_2005_STEP2 drop SEXO_FONTE;

drop table genero;

/* Recodificando a variável ETNIA */

create table etnia(
  FONTE int(1),
  ETNIA int(1)
);

insert into etnia values(1,1),(2,2),(4,4),(6,6),(8,8),(9,-1);

alter table RAIS_2005_STEP2 add ETNIA int(1);

update RAIS_2005_STEP2 left join etnia 
on RAIS_2005_STEP2.RACA_COR_FONTE = etnia.FONTE
set RAIS_2005_STEP2.ETNIA = etnia.ETNIA;

alter table RAIS_2005_STEP2 drop RACA_COR_FONTE;

drop table etnia;

/* Renomeando a variável CBO2002 */

alter table RAIS_2005_STEP2 change CBO_2002_FONTE CBO2002 VARCHAR(6);

update RAIS_2005_STEP2 set CBO2002 = left(CBO2002,4);

update RAIS_2005_STEP2 set CBO2002 = 
if(CBO2002='0101' or CBO2002='0102' or CBO2002='0103' 
	or CBO2002='0201' or CBO2002='0202' or CBO2002='0203' or CBO2002='0211' 
    or CBO2002='0212' or CBO2002='0301' or CBO2002='0302' or CBO2002='0303'
	or CBO2002='0311' or CBO2002='0312','-1',CBO2002);


/* Transformando CNAE 1.0 para CNAE 2.0 */

create table merge_cnae(
CLASCNAE95 varchar(12),
CLASCNAE95_Desc varchar(200),
SBCLAS20 varchar (12),
SBCLAS20_Desc varchar(200),
CLASCNAE20 varchar(12),
CLASCNAE20_Desc varchar(200)
);

load data local infile 'Z:/Correspondencias_Classificacoes/CNAE/RAIS_MERGE_CNAE95.txt'
into table merge_cnae
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table merge_cnae drop CLASCNAE95_Desc, drop SBCLAS20_Desc, drop CLASCNAE20_Desc, drop CLASCNAE20;

alter table RAIS_2005_STEP2 add CNAE20 varchar(15);

update RAIS_2005_STEP2 left join merge_cnae 
on RAIS_2005_STEP2.CLAS_CNAE_95 = merge_cnae.CLASCNAE95
set RAIS_2005_STEP2.CNAE20 = merge_cnae.SBCLAS20;

update RAIS_2005_STEP2 set CNAE20 = right(CNAE20,7);

alter table RAIS_2005_STEP2 drop CLAS_CNAE_95;

drop table merge_cnae;

update RAIS_2005_STEP2 set CNAE20 = if(CNAE20='8592999','8599699',CNAE20);

/* *** Recodificando a variável ESCOLARIDADE *** */

create table escolaridade(
  FONTE int(1),
  ESCOLARIDADE int(1)
);

select * from escolaridade;

insert into escolaridade values(1,1),(2,2),(3,2),(4,2),(5,3),(6,4),(7,5),(8,6),(9,7),(-1,-1);

alter table RAIS_2005_STEP2 add ESCOLARIDADE int(1);

update RAIS_2005_STEP2 left join escolaridade 
on RAIS_2005_STEP2.GRAU_INSTR_FONTE = escolaridade.FONTE
set RAIS_2005_STEP2.ESCOLARIDADE = escolaridade.ESCOLARIDADE;

alter table RAIS_2005_STEP2 drop GRAU_INSTR_FONTE;

drop table if exists escolaridade;

/* Renomeando a variável Simples */

alter table RAIS_2005_STEP2 change IND_SIMPLES_FONTE SIMPLES VARCHAR(1);

/* *** Recodificando a variável TAMANHO DO ESTABELECIMENTO *** */

create table tamestab(
  FONTE int(1),
  TAM_ESTAB int(1)
);

insert into tamestab values(0,0),(1,1),(2,1),(3,1),(4,2),(5,2),(6,3),(7,3),(8,4),(9,4),(-1,-1);

alter table RAIS_2005_STEP2 add TAM_ESTAB int(1);

update RAIS_2005_STEP2 left join tamestab 
on RAIS_2005_STEP2.TAM_ESTAB_FONTE = tamestab.FONTE
set RAIS_2005_STEP2.TAM_ESTAB = tamestab.TAM_ESTAB;

alter table RAIS_2005_STEP2 drop TAM_ESTAB_FONTE;

drop table if exists tamestab;



/* *** Recodificando a variável NATUREZA JURIDICA *** */

create table natjur(
  FONTE int(4),
  DESCRICAO varchar(200),
  NATUR_JUR int(1)
);

load data local infile 'Z:/Correspondencias_Classificacoes/Natureza_Juridica/Merge_Natureza_Juridica.txt'
into table natjur
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table RAIS_2005_STEP2 add NATUR_JUR int(1);

update RAIS_2005_STEP2 left join natjur 
on RAIS_2005_STEP2.NATUR_JUR_FONTE = natjur.FONTE
set RAIS_2005_STEP2.NATUR_JUR = natjur.NATUR_JUR;

alter table RAIS_2005_STEP2 drop NATUR_JUR_FONTE;

drop table if exists natjur;

/* *** Transformando a variável REMUNERACAO em variável numérica *** */

update RAIS_2005_STEP2 set REM_DEZ_RS = replace(REM_DEZ_RS,',','.');

alter table RAIS_2005_STEP2 change REM_DEZ_RS REMUNERACAO double(14,2);

-- STEP 3: Transformação e Padronização das variáveis selecionadas no STEP 2:

create table RAIS_2005_STEP3 select * from RAIS_2005_STEP2;




