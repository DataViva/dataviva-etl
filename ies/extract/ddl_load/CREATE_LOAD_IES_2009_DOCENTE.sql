create table IES_2009_DOCENTE_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2009/DADOS/DOCENTE.txt'
into table IES_2009_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2009_DOCENTE select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA ,
substring(dados,17,50) as DS_CATEGORIA_ADMINISTRATIVA ,
substring(dados,67,8) as CO_ORGANIZACAO_ACADEMICA ,
substring(dados,75,100) as NO_ORGANIZACAO_ACADEMICA ,
substring(dados,175,8) as CO_MUNICIPIO_IES ,
substring(dados,183,150) as NO_MUNICIPIO_IES ,
substring(dados,333,8) as CO_UF ,
substring(dados,341,30) as NO_REGIAO ,
substring(dados,371,8) as CO_VINCULO_IES_DOCENTE ,
substring(dados,379,8) as CO_DOCENTE,
substring(dados,387,8) as CO_SITUACAO_DOCENTE,
substring(dados,395,8) as CO_ESCOLARIDADE_DOCENTE,
substring(dados,403,8) as CO_REGIME_TRABALHO,
substring(dados,411,8) as IN_SEXO_DOCENTE,
substring(dados,419,8) as NU_ANO_DOCENTE_NASC,
substring(dados,427,8) as NU_MES_DOCENTE_NASC,
substring(dados,435,8) as NU_DIA_DOCENTE_NASC,
substring(dados,443,8) as NU_IDADE_DOCENTE,
substring(dados,451,8) as CO_COR_RACA_DOCENTE,
substring(dados,459,8) as CO_PAIS_DOCENTE,
substring(dados,467,8) as CO_NACIONALIDADE_DOCENTE,
substring(dados,475,50) as NO_NACIONALIDADE_DOCENTE,
substring(dados,525,8) as IN_DOCENTE_DEFICIENCIA,
substring(dados,533,8) as IN_CEGUEIRA,
substring(dados,541,8) as IN_BAIXA_VISAO,
substring(dados,549,8) as IN_SURDEZ,
substring(dados,557,8) as IN_DEFICIENCIA_AUDITIVA,
substring(dados,565,8) as IN_DEFICIENCIA_FISICA,
substring(dados,573,8) as IN_SURDOCEGUEIRA,
substring(dados,581,8) as IN_DEFICIENCIA_MULTIPLA,
substring(dados,589,8) as IN_DEFICIENCIA_MENTAL,
substring(dados,597,8) as IN_ATU_EAD,
substring(dados,605,8) as IN_ATU_EXTENSAO,
substring(dados,613,8) as IN_ATU_GESTAO,
substring(dados,621,8) as IN_ATU_GRAD_PRESENCIAL,
substring(dados,629,8) as IN_ATU_POS_EAD,
substring(dados,637,8) as IN_ATU_POS_PRESENCIAL,
substring(dados,645,8) as IN_ATU_SEQUENCIAL,
substring(dados,653,8) as IN_BOLSA_PESQUISA,
substring(dados,661,8) as IN_SUBSTITUTO
from IES_2009_DOCENTE_BLOCO;

