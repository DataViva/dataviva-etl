use dataviva_raw;

drop table if exists SC_2015_MATRICULA;
create table SC_2015_MATRICULA(
NU_ANO_CENSO varchar(5),
ID_MATRICULA varchar(15),
CO_PESSOA_FISICA varchar(15),
NU_DIA varchar(2),
NU_MES varchar(2),
NU_ANO varchar(4),
NU_IDADE_REFERENCIA varchar(3),
NU_IDADE varchar(3),
NU_DURACAO_TURMA varchar(15),
NU_DUR_ATIV_COMP_MESMA_REDE varchar(5),
NU_DUR_ATIV_COMP_OUTRAS_REDES varchar(5),
NU_DUR_AEE_MESMA_REDE varchar(5),
NU_DUR_AEE_OUTRAS_REDES varchar(5),
NU_DIAS_ATIVIDADE varchar(5),
TP_SEXO varchar(2),
TP_COR_RACA varchar(2),
TP_NACIONALIDADE varchar(15),
CO_PAIS_ORIGEM varchar(15),
CO_UF_NASC varchar(2),
CO_MUNICIPIO_NASC varchar(9),
CO_UF_END varchar(3),
CO_MUNICIPIO_END varchar(9),
TP_ZONA_RESIDENCIAL varchar(9),
TP_OUTRO_LOCAL_AULA varchar(9),
IN_TRANSPORTE_PUBLICO varchar(2),
TP_RESPONSAVEL_TRANSPORTE varchar(9),
IN_TRANSP_VANS_KOMBI varchar(2),
IN_TRANSP_MICRO_ONIBUS varchar(2),
IN_TRANSP_ONIBUS varchar(2),
IN_TRANSP_BICICLETA varchar(2),
IN_TRANSP_TR_ANIMAL varchar(2),
IN_TRANSP_OUTRO_VEICULO varchar(2),
IN_TRANSP_EMBAR_ATE5 varchar(2),
IN_TRANSP_EMBAR_5A15 varchar(2),
IN_TRANSP_EMBAR_15A35 varchar(2),
IN_TRANSP_EMBAR_35 varchar(2),
IN_TRANSP_TREM_METRO varchar(2),
IN_NECESSIDADE_ESPECIAL varchar(2),
IN_CEGUEIRA varchar(2),
IN_BAIXA_VISAO varchar(2),
IN_SURDEZ varchar(2),
IN_DEF_AUDITIVA varchar(2),
IN_SURDOCEGUEIRA varchar(2),
IN_DEF_FISICA varchar(2),
IN_DEF_INTELECTUAL varchar(2),
IN_DEF_MULTIPLA varchar(2),
IN_AUTISMO varchar(2),
IN_SINDROME_ASPERGER varchar(2),
IN_SINDROME_RETT varchar(2),
IN_TRANSTORNO_DI varchar(2),
IN_SUPERDOTACAO varchar(2),
IN_RECURSO_LEDOR varchar(2),
IN_RECURSO_TRANSCRICAO varchar(2),
IN_RECURSO_INTERPRETE varchar(2),
IN_RECURSO_LIBRAS varchar(2),
IN_RECURSO_LABIAL varchar(2),
IN_RECURSO_BRAILLE varchar(2),
IN_RECURSO_AMPLIADA_16 varchar(2),
IN_RECURSO_AMPLIADA_20 varchar(2),
IN_RECURSO_AMPLIADA_24 varchar(2),
IN_RECURSO_NENHUM varchar(2),
TP_INGRESSO_FEDERAIS varchar(15),
TP_MEDIACAO_DIDATICO_PEDAGO varchar(15),
IN_ESPECIAL_EXCLUSIVA varchar(2),
IN_REGULAR varchar(2),
IN_EJA varchar(2),
IN_PROFISSIONALIZANTE varchar(2),
TP_ETAPA_ENSINO varchar(9),
TP_ETAPA_AGREGADA varchar(9),
ID_TURMA varchar(15),
CO_CURSO_EDUC_PROFISSIONAL varchar(9),
TP_UNIFICADA varchar(15),
TP_TIPO_TURMA varchar(15),
CO_ENTIDADE varchar(9),
CO_REGIAO varchar(9),
CO_MESORREGIAO varchar(9),
CO_MICRORREGIAO varchar(9),
CO_UF varchar(9),
CO_MUNICIPIO varchar(9),
CO_DISTRITO varchar(9),
TP_DEPENDENCIA varchar(9),
TP_LOCALIZACAO varchar(9),
TP_CATEGORIA_ESCOLA_PRIVADA varchar(9),
IN_CONVENIADA_PP varchar(2),
TP_CONVENIO_PODER_PUBLICO varchar(9),
IN_MANT_ESCOLA_PRIVADA_EMP varchar(2),
IN_MANT_ESCOLA_PRIVADA_ONG varchar(2),
IN_MANT_ESCOLA_PRIVADA_SIND varchar(2),
IN_MANT_ESCOLA_PRIVADA_SIST_S varchar(2),
IN_MANT_ESCOLA_PRIVADA_S_FINS varchar(2),
TP_REGULAMENTACAO varchar(9),
TP_LOCALIZACAO_DIFERENCIADA varchar(15),
IN_EDUCACAO_INDIGENA varchar(2)
);

load data local infile 'Y:/Censo Escolar/2015/DADOS/MATRICULA_CO.csv'
into table SC_2015_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2015/DADOS/MATRICULA_NORDESTE.csv'
into table SC_2015_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2015/DADOS/MATRICULA_NORTE.csv'
into table SC_2015_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2015/DADOS/MATRICULA_SUDESTE.csv'
into table SC_2015_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2015/DADOS/MATRICULA_SUL.csv'
into table SC_2015_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


select * from SC_2015_MATRICULA;

