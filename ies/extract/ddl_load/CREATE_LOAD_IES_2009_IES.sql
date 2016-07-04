create table IES_2009_IES_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2009/DADOS/IES.txt'
into table IES_2009_IES_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2009_IES select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_MANTENEDORA,
substring(dados,17,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,25,50) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,75,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,83,100) as NO_ORGANIZACAO_ACADEMICA,
substring(dados,183,8) as CO_MUNICIPIO_IES,
substring(dados,191,150) as NO_MUNICIPIO_IES,
substring(dados,341,8) as CO_UF,
substring(dados,349,2) as SGL_UF,
substring(dados,351,30) as NO_REGIAO,
substring(dados,381,8) as IN_CAPITAL,
substring(dados,389,8) as IN_ENTIDADE_BENEFICENTE,
substring(dados,397,8) as QT_TEC_TOTAL,
substring(dados,405,8) as QT_TEC_FUND_INCOMP_FEM,
substring(dados,413,8) as QT_TEC_FUND_INCOMP_MASC,
substring(dados,421,8) as QT_TEC_FUND_COMP_FEM,
substring(dados,429,8) as QT_TEC_FUND_COMP_MASC,
substring(dados,437,8) as QT_TEC_MEDIO_FEM,
substring(dados,445,8) as QT_TEC_MEDIO_MASC,
substring(dados,453,8) as QT_TEC_SUPERIOR_FEM,
substring(dados,461,8) as QT_TEC_SUPERIOR_MASC,
substring(dados,469,8) as QT_TEC_ESPECIALISTA_FEM,
substring(dados,477,8) as QT_TEC_ESPECIALISTA_MASC,
substring(dados,485,8) as QT_TEC_MESTRADO_FEM,
substring(dados,493,8) as QT_TEC_MESTRADO_MASC,
substring(dados,501,8) as QT_TEC_DOUTORADO_FEM,
substring(dados,509,8) as QT_TEC_DOUTORADO_MASC
from IES_2009_IES_BLOCO;

