use dataviva_raw;

-- Recodificando HS1996 para HS2007:

select distinct CO_SH4 from SECEX_2017_EXP;
select distinct CO_SH4 from SECEX_2017_IMP;

-- Exportação

drop table if exists SECEX_2017_EXP_STEP1;
create table SECEX_2017_EXP_STEP1 select * from SECEX_2017_EXP;

alter table SECEX_2017_EXP_STEP1 add HS_07 varchar(4);

-- Como os códigos 0308, 3826, 9619, 9620, 9991, 9992, 9997 e 9998, não aparecem na lista HS 2007, eles devem ser recodificados

-- Contando ocorrências dos vários códigos:
select CO_SH4, count(*) from SECEX_2017_EXP_STEP1 where CO_SH4 in (9991, 9992, 9997, 9998, 9999, 0308, 0307, 3826, 3824, 9619, 4818, 9620, 8529) group by CO_SH4;

-- Criação de coluna HS_07 com códigos originais da coluna CO_SH4 (quando não há necessidade de recodificação) e recodificações:
update SECEX_2017_EXP_STEP1 set HS_07=
		if(CO_SH4='9991' or CO_SH4='9992' or CO_SH4='9997' or CO_SH4='9998', '9999',
        if(CO_SH4='0308', '0307',
        if(CO_SH4='3826', '3824',
        if(CO_SH4='9619', '4818',
        if(CO_SH4='9620', '8529', CO_SH4)))));

-- Verificando se a recodificação teve êxito:
select HS_07, count(*) from SECEX_2017_EXP_STEP1 where HS_07 in (9991, 9992, 9997, 9998, 9999, 0308, 0307, 3826, 3824, 9619, 4818, 9620, 8529) group by HS_07;

-- Importação

drop table if exists SECEX_2017_IMP_STEP1;
create table SECEX_2017_IMP_STEP1 select * from SECEX_2017_IMP;

alter table SECEX_2017_IMP_STEP1 add HS_07 varchar(4);

-- Contando ocorrências dos vários códigos:
select CO_SH4, count(*) from SECEX_2017_IMP_STEP1 where CO_SH4 in (9991, 9992, 9997, 9998, 9999, 0308, 0307, 3826, 3824, 9619, 4818, 9620, 8529) group by CO_SH4;

-- Criação de coluna HS_07 com códigos originais da coluna CO_SH4 (quando não há necessidade de recodificação) e recodificações:
update SECEX_2017_IMP_STEP1 set HS_07=
		if(CO_SH4='9991' or CO_SH4='9992' or CO_SH4='9997' or CO_SH4='9998', '9999',
        if(CO_SH4='0308', '0307',
        if(CO_SH4='3826', '3824',
        if(CO_SH4='9619', '4818',
        if(CO_SH4='9620', '8529', CO_SH4)))));

-- Verificando se a recodificação teve êxito:
select HS_07, count(*) from SECEX_2017_IMP_STEP1 where HS_07 in (9991, 9992, 9997, 9998, 9999, 0308, 0307, 3826, 3824, 9619, 4818, 9620, 8529) group by HS_07;