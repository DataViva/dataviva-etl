use dataviva_raw;

/* 
    Tabela IES_2016_IES é removida, caso exista. 
    Uma nova tabela IES_2016_IES é criada.
*/
drop table if exists IES_2016_IES;
create table IES_2016_IES(
CO_IES varchar(8),
NO_IES varchar(200),
SGL_IES varchar(20),
CO_MANTENEDORA varchar(8),
NO_MANTENEDORA varchar(200),
CO_CATEGORIA_ADMINISTRATIVA varchar(8),
DS_CATEGORIA_ADMINISTRATIVA varchar(100),
CO_ORGANIZACAO_ACADEMICA varchar(8),
DS_ORGANIZACAO_ACADEMICA varchar(100),
CO_MUNICIPIO_IES varchar(8),
NO_MUNICIPIO_IES varchar(150),
CO_UF_IES varchar(8),
SGL_UF_IES varchar(2),
NO_REGIAO_IES varchar(30),
IN_CAPITAL_IES varchar(8),
QT_TEC_TOTAL varchar(8),
QT_TEC_FUND_INCOMP_FEM varchar(8),
QT_TEC_FUND_INCOMP_MASC varchar(8),
QT_TEC_FUND_COMP_FEM varchar(8),
QT_TEC_FUND_COMP_MASC varchar(8),
QT_TEC_MEDIO_FEM varchar(8),
QT_TEC_MEDIO_MASC varchar(8),
QT_TEC_SUPERIOR_FEM varchar(8),
QT_TEC_SUPERIOR_MASC varchar(8),
QT_TEC_ESPECIALIZACAO_FEM varchar(8),
QT_TEC_ESPECIALIZACAO_MASC varchar(8),
QT_TEC_MESTRADO_FEM varchar(8),
QT_TEC_MESTRADO_MASC varchar(8),
QT_TEC_DOUTORADO_FEM varchar(8),
QT_TEC_DOUTORADO_MASC varchar(8),
IN_ACESSO_PORTAL_CAPES varchar(8),
IN_ACESSO_OUTRAS_BASES varchar(8),
IN_REPOSITORIO_INSTITUCIONAL varchar(8),
IN_BUSCA_INTEGRADA varchar(8),
IN_SERVICO_INTERNET varchar(8),
IN_PARTICIPA_REDE_SOCIAL varchar(8),
IN_CATALOGO_ONLINE varchar(8),
QT_PERIODICO_ELETRONICO varchar(20),
QT_LIVRO_ELETRONICO varchar(20),
IN_REFERENTE varchar(8),
VL_RECEITA_PROPRIA varchar(20),
VL_TRANSFERENCIA varchar(20),
VL_OUTRA_RECEITA varchar(20),
VL_DES_PESSOAL_REM_DOCENTE varchar(20),
VL_DES_PESSOAL_REM_TECNICO varchar(20),
VL_DES_PESSOAL_ENCARGO varchar(20),
VL_DES_CUSTEIO varchar(20),
VL_DES_INVESTIMENTO varchar(20),
VL_DES_PESQUISA varchar(20),
VL_DES_OUTRAS varchar(20));

/* 
    Dados de instituições de ensino superior 
    obtidos junto ao INEP são carregados
    na tabela IES_2016_IES.
*/
load data local infile 'H:/HEDU/Dados/2016/DADOS/DM_IES.csv'
into table IES_2016_IES
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;