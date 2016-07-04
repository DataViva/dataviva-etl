use dataviva_raw;

drop table if exists IES_2010_DOCENTE_BLOCO;
drop table if exists IES_2010_DOCENTE;
create table IES_2010_DOCENTE_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2010/DADOS/DOCENTE.txt'
into table IES_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2010_DOCENTE select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,117,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,125,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,225,8) as IN_CAPITAL,
substring(dados,233,8) as CO_DOCENTE_IES,
substring(dados,241,14) as CO_DOCENTE,
substring(dados,255,8) as CO_SITUACAO_DOCENTE,
substring(dados,263,8) as CO_ESCOLARIDADE_DOCENTE,
substring(dados,271,14) as DS_ESCOLARIDADE_DOCENTE,
substring(dados,285,8) as CO_REGIME_TRABALHO,
substring(dados,293,38) as DS_REGIME_TRABALHO,
substring(dados,331,8) as IN_SEXO_DOCENTE,
substring(dados,339,9) as DS_SEXO_DOCENTE,
substring(dados,348,4) as NU_ANO_DOCENTE_NASC,
substring(dados,352,2) as NU_MES_DOCENTE_NASC,
substring(dados,354,2) as NU_DIA_DOCENTE_NASC,
substring(dados,356,8) as NU_IDADE_DOCENTE,
substring(dados,364,8) as CO_COR_RACA_DOCENTE,
substring(dados,372,24) as DS_COR_RACA_DOCENTE,
substring(dados,396,8) as CO_PAIS_DOCENTE,
substring(dados,404,8) as CO_NACIONALIDADE_DOCENTE,
substring(dados,412,8) as CO_UF_NASCIMENTO,
substring(dados,420,8) as CO_MUNICIPIO_NASCIMENTO,
substring(dados,428,8) as IN_DOCENTE_DEFICIENCIA,
substring(dados,436,8) as IN_CEGUEIRA,
substring(dados,444,8) as IN_BAIXA_VISA,
substring(dados,452,8) as IN_SURDEZ,
substring(dados,460,8) as IN_DEFICIENCIA_AUDITIVA,
substring(dados,468,8) as IN_DEFICIENCIA_FISICA,
substring(dados,476,8) as IN_SURDOCEGUEIRA,
substring(dados,484,8) as IN_DEFICIENCIA_MULTIPLA,
substring(dados,492,8) as IN_DEFICIENCIA_INTELECTUAL,
substring(dados,500,8) as IN_ATU_EAD,
substring(dados,508,8) as IN_ATU_EXTENSAO,
substring(dados,516,8) as IN_ATU_GESTAO,
substring(dados,524,8) as IN_ATU_GRAD_PRESENCIAL,
substring(dados,532,8) as IN_ATU_POS_EAD,
substring(dados,540,8) as IN_ATU_POS_PRESENCIAL,
substring(dados,548,8) as IN_ATU_SEQUENCIAL,
substring(dados,556,8) as IN_ATU_PESQUISA,
substring(dados,564,8) as IN_BOLSA_PESQUISA,
substring(dados,572,8) as IN_SUBSTITUTO,
substring(dados,580,8) as IN_EXERCICIO_DT_REF,
substring(dados,588,8) as IN_VISITANTE,
substring(dados,596,8) as IN_VISITANTE_IFES_VINCULO,
substring(dados,604,10) as DT_CADASTRO
from IES_2010_DOCENTE_BLOCO;

select * from IES_2010_DOCENTE;



