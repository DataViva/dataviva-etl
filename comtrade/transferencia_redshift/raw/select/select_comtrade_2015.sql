-- Fixando schema
SET search_path TO comtrade;

-- Criando o step3 - selecao 
drop table if exists comtrade_2015_step3;
create table comtrade_2015_step3 as
select ano, cod_reporter as pais_origem, desc_reporter as pais_origem_desc, left(cod_produto,4) as cod_produto,
sum(peso_liquido) as peso_liquido,sum(valor) as valor
from comtrade_2015_full
where cod_parceiro !='0'
group by left(cod_produto,4), cod_reporter, desc_reporter, ano;

-- Inserindo HS versão 2007
alter table comtrade_2015_step3 add hs_07 varchar(4);
update comtrade_2015_step3 set hs_07 = case when cod_produto='9619' then '4818'
when cod_produto='3826' then '3024'
when cod_produto='0308' then '0307'
else cod_produto end ;

select sum(valor) from comtrade_2015_step3 where pais_origem ='76';
