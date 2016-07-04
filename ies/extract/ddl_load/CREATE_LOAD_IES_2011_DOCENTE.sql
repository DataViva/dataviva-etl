use dataviva_raw;

drop table if exists IES_2011_DOCENTE_BLOCO;
create table IES_2011_DOCENTE_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2011/DADOS/DOCENTE.txt'
into table IES_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists IES_2011_DOCENTE;
create table IES_2011_DOCENTE select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,117,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,125,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,225,8) as IN_CAPITAL_IES,
substring(dados,233,8) as CO_DOCENTE_IES,
substring(dados,241,8) as CO_DOCENTE,
substring(dados,249,8) as CO_SITUACAO_DOCENTE,
substring(dados,257,50) as DS_SITUACAO_DOCENTE,
substring(dados,307,8) as CO_ESCOLARIDADE_DOCENTE,
substring(dados,315,14) as DS_ESCOLARIDADE_DOCENTE,
substring(dados,329,8) as CO_REGIME_TRABALHO,
substring(dados,337,38) as DS_REGIME_TRABALHO,
substring(dados,375,8) as IN_SEXO_DOCENTE,
substring(dados,383,9) as DS_SEXO_DOCENTE,
substring(dados,392,4) as NU_ANO_DOCENTE_NASC,
substring(dados,396,2) as NU_MES_DOCENTE_NASC,
substring(dados,398,2) as NU_DIA_DOCENTE_NASC,
substring(dados,400,8) as NU_IDADE_DOCENTE,
substring(dados,408,8) as CO_COR_RACA_DOCENTE,
substring(dados,416,24) as DS_COR_RACA_DOCENTE,
substring(dados,440,8) as CO_PAIS_DOCENTE,
substring(dados,448,8) as CO_NACIONALIDADE_DOCENTE,
substring(dados,456,8) as CO_UF_NASCIMENTO,
substring(dados,464,8) as CO_MUNICIPIO_NASCIMENTO,
substring(dados,472,8) as IN_DOCENTE_DEFICIENCIA,
substring(dados,480,8) as IN_CEGUEIRA,
substring(dados,488,8) as IN_BAIXA_VISAO,
substring(dados,496,8) as IN_SURDEZ,
substring(dados,504,8) as IN_DEFICIENCIA_AUDITIVA,
substring(dados,512,8) as IN_DEFICIENCIA_FISICA,
substring(dados,520,8) as IN_SURDOCEGUEIRA,
substring(dados,528,8) as IN_DEFICIENCIA_MULTIPLA,
substring(dados,536,8) as IN_DEFICIENCIA_INTELECTUAL,
substring(dados,544,8) as IN_ATU_EAD,
substring(dados,552,8) as IN_ATU_EXTENSAO,
substring(dados,560,8) as IN_ATU_GESTAO,
substring(dados,568,8) as IN_ATU_GRAD_PRESENCIAL,
substring(dados,576,8) as IN_ATU_POS_EAD,
substring(dados,584,8) as IN_ATU_POS_PRESENCIAL,
substring(dados,592,8) as IN_ATU_SEQUENCIAL,
substring(dados,600,8) as IN_ATU_PESQUISA,
substring(dados,608,8) as IN_BOLSA_PESQUISA,
substring(dados,616,8) as IN_SUBSTITUTO,
substring(dados,624,8) as IN_EXERCICIO_DT_REF,
substring(dados,632,8) as IN_VISITANTE,
substring(dados,640,8) as IN_VISITANTE_IFES_VINCULO
from IES_2011_DOCENTE_BLOCO;

select * from IES_2011_DOCENTE;


