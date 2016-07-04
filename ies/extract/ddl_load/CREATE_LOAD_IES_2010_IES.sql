use dataviva_raw;

drop table if exists IES_2010_IES_BLOCO;
create table IES_2010_IES_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2010/DADOS/IES.txt'
into table IES_2010_IES_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2010_IES select 
substring(dados,1,8) as CO_IES ,
substring(dados,9,8) as CO_MANTENEDORA,
substring(dados,17,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,25,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,125,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,133,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,233,8) as CO_MUNICIPIO_IES,
substring(dados,241,150) as NO_MUNICIPIO_IES,
substring(dados,391,8) as CO_UF,
substring(dados,399,2) as SGL_UF,
substring(dados,401,30) as NO_REGIAO,
substring(dados,431,8) as IN_CAPITAL,
substring(dados,439,8) as QT_TEC_TOTAL,
substring(dados,447,8) as QT_TEC_FUND_INCOMP_FEM,
substring(dados,455,8) as QT_TEC_FUND_INCOMP_MASC,
substring(dados,463,8) as QT_TEC_FUND_COMP_FEM,
substring(dados,471,8) as QT_TEC_FUND_COMP_MASC,
substring(dados,479,8) as QT_TEC_MEDIO_FEM,
substring(dados,487,8) as QT_TEC_MEDIO_MASC,
substring(dados,495,8) as QT_TEC_SUPERIOR_FEM,
substring(dados,503,8) as QT_TEC_SUPERIOR_MASC,
substring(dados,511,8) as QT_TEC_ESPECIAL_FEM,
substring(dados,519,8) as QT_TEC_ESPECIAL_MASC,
substring(dados,527,8) as QT_TEC_MESTRADO_FEM,
substring(dados,535,8) as QT_TEC_MESTRADO_MASC,
substring(dados,543,8) as QT_TEC_DOUTORADO_FEM,
substring(dados,551,8) as QT_TEC_DOUTORADO_MASC,
substring(dados,559,8) as IN_ACESSO_PORTAL_CAPES,
substring(dados,567,8) as IN_ACESSO_OUTRAS_BASES,
substring(dados,575,8) as IN_REFERENTE,
substring(dados,583,14) as VL_RECEITA_PROPRIA,
substring(dados,597,14) as VL_TRANSFERENCIA,
substring(dados,611,14) as VL_OUTRA_RECEITA,
substring(dados,625,14) as VL_DES_PESSOAL_REM_DOCENTE,
substring(dados,639,14) as VL_DES_PESSOAL_REM_TECNICO,
substring(dados,653,14) as VL_DES_PESSOAL_ENCARGO,
substring(dados,667,14) as VL_DES_CUSTEIO,
substring(dados,681,14) as VL_DES_INVESTIMENTO,
substring(dados,695,14) as VL_DES_PESQUISA,
substring(dados,709,14) as VL_DES_OUTRAS
from IES_2010_IES_BLOCO;


select * from IES_2010_IES_BLOCO;
select * from IES_2010_IES;




