-- 2016

-- Exportacao
-- UF

alter table SECEX_2016_EXP_STEP1 add UF_IBGE varchar(8);

update SECEX_2016_EXP_STEP1 left join merge_uf 
on SECEX_2016_EXP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_2016_EXP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);

-- Municipio

alter table SECEX_2016_EXP_STEP1 add MUN_IBGE varchar(8);

update SECEX_2016_EXP_STEP1 left join merge_mun 
on SECEX_2016_EXP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_2016_EXP_STEP1 set MUN_IBGE=if(MUN_IBGE is NULL,CO_MUN_GEO,MUN_IBGE);


-- Importacao
-- UF

alter table SECEX_2016_IMP_STEP1 add UF_IBGE varchar(8);

update SECEX_2016_IMP_STEP1 left join merge_uf 
on SECEX_2016_IMP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_2016_IMP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);

-- Municipio

alter table SECEX_2016_IMP_STEP1 add MUN_IBGE varchar(8);

update SECEX_2016_IMP_STEP1 left join merge_mun 
on SECEX_2016_IMP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_2016_IMP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);


