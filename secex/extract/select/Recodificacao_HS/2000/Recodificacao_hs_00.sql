use dataviva_raw;

-- Recodificando HS1996 para HS2007:

select distinct CO_SH4 from SECEX_2000_EXP;
select distinct CO_SH4 from SECEX_2000_IMP;

-- Conforme resultado do R, apenas os codigos 9991, 9997 e 9998 não aparecem na lista de hs 2007, e devem ser recodificados

create table SECEX_2000_EXP_STEP1 select * from SECEX_2000_EXP;

alter table SECEX_2000_EXP_STEP1 add HS_07 varchar(4);

update SECEX_2000_EXP_STEP1 set HS_07=if(CO_SH4='9997' or CO_SH4='9998' or CO_SH4='9991','9999',CO_SH4);

select * from SECEX_2000_EXP_STEP1 where HS_07='9999';


