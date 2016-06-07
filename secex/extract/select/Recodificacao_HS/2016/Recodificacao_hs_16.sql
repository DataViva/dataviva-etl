use dataviva_raw;

-- Recodificando HS1996 para HS2007:

select distinct CO_SH4 from SECEX_2016_EXP;
select distinct CO_SH4 from SECEX_2016_IMP;

-- Conforme resultado do R, apenas os codigos 9991, 9992, 9997 e 9998 não aparecem na lista de hs 2007, e devem ser recodificados

drop table if exists SECEX_2016_EXP_STEP1;
create table SECEX_2016_EXP_STEP1 select * from SECEX_2016_EXP;

alter table SECEX_2016_EXP_STEP1 add HS_07 varchar(4);

# Os codigos 3826, 9619, 9991, 9992, 9997 e 9998 não aparecem em 2007
update SECEX_2016_EXP_STEP1 set HS_07=
		if(CO_SH4='9997' or CO_SH4='9998' or CO_SH4='9991' or CO_SH4='9992','9999',
        if(CO_SH4='3826', '3024',
        if(CO_SH4='9619', '4818',
        if(CO_SH4='0308', '0307',CO_SH4))));

select * from SECEX_2016_EXP_STEP1 where CO_SH4='9997';
select * from SECEX_2016_EXP_STEP1 where CO_SH4='9998';
select * from SECEX_2016_EXP_STEP1 where CO_SH4='9619';
select * from SECEX_2016_EXP_STEP1 where CO_SH4='3826';
select * from SECEX_2016_EXP_STEP1 where CO_SH4='0308';

-- Importacao

drop table if exists SECEX_2016_IMP_STEP1;
create table SECEX_2016_IMP_STEP1 select * from SECEX_2016_IMP;

alter table SECEX_2016_IMP_STEP1 add HS_07 varchar(4);

# Os codigos 3826, 9619, 9991, 9992, 9997 e 9998 não aparecem em 2007
update SECEX_2015_IMP_STEP1 set HS_07=if(CO_SH4='0308','0307',if(CO_SH4='9619', '4818',CO_SH4));

select * from SECEX_2015_IMP_STEP1 where CO_SH4='0308';
select * from SECEX_2015_IMP_STEP1 where CO_SH4='9619';


