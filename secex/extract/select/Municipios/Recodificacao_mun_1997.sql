use dataviva_raw;

drop table if exists merge_uf;
create table merge_uf(cod_ibge char(2), cod_mdic char(2));

load data local infile 'H:/secex/Municipio/UF_ibge_mdic.txt'
into table merge_uf
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;


drop table if exists merge_mun;
create table merge_mun(cod_ibge char(7), cod_mdic char(7));

load data local infile 'H:/secex/Municipio/Municipios_ibge_mdic.txt'
into table merge_mun
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

-- 1997

-- Exportacao
-- UF

alter table SECEX_1997_EXP_STEP1 add UF_IBGE varchar(8);

update SECEX_1997_EXP_STEP1 left join merge_uf 
on SECEX_1997_EXP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_1997_EXP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);

-- Municipio

alter table SECEX_1997_EXP_STEP1 add MUN_IBGE varchar(8);

update SECEX_1997_EXP_STEP1 left join merge_mun 
on SECEX_1997_EXP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_1997_EXP_STEP1 set MUN_IBGE=if(MUN_IBGE is NULL,CO_MUN_GEO,MUN_IBGE);


-- Importacao
-- UF

alter table SECEX_1997_IMP_STEP1 add UF_IBGE varchar(8);

update SECEX_1997_IMP_STEP1 left join merge_uf 
on SECEX_1997_IMP_STEP1.CO_UF = merge_uf.cod_mdic
set UF_IBGE = merge_uf.cod_ibge;

update SECEX_1997_IMP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);

-- Municipio

alter table SECEX_1997_IMP_STEP1 add MUN_IBGE varchar(8);

update SECEX_1997_IMP_STEP1 left join merge_mun 
on SECEX_1997_IMP_STEP1.CO_MUN_GEO = merge_mun.cod_mdic
set MUN_IBGE = merge_mun.cod_ibge;

update SECEX_1997_IMP_STEP1 set UF_IBGE=if(UF_IBGE is NULL,CO_UF,UF_IBGE);


