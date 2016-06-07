use dataviva_raw;

-- Recodificando HS1996 para HS2007:

select distinct CO_SH4 from SECEX_2003_EXP;
select distinct CO_SH4 from SECEX_2003_IMP;

-- Conforme resultado do R, apenas os codigos 9991, 9992, 9997 e 9998 não aparecem na lista de hs 2007, e devem ser recodificados

create table SECEX_2003_EXP_STEP1 select * from SECEX_2003_EXP;

alter table SECEX_2003_EXP_STEP1 add HS_07 varchar(4);

update SECEX_2003_EXP_STEP1 set HS_07=if(CO_SH4='9997' or CO_SH4='9998' or CO_SH4='9991' or CO_SH4='9992','9999',CO_SH4);

select * from SECEX_2003_EXP_STEP1 where HS_07='9999';


