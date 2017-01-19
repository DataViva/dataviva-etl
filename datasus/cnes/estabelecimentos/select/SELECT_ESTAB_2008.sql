-- Select estab_2008	

use cnes_estabelecimentos;

-- STEP 1: Criando a tabela com as variávies selecionadas:

create table ESTAB_2008_STEP1
select cnes, codufmun, cod_cep, cpf_cnpj, pf_pj, niv_dep, cnpj_man, regsaude, vinc_sus, esfera_a, retencao, tp_unid, niv_hier, tp_prest, nivate_a,
gesprg1e, gesprg1m, gesprg2e, gesprg2m, gesprg4e, gesprg4m, gesprg3e, gesprg3m, gesprg5e, gesprg5m, gesprg6e, gesprg6m, nivate_h, qtleitp1, qtleitp2, 
qtleitp3, qtinst01, qtinst02, qtinst03, qtinst04, qtinst05, qtinst06, qtinst07, qtinst08, qtinst09, qtinst10, qtinst11, qtinst12, qtinst13, qtinst14, 
urgemerg, qtinst15, qtinst16, qtinst17, qtinst18, qtinst19, qtinst20, qtinst21, qtinst22, qtinst23, qtinst24, qtinst25, qtinst26, qtinst27, qtinst28, 
qtinst29, qtinst30, atendamb, qtinst31, qtinst32, qtinst33, centrcir, qtinst34, qtinst35, qtinst36, qtinst37, centrobs, qtleit05, qtleit06, qtleit07, 
qtleit08, qtleit09, qtleit19, qtleit20, qtleit21, qtleit22, qtleit23, qtleit32, qtleit34, qtleit38, qtleit39, qtleit40, centrneo, atendhos, coletres, 
ap01cv01, ap01cv02, ap01cv05, ap01cv06, ap02cv01, ap02cv02, ap02cv05, ap02cv06, ap03cv01, ap03cv02, ap03cv05, ap03cv06, ap04cv01, ap04cv02, ap04cv05, 
ap04cv06, competen
from estab_2008;


-- STEP 2: Transformação e Padronização das variáveis selecionadas no STEP 1:

CREATE TABLE ESTAB_2008_STEP2 AS
SELECT *, (qtinst02 + qtinst03 + qtinst04) AS qt_sala_atend_adulto_ue, 
(qtinst06 + qtinst07 + qtinst08) AS qt_sala_obs_adulto_ue,
(qtinst19 + qtinst20 + qtinst22) AS qt_sala_rep_amb,
(qtleit06 + qtleit07 + qtleit08) AS qt_leito_rep_ue,
(qtleit19 + qtleit20 + qtleit22) AS qt_leito_rep_amb,
(qtleit38 + qtleit39 + qtleit40) AS qt_leito_rn_nn,
concat(gesprg1e, gesprg1m) AS atencaobasica_amb,
concat(gesprg2e, gesprg2m) AS mediacomplexidade_amb,
concat(gesprg4e, gesprg4m) AS altacomplexidade_amb,
concat(gesprg3e, gesprg3m) AS internacao_hosp,
concat(gesprg5e, gesprg5m) AS mediacomplexidade_hosp,
concat(gesprg6e, gesprg6m) AS altacomplexidade_hosp,
concat(ap01cv01, ap01cv02, ap01cv05, ap01cv06) as tipointernacao,
concat(ap02cv01, ap02cv02, ap02cv05, ap02cv06) as tipodeambulatorio,
concat(ap03cv01, ap03cv02, ap03cv05, ap03cv06) as tipodesadt,
concat(ap04cv01, ap04cv02, ap04cv05, ap04cv06) as tipodeurgencia 
FROM ESTAB_2008_STEP1;

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
    fonte varchar(1),
    niv_dep1 varchar(1)
);

insert into niv_dep1 values('1','1'),('5','1'),('3','3');

alter table ESTAB_2008_STEP2 add niv_dep1 varchar(2);

update ESTAB_2008_STEP2 left join niv_dep1 
on ESTAB_2008_STEP2.niv_dep = niv_dep1.fonte
set ESTAB_2008_STEP2.niv_dep1 = niv_dep1.niv_dep1;

alter table ESTAB_2008_STEP2 drop niv_dep;

/* Eliminar a variavel regsaude */

alter table ESTAB_2008_STEP2 drop regsaude; 

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

alter table ESTAB_2008_STEP2 add regsaude varchar(5);

update ESTAB_2008_STEP2 left join regsaude 
on ESTAB_2008_STEP2.codmun = regsaude.municipio
set ESTAB_2008_STEP2.regsaude = regsaude.cod_regsaude;


/* Recodificando a variavel esfera_a */ 

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


/* renomear qtleitp1 p/ qt_leito_hosp_cirurg */

alter table ESTAB_2008_STEP2 change qtleitp1 qt_leito_hosp_cirurg int(4);

/* renomear qtleitp2 p/ qt_leito_hosp_clin */

