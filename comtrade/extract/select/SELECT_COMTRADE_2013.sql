-- Select COMTRADE_2013

use dataviva_raw;

drop table if exists COMTRADE_2013_STEP1;

create table COMTRADE_2013_STEP1 
select  ANO, COD_REPORTER, DESC_REPORTER, COD_PRODUTO, PESO_LIQUIDO, VALOR, CLASSIFICACAO     
from COMTRADE_2013;

-- Criando tabela para transformações

drop table if exists COMTRADE_2013_STEP2;
create table COMTRADE_2013_STEP2 select * from COMTRADE_2013_STEP1;

-- ANO - sem modificações

-- PAIS_ORIGEM - código  do país de origem

alter table COMTRADE_2013_STEP2 change COD_REPORTER PAIS_ORIGEM varchar(3);

-- PAIS_ORIGEM_DESC - nome do país de origem

alter table COMTRADE_2013_STEP2 change DESC_REPORTER PAIS_ORIGEM_DESC varchar(100);

-- Classificação HS - mudar para codigos 2013

select distinct COD_PRODUTO from COMTRADE_2013_STEP2;

alter table COMTRADE_2013_STEP2 add HS_07 char(4);

update COMTRADE_2013_STEP2 set HS_07=
		if(COD_PRODUTO='3826', '3024',
        if(COD_PRODUTO='9619', '4818',
        if(COD_PRODUTO='0308', '0307', COD_PRODUTO)));


select * from COMTRADE_2013_STEP2 where COD_PRODUTO in ('3826','9619','0308');

-- PESO_LIQUIDO - não há modificações

-- VALOR - sem modificações

-- CLASSIFICACAO - deve ser descastada

alter table COMTRADE_2013_STEP2 drop CLASSIFICACAO;

-- Criando tabela final

drop table if exists COMTRADE_2013_STEP3;
create table COMTRADE_2013_STEP3 select * from COMTRADE_2013_STEP2;


select * from COMTRADE_2013_STEP3;
