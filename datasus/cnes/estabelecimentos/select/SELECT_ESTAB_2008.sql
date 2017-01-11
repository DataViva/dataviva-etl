-- Select estab_2008	

use cnes_estabelecimentos;

-- STEP 1: Criando a tabela com as variávies selecionadas:

create table ESTAB_2008_STEP1
select cnes, codufmun, cod_cep, cpf_cnpj, pf_pj, niv_dep, cnpj_man, regsaude, vinc_sus, esfera_a, retencao, tp_unid, niv_hier, tp_prest, nivate_a, 
nivate_h, qtleitp1, qtleitp2, qtleitp3, qtinst01, qtinst02, qtinst03, qtinst04, qtinst05, qtinst06, qtinst07, qtinst08, qtinst09, qtinst10, qtinst11, 
qtinst12, qtinst13, qtinst14, urgemerg, qtinst15, qtinst16, qtinst17, qtinst18, qtinst19, qtinst20, qtinst21, qtinst22, qtinst23, qtinst24, qtinst25, 
qtinst26, qtinst27, qtinst28, qtinst29, qtinst30, atendamb, qtinst31, qtinst32, qtinst33, centrcir, qtinst34, qtinst35, qtinst36, qtinst37, centrobs, 
qtleit05, qtleit06, qtleit07, qtleit08, qtleit09, qtleit19, qtleit20, qtleit21, qtleit22, qtleit23, qtleit32, qtleit34, qtleit38, qtleit39, qtleit40, 
centrneo, atendhos, coletres, ap01cv01, ap01cv02, ap01cv05, ap01cv06, ap02cv01, ap02cv02, ap02cv05, ap02cv06, ap03cv01, ap03cv02, ap03cv05, ap03cv06, 
ap04cv01, ap04cv02, ap04cv05, ap04cv06, competen
from estab_2008;


-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

create table ESTAB_2008_STEP2 select * from ESTAB_2008_STEP1;

/* Renomeando a variável MUNICIPIO */

alter table ESTAB_2008_STEP2 change codufmun codmun VARCHAR(6);

/*Alterando codigos dos municipios satelites de Brasilia */ #conferir se as cidades foram substituidas

update ESTAB_2008_STEP2 set codmun = 
if(codmun in('530020','530030','530040','530050','530060','530070',
			'530080','530090','530100','530110','530120','530130',
			'530135','530140','530150','530160','530170','530180'),
            '530010',codmun);

/* Niv_dep substituir 5 por um 1 nos anos 2008 e 2009 */

create table niv_dep1(
    niv_dep varchar(1),
    niv_dep1 varchar(1)
);

insert into esfera values('1','1'),('5','1'),('3','3');

alter table ESTAB_2008_STEP2 add esfera niv_dep1 varchar (1);

update ESTAB_2008_STEP2 left join niv_dep 
on ESTAB_2008_STEP2.niv_dep = niv_dep1.niv_dep
set ESTAB_2008_STEP2.niv_dep1 = niv_dep1.niv_dep1;

alter table EESTAB_2008_STEP2 drop niv_dep;

/* Eliminar a variavel regsaude */

alter table ESTAB_2008_STEP2 drop regsaude; 

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

alter table ESTAB_2008_STEP2 add regsaude varchar(5);

update ESTAB_2008_STEP2 left join regsaude 
on ESTAB_2008_STEP2.codmun = regsaude.municipio
set ESTAB_2008_STEP2.regsaude = regsaude.cod_regsaude;

/* Recodificando a variavel esfera_a */ 

drop table esfera;
create table esfera(
    esfera_a varchar(2),
    esfera varchar(2)
);

insert into esfera values('01','01'),('02','02'),('03','03'),('04','04'),(' ','99'),('  ','99');

alter table ESTAB_2008_STEP2 add esfera varchar(2);

update ESTAB_2008_STEP2 left join esfera 
on ESTAB_2008_STEP2.esfera_a = esfera.esfera_a
set ESTAB_2008_STEP2.esfera = esfera.esfera;

alter table ESTAB_2008_STEP2 drop esfera_a;

/* Recodificando a variavel retenção */ 

create table retencao (
    fonte varchar(2),
    retencao varchar(2)
);

insert into retencao values ('10','10'),('11','11'),('12','12'),('13','13'),('14','14'),('15','15'),('16','16'),(' ','99'); 

alter table ESTAB_2008_STEP2 add retencao_2 varchar (2);

update ESTAB_2008_STEP2 left join retencao 
on ESTAB_2008_STEP2.retencao = retencao.fonte
set ESTAB_2008_STEP2.retencao_2 = retencao.retencao;


select * from  ESTAB_2008_STEP2 left join retencao 
on ESTAB_2008_STEP2.retencao = retencao.fonte;

alter table ESTAB_2008_STEP2 drop retencao;

/* Recodificando a variavel niv_hier */

create table niv_hier (
    fonte varchar(2),
    niv_hier varchar(2)
);

insert into niv_hier values ('01','01'),('02','02'),('03','03'),('04','04'),('05','05'),('06','06'),('07','07'),('08','08'), ('09','09'), ('  ','99'), (' ','99');

alter table ESTAB_2008_STEP2 add niv_hier_2 varchar (2);

update ESTAB_2008_STEP2 left join niv_hier 
on ESTAB_2008_STEP2.niv_hier = niv_hier.fonte
set ESTAB_2008_STEP2.niv_hier_2 = niv_hier.niv_hier;


select * from  ESTAB_2008_STEP2 left join niv_hier  
on ESTAB_2008_STEP2.niv_hier = niv_hier .fonte;

alter table ESTAB_2008_STEP2 drop niv_hier;

/* nivate_a e nivate_h - concatenar */

select concat( nivate_a, '  ',  nivate_h)


/* renomear qinst01 p/ sala pediatrica */

alter table ESTAB_2008_STEP2 change qinst01 qt_sala_pedi int(3);


/* agrupar qinst02, qinst03, qinst04 e renomear para sala adulto */

select SUM(qinst02 , qinst03 , qinst04)
from shop
group by dealer


select * from ESTAB_2008_STEP2;

CREATE TABLE ESTAB_2008_STEP2 AS
SELECT *, (qtinst02 + qtinst03 + qtinst04) AS qt_sala_atend_adulto, 
(qtinst06 + qtinst07 + qtinst08) AS nova2
FROM ESTAB_2008_STEP1;

drop table ESTAB_2008_STEP2;