alter table ESTAB_2008_STEP2 change qtleitp2 qt_leito_hosp_clin int(4);

/* renomear qtleitp3 p/ qt_leito_hosp_complex */

alter table ESTAB_2008_STEP2 change qtleitp3 qt_leito_hosp_complex int(4);

/* renomear qtinst01 p/ qt_sala_pedi_ue */

alter table ESTAB_2008_STEP2 change qtinst01 qt_sala_pedi_ue int(4);

/*apagar qtinst02, qtinst03, qtinst04 */

alter table ESTAB_2008_STEP2 drop qtinst02;
alter table ESTAB_2008_STEP2 drop qtinst03;
alter table ESTAB_2008_STEP2 drop qtinst04;

/* renomear qtinst05 p/ qt_sala_rep_pedi_ue */

alter table ESTAB_2008_STEP2 change qtinst05 qt_sala_rep_pedi_ue int(4);

/*apagar qtinst02, qtinst03, qtinst04 */

alter table ESTAB_2008_STEP2 drop qtinst06;
alter table ESTAB_2008_STEP2 drop qtinst07;
alter table ESTAB_2008_STEP2 drop qtinst08;

/* renomear qtinst09 p/ qt_cons_odonto_ue */

alter table ESTAB_2008_STEP2 change qtinst09 qt_cons_odonto_ue int(4);

/* renomear qtinst10 p/ qt_cons_higie_ue */

alter table ESTAB_2008_STEP2 change qtinst10 qt_sala_higie_ue int(4);

/* renomear qtinst11 p/ qt_sala_gesso_ue */

alter table ESTAB_2008_STEP2 change qtinst11 qt_sala_gesso_ue int(4);

/* renomear qtinst12 p/ qt_sala_curativo_ue */

alter table ESTAB_2008_STEP2 change qtinst12 qt_sala_curativo_ue int(4);

/* renomear qtinst13 p/ qt_sala_peqcirur_ue */

alter table ESTAB_2008_STEP2 change qtinst13 qt_sala_peqcirur_ue int(4);

/* renomear qtinst14 p/ qt_sala_consu_med_ue */

alter table ESTAB_2008_STEP2 change qtinst14 qt_sala_cons_med_ue int(4);

/* renomear qtinst15 p/ qt_cons_clincbasica_amb */

alter table ESTAB_2008_STEP2 change qtinst15 qt_cons_clincbasica_amb int(4);

/* renomear qtinst16 p/ qt_cons_clincesp_amb */

alter table ESTAB_2008_STEP2 change qtinst16 qt_cons_clincesp_amb int(4);

/* renomear qtinst17 p/ qt_cons_clincind_amb */

alter table ESTAB_2008_STEP2 change qtinst17 qt_cons_clincind_amb int(4);

/* renomear qtinst18 p/ qt_cons_nmed_amb */

alter table ESTAB_2008_STEP2 change qtinst18 qt_cons_nmed_amb int(4);

/*apagar qtinst19, qtinst20, qtinst22 */

alter table ESTAB_2008_STEP2 drop qtinst19;
alter table ESTAB_2008_STEP2 drop qtinst20;
alter table ESTAB_2008_STEP2 drop qtinst22;

/* renomear qtinst21 p/ qt_sala_rep_ped_amb */

alter table ESTAB_2008_STEP2 change qtinst21 qt_sala_rep_ped_amb int(4);

/* renomear qtinst23 p/ qt_cons_odonto_amb */

alter table ESTAB_2008_STEP2 change qtinst23 qt_cons_odonto_amb int(4);

/* renomear qtinst24 p/ qt_sala_peqcirur_amb */

alter table ESTAB_2008_STEP2 change qtinst24 qt_sala_peqcirur_amb int(4);

/* renomear qtinst25 p/ qt_sala_enf_amb */

alter table ESTAB_2008_STEP2 change qtinst25 qt_sala_enf_amb int(4);

/* renomear qtinst26 p/ qt_sala_imun_amb */

alter table ESTAB_2008_STEP2 change qtinst26 qt_sala_imun_amb int(4);

/* renomear qtinst27 p/ qt_sala_nebu_amb */

alter table ESTAB_2008_STEP2 change qtinst27 qt_sala_nebu_amb int(4);

/* renomear qtinst28 p/ qt_sala_gesso_amb */

alter table ESTAB_2008_STEP2 change qtinst28 qt_sala_gesso_amb int(4);

/* renomear qtinst29 p/ qt_sala_cura_amb */

alter table ESTAB_2008_STEP2 change qtinst29 qt_sala_cura_amb int(4);

/* renomear qtinst30 p/ qt_sala_ciruramb_amb */

alter table ESTAB_2008_STEP2 change qtinst30 qt_sala_ciruramb_amb int(4);

/* renomear qtinst31 p/ qt_sala_cirur_cc */

alter table ESTAB_2008_STEP2 change qtinst31 qt_sala_cirur_cc int(4);

