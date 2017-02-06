#SELECT PROFISSIONAIS

-- Select PROF_2015	

use cnes_profissionais;

-- STEP 1: Criando a tabela com as variávies selecionadas:


create table PROF_2015_STEP1
select cnes, codufmun, regsaude, pf_pj, cpf_cnpj, niv_dep, cnpj_man, esfera_a, retencao, tp_unid, niv_hier, cbo, cbounico,
cns_prof, vinculac, vincul_c, vincul_a, vincul_n, prof_sus, profnsus, horaoutr, horahosp, hora_amb, competen, ufmunres
from PROF_2015;

-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

create table PROF_2015_STEP2 select * from PROF_2015_STEP1;

/* Renomeando a variável MUNICIPIO */

alter table PROF_2015_STEP2 change codufmun codmun VARCHAR(6);

/*Aletrando codigos dos municipios satelites de Brasilia */ #conferir se as cidades foram substituidas

update PROF_2015_STEP2 set codmun = 
if(codmun in('530020','530030', '530040' ,'530050', '530060' , '530070',
			'530080', '530090' , '530100' , '530110', '530120' , '530130',
			'530135' , '530140' , '530150' , '530160' ,'530170' ,'530180'),
            '530010',codmun);

/* Eliminar a variavel regsaude */

alter table PROF_2015_STEP2 drop regsaude; 

/* adicionar o regsaude */


create table regsaude(
	cod_regsaude varchar(5),
    municipio varchar(6)
);

load data local infile 'Y:/Correspondencia_Classificacoes/regsaude.csv'
into table regsaude
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;


alter table PROF_2015_STEP2 add regsaude varchar(5);

update PROF_2015_STEP2 left join regsaude 
on PROF_2015_STEP2.codmun = regsaude.municipio
set PROF_2015_STEP2.regsaude = regsaude.cod_regsaude;

/* Niv_dep substituir 5 por um 1 nos anos 2008 e 2009 */

create table niv_dep1(
    fonte varchar(1),
    niv_dep1 varchar(1)
);

insert into niv_dep1 values('1','1'),('5','1'),('3','3');

alter table PROF_2015_STEP2 add niv_dep1 varchar(2);

update PROF_2015_STEP2 left join niv_dep1 
on PROF_2015_STEP2.niv_dep = niv_dep1.fonte
set PROF_2015_STEP2.niv_dep1 = niv_dep1.niv_dep1;

alter table PROF_2015_STEP2 drop niv_dep;

/* Recodificando a variavel esfera_a */ 

create table esfera(
    esfera_a varchar(2),
    esfera varchar(2)
);

insert into esfera values('01','01'),('02','02'),('03','03'),('04','04'),(' ','99'),('  ','99');

alter table PROF_2015_STEP2 add esfera varchar(2);

update PROF_2015_STEP2 left join esfera 
on PROF_2015_STEP2.esfera_a = esfera.esfera_a
set PROF_2015_STEP2.esfera = esfera.esfera;

alter table PROF_2015_STEP2 drop esfera_a;

/* Recodificando a variavel retenção */ 

create table retencao (
    fonte varchar(2),
    retencao varchar(2)
);

insert into retencao values ('10','10'),('11','11'),('12','12'),('13','13'),('14','14'),('15','15'),('16','16'),(' ','99'); 

alter table PROF_2015_STEP2 add retencao_2 varchar (2);

update PROF_2015_STEP2 left join retencao 
on PROF_2015_STEP2.retencao = retencao.fonte
set PROF_2015_STEP2.retencao_2 = retencao.retencao;

select * from  PROF_2015_STEP2 left join retencao 
on PROF_2015_STEP2.retencao = retencao.fonte;

alter table PROF_2015_STEP2 drop retencao;

/* Recodificando a variavel niv_hier */

create table niv_hier (
    fonte varchar(2),
    niv_hier varchar(2)
);

insert into niv_hier values ('01','01'),('02','02'),('03','03'),('04','04'),('05','05'),('06','06'),('07','07'),('08','08'), ('09','09'), ('  ','99'), (' ','99');

alter table PROF_2015_STEP2 add niv_hier_2 varchar (2);

update PROF_2015_STEP2 left join niv_hier 
on PROF_2015_STEP2.niv_hier = niv_hier.fonte
set PROF_2015_STEP2.niv_hier_2 = niv_hier.niv_hier;


select * from  PROF_2015_STEP2 left join niv_hier  
on PROF_2015_STEP2.niv_hier = niv_hier .fonte;

alter table PROF_2015_STEP2 drop niv_hier;


/* Alterando cbo's */
update PROF_2015_STEP2 set cbo = 
if(cbo='1999A1','142710',if(cbo='1999A2','142710',if(cbo='221555','221205',if(cbo='2335225','233225',cbo))));

/* Selecionar somente os 4 primeiros di*/

select left(cbo, 4) from  PROF_2015_STEP2;

update PROF_2015_STEP2 set cbo = left(cbo, 4);

/* Apagar o cbounico*/

alter table PROF_2015_STEP2 drop cbounico;

/* Apagar o vincul_c*/

alter table PROF_2015_STEP2 drop vincul_c;

/* Apagar o vincul_a*/

alter table PROF_2015_STEP2 drop vincul_a;

/* Apagar o vincul_n*/

alter table PROF_2015_STEP2 drop vincul_n;

/* Apagar o profnsus*/

alter table PROF_2015_STEP2 drop profnsus;

-- Criando tabela final - STEP3: 

create table PROF_2015_STEP3 select * from PROF_2015_STEP2;   