-- 2017

use dataviva_raw;

-- Exportação

-- UF

alter table SECEX_2017_EXP_STEP1 add UF_IBGE varchar(8);

update SECEX_2017_EXP_STEP1 left join merge_uf 
on SECEX_2017_EXP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_2017_EXP_STEP1 set UF_IBGE = if(UF_IBGE is NULL, CO_UF, UF_IBGE);

-- Município

-- Verificando códigos de municípios que ocorrem nos dados SECEX 2017, mas não costam da tabela merge_mun:

select distinct CO_MUN_GEO from SECEX_2017_EXP_STEP1 where CO_MUN_GEO not in (select cod_mdic from merge_mun);

-- Resultados: 9400000 e 9999999

alter table SECEX_2017_EXP_STEP1 add MUN_IBGE varchar(8);

update SECEX_2017_EXP_STEP1 left join merge_mun 
on SECEX_2017_EXP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_2017_EXP_STEP1 set MUN_IBGE = if(MUN_IBGE is NULL, CO_MUN_GEO, MUN_IBGE);

-- Importação

-- UF

alter table SECEX_2017_IMP_STEP1 add UF_IBGE varchar(8);

update SECEX_2017_IMP_STEP1 left join merge_uf 
on SECEX_2017_IMP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_2017_IMP_STEP1 set UF_IBGE = if(UF_IBGE is NULL, CO_UF, UF_IBGE);

-- Município

-- Verificando códigos de municípios que ocorrem nos dados SECEX 2017, mas não costam da tabela merge_mun:

select distinct CO_MUN_GEO from SECEX_2017_IMP_STEP1 where CO_MUN_GEO not in (select cod_mdic from merge_mun); 

-- Resultados: 9400000 e 9999999

alter table SECEX_2017_IMP_STEP1 add MUN_IBGE varchar(8);

update SECEX_2017_IMP_STEP1 left join merge_mun 
on SECEX_2017_IMP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_2017_IMP_STEP1 set MUN_IBGE = if(MUN_IBGE is NULL, CO_MUN_GEO, MUN_IBGE);