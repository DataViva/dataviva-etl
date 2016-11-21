-- select MATRICULA SC 2007

use dataviva_raw;

-- Selecionando as variaveis
drop table if exists SC_2012_MATRICULA_STEP1;
create table SC_2012_MATRICULA_STEP1 
select ANO_CENSO, PK_COD_MATRICULA, FK_COD_ALUNO, NUM_IDADE, TP_SEXO, TP_COR_RACA, FK_COD_MUNICIPIO_END, PK_COD_TURMA, 
PK_COD_ENTIDADE, COD_MUNICIPIO_ESCOLA, ID_DEPENDENCIA_ADM_ESC, FK_COD_CURSO_PROF, FK_COD_ETAPA_ENSINO
from SC_2012_MATRICULA
where FK_COD_TIPO_TURMA != '     4';

-- Criando o step2:
drop table if exists SC_2012_MATRICULA_STEP2;
create table SC_2012_MATRICULA_STEP2 select * from SC_2012_MATRICULA_STEP1;

-- Codigo da matricula PK_COD_MATRICULA
alter table SC_2012_MATRICULA_STEP2 change PK_COD_MATRICULA COD_MATRICULA int(16);

-- Codigo do aluno FK_COD_ALUNO
alter table SC_2012_MATRICULA_STEP2 change FK_COD_ALUNO COD_ALUNO varchar(16);

-- Idade do aluno: NUM_IDADE
alter table SC_2012_MATRICULA_STEP2 change NUM_IDADE IDADE int(3);

-- Sexo do aluno: TP_SEXO
alter table SC_2012_MATRICULA_STEP2 change TP_SEXO SEXO varchar(1);
update SC_2012_MATRICULA_STEP2 set SEXO = if(SEXO = 'F', 0, 1);

-- COR do aluno: TP_COR_RACA
alter table SC_2012_MATRICULA_STEP2 add COR_RACA varchar(2);

create table etnia(FONTE varchar(1), COR_RACA int(1));
insert into etnia values(0,-1),(1,2),(2,4),(3,8),(4,6),(5,1);

update SC_2012_MATRICULA_STEP2 left join etnia 
on SC_2012_MATRICULA_STEP2.TP_COR_RACA = etnia.FONTE
set SC_2012_MATRICULA_STEP2.COR_RACA = etnia.COR_RACA;

drop table etnia;

alter table SC_2012_MATRICULA_STEP2 drop TP_COR_RACA;

-- Municipio de endereço do aluno: FK_COD_MUNICIPIO_END
alter table SC_2012_MATRICULA_STEP2 change FK_COD_MUNICIPIO_END MUNICIPIO_END varchar(20);

update SC_2012_MATRICULA_STEP2 set MUNICIPIO_END = left(right(MUNICIPIO_END,7),6);
update SC_2012_MATRICULA_STEP2 set MUNICIPIO_END = if(MUNICIPIO_END='',null,MUNICIPIO_END);

-- Codigo da turma do aluno: PK_COD_TURMA
alter table SC_2012_MATRICULA_STEP2 change PK_COD_TURMA COD_TURMA varchar(14);

-- Codigo da Entidade: PK_COD_ENTIDADE
alter table SC_2012_MATRICULA_STEP2 change PK_COD_ENTIDADE COD_ENTIDADE varchar(12);

-- Municipio da Escola: FK_COD_MUNICIPIO
alter table SC_2012_MATRICULA_STEP2 change COD_MUNICIPIO_ESCOLA COD_MUNICIPIO varchar(20);

update SC_2012_MATRICULA_STEP2 set COD_MUNICIPIO = left(right(COD_MUNICIPIO,7),6);

-- Depeendencia administrativa da escola: ID_DEPENDENCIA_ADM_ESC
alter table SC_2012_MATRICULA_STEP2 change ID_DEPENDENCIA_ADM_ESC DEPENDENCIA_ADM varchar(1);

-- Ano do Censo Escolar: ANO_CENSO

alter table SC_2012_MATRICULA_STEP2 change ANO_CENSO ANO varchar(8);

-- Codigo do curso profissionalizante: FK_COD_CURSO_PROF
alter table SC_2012_MATRICULA_STEP2 change FK_COD_CURSO_PROF COD_CURSO_PROF int(10);
update SC_2012_MATRICULA_STEP2 set COD_CURSO_PROF = if(COD_CURSO_PROF=0,NULL,COD_CURSO_PROF);

-- Etapa de Ensino: FK_COD_ETAPA_ENSINO
alter table SC_2012_MATRICULA_STEP2 change FK_COD_ETAPA_ENSINO COD_ETAPA_ENSINO_A int(10);

create table etapa_ensino(FONTE int(10), COD_ETAPA_ENSINO int(10));
load data local infile 'Y:/Correspondencia_Classificacoes/codigo_etapa_ensino.txt'
into table etapa_ensino
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table SC_2012_MATRICULA_STEP2 add COD_ETAPA_ENSINO int(10);

update SC_2012_MATRICULA_STEP2 left join etapa_ensino 
on SC_2012_MATRICULA_STEP2.COD_ETAPA_ENSINO_A = etapa_ensino.FONTE
set SC_2012_MATRICULA_STEP2.COD_ETAPA_ENSINO = etapa_ensino.COD_ETAPA_ENSINO;

drop table etapa_ensino;

alter table SC_2012_MATRICULA_STEP2 drop COD_ETAPA_ENSINO_A;


update SC_2012_MATRICULA_STEP2 set MUNICIPIO_END = if(MUNICIPIO_END='',null,MUNICIPIO_END);
update SC_2012_MATRICULA_STEP2 set COD_CURSO_PROF = if(COD_CURSO_PROF=0,NULL,COD_CURSO_PROF);

-- Retirando EJA e Educação Infantil
drop table if exists SC_2012_MATRICULA_STEP3;
create table SC_2012_MATRICULA_STEP3 
select * from SC_2012_MATRICULA_STEP2 
where COD_ETAPA_ENSINO not in (1,7);



-- Conferindo
select * from SC_2012_MATRICULA_STEP3;

select ANO,count(*) from SC_2012_MATRICULA_STEP3 group by ANO;
select IDADE,count(*) from SC_2012_MATRICULA_STEP3 group by IDADE;
select SEXO,count(*) from SC_2012_MATRICULA_STEP3 group by SEXO;
select MUNICIPIO_END,count(*) from SC_2012_MATRICULA_STEP3 group by MUNICIPIO_END;
select COD_TURMA,count(*) from SC_2012_MATRICULA_STEP3 group by COD_TURMA;
select COD_ENTIDADE,count(*) from SC_2012_MATRICULA_STEP3 group by COD_ENTIDADE;
select COD_MUNICIPIO,count(*) from SC_2012_MATRICULA_STEP3 group by COD_MUNICIPIO;
select DEPENDENCIA_ADM,count(*) from SC_2012_MATRICULA_STEP3 group by DEPENDENCIA_ADM;
select COR_RACA,count(*) from SC_2012_MATRICULA_STEP3 group by COR_RACA;
select COD_CURSO_PROF,count(*) from SC_2012_MATRICULA_STEP3 group by COD_CURSO_PROF;
select COD_ETAPA_ENSINO,count(*) from SC_2012_MATRICULA_STEP3 group by COD_ETAPA_ENSINO;




