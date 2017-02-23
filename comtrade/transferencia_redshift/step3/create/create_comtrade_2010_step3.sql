-- Fixando o schema comtrade:
SET search_path TO comtrade,public;

-- Criando a tabela comtrade:
drop table if exists comtrade_2010_step3;
create table comtrade_2010_step3 (
    ANO numeric(4),
    PAIS_ORIGEM varchar(6),  
    PAIS_ORIGEM_DESC varchar(50),
    COD_PRODUTO varchar(4),
    PESO_LIQUIDO numeric(15),
    VALOR numeric(20),
    HS_07 varchar(4)); 
