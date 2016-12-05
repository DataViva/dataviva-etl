-- Select EQUI_2011

use cnes_equi;

-- STEP 1: Criando a tabela com as variávies selecionadas:

create table EQUI_2011_STEP1
select  cnes, codufmun, regsaude, micr_reg, pf_pj, cpf_cnpj, niv_dep, cnpj_man, esfera_a, retencao, tp_unid, niv_hier, tipequip, codequip, qt_exist, qt_uso, ind_sus, ind_nsus, competen  
from equi_2011;

-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

create table EQUI_2011_STEP2 select * from EQUI_2011_STEP1;

/* Renomeando a variável MUNICIPIO */

alter table EQUI_2011_STEP2 change codufmun codmun VARCHAR(6);

/*Aletrando codigos dos municipios satelites de Brasilia */ #conferir se as cidades foram substituidas

update EQUI_2011_STEP2 set codmun = 
if(codmun in('530020','530030', '530040' ,'530050', '530060' , '530070',
			'530080', '530090' , '530100' , '530110', '530120' , '530130',
			'530135' , '530140' , '530150' , '530160' ,'530170' ,'530180'),
            '530010',codmun);

/* Eliminar a variavel regsaude */

alter table EQUI_2011_STEP2 drop regsaude; 

/* adicionar o regsaude */

drop table regsaude;
create table regsaude(
	cod_regsaude varchar(5),
    municipio varchar(6)
);

load data local infile 'Y:/Correspondencia_Classificacoes/regsaude.csv'
into table regsaude
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;


alter table EQUI_2011_STEP2 add regsaude varchar(5);

update EQUI_2011_STEP2 left join regsaude 
on EQUI_2011_STEP2.codmun = regsaude.municipio
set EQUI_2011_STEP2.regsaude = regsaude.cod_regsaude;

/* Eliminar a variavel micr_reg */

alter table EQUI_2011_STEP2 drop micr_reg;

/* Recodificando a variavel esfera_a */ 

drop table esfera;
create table esfera(
    esfera_a varchar(2),
    esfera varchar(2)
);

insert into esfera values('01','01'),('02','02'),('03','03'),('04','04'),(' ','99'),('  ','99');

alter table EQUI_2011_STEP2 add esfera varchar(2);

update EQUI_2011_STEP2 left join esfera 
on EQUI_2011_STEP2.esfera_a = esfera.esfera_a
set EQUI_2011_STEP2.esfera = esfera.esfera;

/* Recodificando a variavel retenção */ 

drop table retencao;
create table retencao (
    fonte varchar(2),
    retencao varchar(2)
);

insert into retencao values ('10','10'),('11','11'),('12','12'),('13','13'),('14','14'),('15','15'),('16','16'),(' ','99'); 

alter table EQUI_2011_STEP2 add retencao_2 varchar (2);

update EQUI_2011_STEP2 left join retencao 
on EQUI_2011_STEP2.retencao = retencao.fonte
set EQUI_2011_STEP2.retencao_2 = retencao.retencao;


select * from  EQUI_2011_STEP2 left join retencao 
on EQUI_2011_STEP2.retencao = retencao.fonte;


/* ind_sus e ins_nsus na mesma variável */ 

alter table EQUI_2011_STEP2 drop ind_nsus;           
       
-- STEP 3: Tabela Final

create table EQUI_2011_STEP3 select * from EQUI_2011_STEP2;            