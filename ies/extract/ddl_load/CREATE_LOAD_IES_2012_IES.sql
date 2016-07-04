use dataviva_raw;

rename table IES_2012_IES to IES_2012_IES_T1;

drop table if exists IES_2012_IES_BLOCO;
create table IES_2012_IES_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2012/DADOS/INSTITUICAO.txt'
into table IES_2012_IES_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2012_IES select 
substring(dados,1,8) as CO_IES,
substring(dados,9,200) as NO_IES,
substring(dados,209,8) as CO_MANTENEDORA,
substring(dados,217,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,225,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,325,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,333,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,433,8) as CO_MUNICIPIO_IES,
substring(dados,441,150) as NO_MUNICIPIO_IES,
substring(dados,591,8) as CO_UF_IES,
substring(dados,599,2) as SGL_UF_IES,
substring(dados,601,30) as NO_REGIAO_IES,
substring(dados,631,8) as IN_CAPITAL_IES,
substring(dados,639,8) as QT_TEC_TOTAL,
substring(dados,647,8) as QT_TEC_FUND_INCOMP_MASC,
substring(dados,655,8) as QT_TEC_FUND_INCOMP_FEM,
substring(dados,663,8) as QT_TEC_FUND_COMP_MASC,
substring(dados,671,8) as QT_TEC_FUND_COMP_FEM,
substring(dados,679,8) as QT_TEC_MEDIO_MASC,
substring(dados,687,8) as QT_TEC_MEDIO_FEM,
substring(dados,695,8) as QT_TEC_SUPERIOR_MASC,
substring(dados,703,8) as QT_TEC_SUPERIOR_FEM,
substring(dados,711,8) as QT_TEC_ESPECIALIZACAO_MASC,
substring(dados,719,8) as QT_TEC_ESPECIALIZACAO_FEM,
substring(dados,727,8) as QT_TEC_MESTRADO_MASC,
substring(dados,735,8) as QT_TEC_MESTRADO_FEM,
substring(dados,743,8) as QT_TEC_DOUTORADO_MASC,
substring(dados,751,8) as QT_TEC_DOUTORADO_FEM,
substring(dados,759,8) as IN_ACESSO_PORTAL_CAPES,
substring(dados,767,8) as IN_ACESSO_OUTRAS_BASES,
substring(dados,775,8) as IN_REFERENTE,
substring(dados,783,14) as VL_RECEITA_PROPRIA,
substring(dados,797,14) as VL_TRANSFERENCIA,
substring(dados,811,14) as VL_OUTRA_RECEITA,
substring(dados,825,14) as VL_DES_PESSOAL_REM_DOCENTE,
substring(dados,839,14) as VL_DES_PESSOAL_REM_TECNICO,
substring(dados,853,14) as VL_DES_PESSOAL_ENCARGO,
substring(dados,867,14) as VL_DES_CUSTEIO,
substring(dados,881,14) as VL_DES_INVESTIMENTO,
substring(dados,895,14) as VL_DES_PESQUISA,
substring(dados,909,14) as VL_DES_OUTRAS
from IES_2012_IES_BLOCO;


select * from IES_2012_IES;




