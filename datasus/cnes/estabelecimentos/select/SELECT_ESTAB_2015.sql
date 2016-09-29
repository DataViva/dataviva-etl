#SELECT ESTAB

use cnes_estabelecimentos;

create table ESTAB_2015_STEP1
select codufmun, cod_cep, cpf_cnpj, pf_pj, niv_dep, cnpj_man, regsaude, micr_reg, vinc_sus, esfera_a, retencao, tp_unid, niv_hier, tp_prest, av_acred, clasaval, dt_acred, av_pnass, gesprg1e, gesprg1m, gesprg2e,
gesprg2m, gesprg4e, gesprg4m, nivate_a, gesprg3e, gesprg3m, gesprg5e, gesprg5m, gesprg6e, gesprg6m, nivate_h, qtleitp1, qtleitp2, qtleitp3, leithosp, qtinst01, qtinst02, qtinst03, qtinst04, qtinst05, qtinst06, 
qtinst07, qtinst08, qtinst09, qtinst10, qtinst11, qtinst12, qtinst13, qtinst14, urgemerg, qtinst15, qtinst16, qtinst17, qtinst18, qtinst19, qtinst20, qtinst21, qtinst22, qtinst23, qtinst24, qtinst25, qtinst26, 
qtinst27, qtinst28, qtinst29, qtinst30, atendamb, qtinst31, qtinst32, qtinst33, centrcir, qtinst34, qtinst35, qtinst36, qtinst37, centrobs, qtleit05, qtleit06, qtleit07, qtleit08, qtleit09, qtleit19, qtleit20, 
qtleit21, qtleit22, qtleit23, qtleit32, qtleit34, qtleit38, qtleit39, qtleit40, centrneo, atendhos, serap01p, serap01t, serap02p, serap02t, serap03p, serap03t, serap04p, serap04t, serap05p, serap05t, serap06p, 
serap06t, serap07p, serap07t, serap08p, serap08t, serap09p, serap09t, serap10p, serap10t, serap11p, serap11t, serapoio, res_biol, res_quim, res_radi, res_comu, coletres, ap01cv01, ap01cv02, ap01cv05, ap01cv06, 
ap01cv03, ap01cv04, ap02cv01, ap02cv02, ap02cv05, ap02cv06, ap02cv03, ap02cv04, ap03cv01, ap03cv02, ap03cv05, ap03cv06, ap03cv03, ap03cv04, ap04cv01, ap04cv02, ap04cv05, ap04cv06, ap04cv03, ap04cv04, ap05cv01, 
ap05cv02, ap05cv05, ap05cv06, ap05cv03, ap05cv04, ap06cv01, ap06cv02, ap06cv05, ap06cv06, ap06cv03, ap06cv04, ap07cv01, ap07cv02, ap07cv05, ap07cv06, ap07cv03, ap07cv04, atend_pr, dt_atual, competen
from estab_2015;
