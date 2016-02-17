-- Criando a tabela transformada:

drop table if exists RAIS2003_Selecao;
create table RAIS2003_Selecao SELECT PIS, IDENTIFICAD, MUNICIPIO_FONTE, SEXO_FONTE, IDADE, RACA_COR_FONTE, GRAU_INSTR_FONTE,
		REM_MEDIA_RS, CBO_2002_FONTE, CLAS_CNAE_95_FONTE, TAM_ESTAB_FONTE, IND_SIMPLES_FONTE, NATUR_JUR_FONTE
        FROM RAIS_2003 WHERE EMP_31_12_FONTE='1' limit 0,2000000;

/* Renomeando a variável MUNICIPIO */
alter table RAIS2003_Selecao change MUNICIPIO_FONTE MUNICIPIO VARCHAR(6);

/* Recodificando a variável SEXO */

drop table if exists genero;

create table genero(
  FONTE int(1),
  SEXO int(1)
);

insert into genero values(1,1),(2,0);

create table RAIS2003T select `RAIS2003_Selecao`.*, `genero`.`SEXO` FROM `RAIS2003_Selecao`
inner join `genero` ON `RAIS2003_Selecao`.`SEXO_FONTE` = `genero`.`FONTE`;

alter table RAIS2003T drop SEXO_FONTE;

drop table if exists RAIS2003_Selecao;

/* Recodificando a variável ETNIA */

drop table if exists etnia;

create table etnia(
  FONTE int(1),
  ETNIA int(1)
);

insert into etnia values(1,1),(2,2),(4,4),(6,6),(8,8),(9,-1);

create table RAIS2003_Selecao select `RAIS2003T`.*, `etnia`.`ETNIA` FROM `RAIS2003T`
inner join `etnia` ON `RAIS2003T`.`RACA_COR_FONTE` = `etnia`.`FONTE`;

alter table RAIS2003_Selecao drop RACA_COR_FONTE;

drop table if exists RAIS2003T;

drop table if exists etnia;


/* Renomeando a variável CBO2002 */

alter table RAIS2003_Selecao change CBO_2002_FONTE CBO2002 VARCHAR(6);

/* Renomeando a variável CNAE1995 */

alter table RAIS2003_Selecao change CLAS_CNAE_95_FONTE CNAE1995 VARCHAR(5);


/* *** Recodificando a variável ESCOLARIDADE *** */

drop table if exists escolaridade;

create table escolaridade(
  FONTE int(1),
  ESCOLARIDADE int(1)
);

insert into escolaridade values(1,1),(2,2),(3,2),(4,2),(5,3),(6,4),(7,5),(8,6),(9,7),(-1,-1);

create table RAIS2003T select `RAIS2003_Selecao`.*, `escolaridade`.`ESCOLARIDADE` FROM `RAIS2003_Selecao`
inner join `escolaridade` ON `RAIS2003_Selecao`.`GRAU_INSTR_FONTE` = `escolaridade`.`FONTE`;

alter table RAIS2003T drop GRAU_INSTR_FONTE;

drop table if exists RAIS2003_Selecao;

drop table if exists escolaridade;

/* Renomeando a variável CNAE1995 */

alter table RAIS2003T change IND_SIMPLES_FONTE SIMPLES VARCHAR(1);


/* *** Recodificando a variável TAMANHO DO ESTABELECIMENTO *** */

drop table if exists tamestab;

create table tamestab(
  FONTE int(1),
  TAM_ESTAB int(1)
);

insert into tamestab values(0,0),(1,1),(2,1),(3,1),(4,2),(5,2),(6,3),(7,3),(8,4),(9,4),(-1,-1);

create table RAIS2003_Selecao select `RAIS2003T`.*, `tamestab`.`TAM_ESTAB` FROM `RAIS2003T`
inner join `tamestab` ON `RAIS2003T`.`TAM_ESTAB_FONTE` = `tamestab`.`FONTE`;

alter table RAIS2003_Selecao drop TAM_ESTAB_FONTE;

drop table if exists RAIS2003T;

drop table if exists tamestab;


/* *** Recodificando a variável NATUREZA JURIDICA *** */

drop table if exists natjur;

create table natjur(
  FONTE int(4),
  DESCRICAO varchar(200),
  NATUR_JUR int(1)
);

load data local infile 'H:/Correspondencias_Classificacoes/Natureza_Juridica/Merge_Natureza_Juridica.txt'
into table natjur
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

create table RAIS2003T select `RAIS2003_Selecao`.*, `natjur`.`NATUR_JUR` FROM `RAIS2003_Selecao`
inner join `natjur` ON `RAIS2003_Selecao`.`NATUR_JUR_FONTE` = `natjur`.`FONTE`;

alter table RAIS2003T drop NATUR_JUR_FONTE;

drop table if exists RAIS2003_Selecao;

drop table if exists natjur;


/* *** Transformando a variável REMUNERACAO em variável numérica *** */

UPDATE RAIS2003T set REM_MEDIA_RS = replace(REM_MEDIA_RS,',','.');


select sum(REM_MEDIA_RS) from RAIS2003T;

alter table RAIS2003T change REM_MEDIA_RS REMUNERACAO double(14,2);