/* renomear qtinst32 p/ qt_sala_recup_cc */

alter table ESTAB_2008_STEP2 change qtinst32 qt_sala_recup_cc int(4);

/* renomear qtinst33 p/ qt_sala_ciruramb_cc */

alter table ESTAB_2008_STEP2 change qtinst33 qt_sala_ciruramb_cc int(4);

/* renomear qtinst34 p/ qt_sala_preparto_co */

alter table ESTAB_2008_STEP2 change qtinst34 qt_sala_preparto_co int(4);

/* renomear qtinst35 p/ qt_sala_partonor_co */

alter table ESTAB_2008_STEP2 change qtinst35 qt_sala_partonor_co int(4);

/* renomear qtinst36 p/ qt_sala_curetagem_co */

alter table ESTAB_2008_STEP2 change qtinst36 qt_sala_curetagem_co int(4);

/* renomear qtinst37 p/ qt_sala_cirur_co */

alter table ESTAB_2008_STEP2 change qtinst37 qt_sala_cirur_co int(4);

/* renomear qtleit05 p/ qt_leito_rep_pedi_ue*/

alter table ESTAB_2008_STEP2 change qtleit05 qt_leito_rep_pedi_ue int(4);

/*apagar qtleit06, qtleit07, qtleit08*/

alter table ESTAB_2008_STEP2 drop qtleit06;
alter table ESTAB_2008_STEP2 drop qtleit07;
alter table ESTAB_2008_STEP2 drop qtleit08;

/* renomear qtleit09 p/ qt_equip_odonto_ue*/

alter table ESTAB_2008_STEP2 change qtleit09 qt_equip_odonto_ue int(4);

/* renomear qtleit21 p/ qt_leito_rep_pedi_amb*/

alter table ESTAB_2008_STEP2 change qtleit21 qt_leito_rep_pedi_amb int(4);

/*apagar qtleit19, qtleit20, qtleit22 */

alter table ESTAB_2008_STEP2 drop qtleit19;
alter table ESTAB_2008_STEP2 drop qtleit20;
alter table ESTAB_2008_STEP2 drop qtleit22;

/* renomear qtleit23 p/ qt_equip_odonto_amb*/

alter table ESTAB_2008_STEP2 change qtleit23 qt_equip_odonto_amb int(4);

/* renomear qtleit32 p/ qt_sala_recuo_cc*/

alter table ESTAB_2008_STEP2 change qtleit32 qt_sala_recuo_cc int(4);

/* renomear qtleit34 p/ qt_sala_recuo_cc*/

alter table ESTAB_2008_STEP2 change qtleit34 qt_leito_preparto_co int(4);

/*apagar qtleit38, qtleit39, qtleit40 */

alter table ESTAB_2008_STEP2 drop qtleit38;
alter table ESTAB_2008_STEP2 drop qtleit39;
alter table ESTAB_2008_STEP2 drop qtleit40;

/*apagar ap01cv01, ap01cv02, ap01cv05, ap01cv06, ap02cv01,ap02cv02, ap02cv05, ap02cv06,ap03cv01, ap03cv02, ap03cv05, ap03cv06, ap04cv01, ap04cv02, ap04cv05, ap04cv06 */

alter table ESTAB_2008_STEP2 drop ap01cv01;
alter table ESTAB_2008_STEP2 drop ap01cv02;
alter table ESTAB_2008_STEP2 drop ap01cv05;
alter table ESTAB_2008_STEP2 drop ap01cv06;
alter table ESTAB_2008_STEP2 drop ap02cv01;
alter table ESTAB_2008_STEP2 drop ap02cv02;
alter table ESTAB_2008_STEP2 drop ap02cv05;
alter table ESTAB_2008_STEP2 drop ap02cv06;
alter table ESTAB_2008_STEP2 drop ap03cv01;
alter table ESTAB_2008_STEP2 drop ap03cv02;
alter table ESTAB_2008_STEP2 drop ap03cv05;
alter table ESTAB_2008_STEP2 drop ap03cv06;
alter table ESTAB_2008_STEP2 drop ap04cv01;
alter table ESTAB_2008_STEP2 drop ap04cv02;
alter table ESTAB_2008_STEP2 drop ap04cv05;
alter table ESTAB_2008_STEP2 drop ap04cv06;

/*apagar gesprg1e, gesprg1m, gesprg2e, gesprg2m, gesprg4e, gesprg4m */

alter table ESTAB_2008_STEP2 drop gesprg1e;
alter table ESTAB_2008_STEP2 drop gesprg1m;
alter table ESTAB_2008_STEP2 drop gesprg2e;
alter table ESTAB_2008_STEP2 drop gesprg2m;
alter table ESTAB_2008_STEP2 drop gesprg4e;
alter table ESTAB_2008_STEP2 drop gesprg4m;

-- Criando tabela final - STEP3: 

create table ESTAB_2008_STEP3 select * from ESTAB_2008_STEP2;    