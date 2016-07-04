use dataviva_raw;

drop table if exists IES_2012_DOCENTE_BLOCO;
drop table if exists IES_2012_DOCENTE;
create table IES_2012_DOCENTE_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2012/DADOS/DOCENTE.txt'
into table IES_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2012_DOCENTE select 
substring(dados,1,8) as CO_IES,
substring(dados,9,200) as NO_IES,
substring(dados,209,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,217,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,317,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,325,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,425,8) as IN_CAPITAL_IES,
substring(dados,433,8) as CO_DOCENTE_IES,
substring(dados,441,13) as CO_DOCENTE,
substring(dados,454,8) as CO_SITUACAO_DOCENTE,
substring(dados,462,50) as DS_SITUACAO_DOCENTE,
substring(dados,512,8) as CO_ESCOLARIDADE_DOCENTE,
substring(dados,520,14) as DS_ESCOLARIDADE_DOCENTE,
substring(dados,534,8) as CO_REGIME_TRABALHO,
substring(dados,542,38) as DS_REGIME_TRABALHO,
substring(dados,580,8) as IN_SEXO_DOCENTE,
substring(dados,588,9) as DS_SEXO_DOCENTE,
substring(dados,597,4) as NU_ANO_DOCENTE_NASC,
substring(dados,601,2) as NU_MES_DOCENTE_NASC,
substring(dados,603,2) as NU_DIA_DOCENTE_NASC,
substring(dados,605,8) as NU_IDADE_DOCENTE,
substring(dados,613,8) as CO_COR_RACA_DOCENTE,
substring(dados,621,24) as DS_COR_RACA_DOCENTE,
substring(dados,645,8) as CO_PAIS_DOCENTE,
substring(dados,653,8) as CO_NACIONALIDADE_DOCENTE,
substring(dados,661,8) as CO_UF_NASCIMENTO,
substring(dados,669,8) as CO_MUNICIPIO_NASCIMENTO,
substring(dados,677,8) as IN_DOCENTE_DEFICIENCIA,
substring(dados,685,8) as IN_CEGUEIRA,
substring(dados,693,8) as IN_BAIXA_VISAO,
substring(dados,701,8) as IN_SURDEZ,
substring(dados,709,8) as IN_DEFICIENCIA_AUDITIVA,
substring(dados,717,8) as IN_DEFICIENCIA_FISICA,
substring(dados,725,8) as IN_SURDOCEGUEIRA,
substring(dados,733,8) as IN_DEFICIENCIA_MULTIPLA,
substring(dados,741,8) as IN_DEFICIENCIA_INTELECTUAL,
substring(dados,749,8) as IN_ATU_EAD,
substring(dados,757,8) as IN_ATU_EXTENSAO,
substring(dados,765,8) as IN_ATU_GESTAO,
substring(dados,773,8) as IN_ATU_GRAD_PRESENCIAL,
substring(dados,781,8) as IN_ATU_POS_EAD,
substring(dados,789,8) as IN_ATU_POS_PRESENCIAL,
substring(dados,797,8) as IN_ATU_SEQUENCIAL,
substring(dados,805,8) as IN_ATU_PESQUISA,
substring(dados,813,8) as IN_BOLSA_PESQUISA,
substring(dados,821,8) as IN_SUBSTITUTO,
substring(dados,829,8) as IN_EXERCICIO_DT_REF,
substring(dados,837,8) as IN_VISITANTE,
substring(dados,845,8) as IN_VISITANTE_IFES_VINCULO
from IES_2012_DOCENTE_BLOCO;

select * from IES_2012_DOCENTE;



