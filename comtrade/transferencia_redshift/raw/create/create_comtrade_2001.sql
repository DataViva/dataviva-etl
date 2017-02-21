-- Criando a tabela comtrade:
CREATE TABLE comtrade.COMTRADE_2001 (
	COD_PRODUTO varchar(4),
	DESC_PRODUTO varchar(200),
	COD_ESTIMACAO varchar(2),
	PESO_LIQUIDO numeric(15),
    CLASSIFICACAO varchar(3),
    ISO3_PARCEIRO varchar(5),
    COD_PARCEIRO varchar(3),
    DESC_PARCEIRO varchar(200),
    COD_QUANTIDADE varchar(3),
    DESC_QUANTIDADE varchar(100),
    COD_COMERCIO varchar(2),
    DESC_COMERCIO varchar(50),
    ISO3_REPORTER varchar(20),
    COD_REPORTER varchar(6),
    DESC_REPORTER varchar(50),
    QUANT_SUPLEMENTAR numeric(20),
    VALOR numeric(20),
    ANO numeric(4)
); 
