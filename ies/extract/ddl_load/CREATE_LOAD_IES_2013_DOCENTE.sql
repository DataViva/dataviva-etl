use dataviva_raw;

drop table if exists IES_2013_DOCENTE;
create table IES_2013_DOCENTE(
CO_IES varchar(8),
NO_IES varchar(200),
CO_CATEGORIA_ADMINISTRATIVA varchar(8),
DS_CATEGORIA_ADMINISTRATIVA varchar(100),
CO_ORGANIZACAO_ACADEMICA varchar(8),
DS_ORGANIZACAO_ACADEMICA varchar(100),
IN_CAPITAL_IES varchar(8),
CO_DOCENTE_IES varchar(20),
CO_DOCENTE varchar(20),
CO_SITUACAO_DOCENTE varchar(8),
DS_SITUACAO_DOCENTE varchar(200),
CO_ESCOLARIDADE_DOCENTE varchar(8),
DS_ESCOLARIDADE_DOCENTE varchar(100),
CO_REGIME_TRABALHO varchar(8),
DS_REGIME_TRABALHO varchar(200),
IN_SEXO_DOCENTE varchar(8),
DS_SEXO_DOCENTE varchar(100),
NU_ANO_DOCENTE_NASC varchar(8),
NU_MES_DOCENTE_NASC varchar(8),
NU_DIA_DOCENTE_NASC varchar(8),
NU_IDADE_DOCENTE varchar(8),
CO_COR_RACA_DOCENTE varchar(8),
DS_COR_RACA_DOCENTE varchar(100),
CO_PAIS_DOCENTE varchar(8),
CO_NACIONALIDADE_DOCENTE varchar(8),
CO_UF_NASCIMENTO varchar(8),
CO_MUNICIPIO_NASCIMENTO varchar(8),
IN_DOCENTE_DEFICIENCIA varchar(8),
IN_CEGUEIRA varchar(8),
IN_BAIXA_VISAO varchar(8),
IN_SURDEZ varchar(8),
IN_DEFICIENCIA_AUDITIVA varchar(8),
IN_DEFICIENCIA_FISICA varchar(8),
IN_SURDOCEGUEIRA varchar(8),
IN_DEFICIENCIA_MULTIPLA varchar(8),
IN_DEFICIENCIA_INTELECTUAL varchar(8),
IN_ATU_EAD varchar(8),
IN_ATU_EXTENSAO varchar(8),
IN_ATU_GESTAO varchar(8),
IN_ATU_GRAD_PRESENCIAL varchar(8),
IN_ATU_POS_EAD varchar(8),
IN_ATU_POS_PRESENCIAL varchar(8),
IN_ATU_SEQUENCIAL varchar(8),
IN_ATU_PESQUISA varchar(8),
IN_BOLSA_PESQUISA varchar(8),
IN_SUBSTITUTO varchar(8),
IN_EXERCICIO_DT_REF varchar(8),
IN_VISITANTE varchar(8),
IN_VISITANTE_IFES_VINCULO varchar(8)
);


load data local infile 'H:/HEDU/Dados/2013/Dados/DM_DOCENTE.csv'
into table IES_2013_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

select * from IES_2013_DOCENTE;




