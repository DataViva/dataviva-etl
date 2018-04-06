use dataviva_raw;

/* 
    Tabela SC_2017_DOCENTE é removida, caso exista. 
    Uma nova tabela SC_2017_DOCENTE é criada.
*/
drop table if exists SC_2017_DOCENTE;
create table SC_2017_DOCENTE(
NU_ANO_CENSO varchar (5),
CO_PESSOA_FISICA varchar (13),
NU_DIA varchar (3),
NU_MES varchar (3),
NU_ANO varchar (4),
NU_IDADE_REFERENCIA varchar (4),
NU_IDADE varchar (4),
TP_SEXO varchar (1),
TP_COR_RACA varchar (1),
TP_NACIONALIDADE varchar (1),
CO_PAIS_ORIGEM varchar (4),
CO_UF_NASC varchar (3),
CO_MUNICIPIO_NASC varchar (9),
CO_UF_END varchar (3),
CO_MUNICIPIO_END varchar (9),
TP_ZONA_RESIDENCIAL varchar (2),
IN_NECESSIDADE_ESPECIAL varchar (2),
IN_CEGUEIRA varchar (2),
IN_BAIXA_VISAO varchar (2),
IN_SURDEZ varchar (2),
IN_DEF_AUDITIVA varchar (2),
IN_SURDOCEGUEIRA varchar (2),
IN_DEF_FISICA varchar (2),
IN_DEF_INTELECTUAL varchar (2),
IN_DEF_MULTIPLA varchar (2),
TP_ESCOLARIDADE varchar (2),
TP_NORMAL_MAGISTERIO varchar (15),
TP_SITUACAO_CURSO_1 varchar (1),
CO_AREA_CURSO_1 varchar (6),
CO_CURSO_1 varchar (6),
IN_LICENCIATURA_1 varchar (2),
IN_COM_PEDAGOGICA_1 varchar (2),
NU_ANO_INICIO_1 varchar (5),
NU_ANO_CONCLUSAO_1 varchar (5),
TP_TIPO_IES_1 varchar (3),
CO_IES_1 varchar (15),
TP_SITUACAO_CURSO_2 varchar (1),
CO_AREA_CURSO_2 varchar (6),
CO_CURSO_2 varchar (6),
IN_LICENCIATURA_2 varchar (2),
IN_COM_PEDAGOGICA_2 varchar (2),
NU_ANO_INICIO_2 varchar (5),
NU_ANO_CONCLUSAO_2 varchar (5),
TP_TIPO_IES_2 varchar (3),
CO_IES_2 varchar (15),
TP_SITUACAO_CURSO_3 varchar (1),
CO_AREA_CURSO_3 varchar (6),
CO_CURSO_3 varchar (6),
IN_LICENCIATURA_3 varchar (2),
IN_COM_PEDAGOGICA_3 varchar (2),
NU_ANO_INICIO_3 varchar (5),
NU_ANO_CONCLUSAO_3 varchar (5),
TP_TIPO_IES_3 varchar (3),
CO_IES_3 varchar (15),
IN_DISC_QUIMICA varchar (2),
IN_DISC_FISICA varchar (2),
IN_DISC_MATEMATICA varchar (2),
IN_DISC_BIOLOGIA varchar (2),
IN_DISC_CIENCIAS varchar (2),
IN_DISC_LINGUA_PORTUGUESA varchar (2),
IN_DISC_LINGUA_INGLES varchar (2),
IN_DISC_LINGUA_ESPANHOL varchar (2),
IN_DISC_LINGUA_FRANCES varchar (2),
IN_DISC_LINGUA_OUTRA varchar (2),
IN_DISC_LINGUA_INDIGENA varchar (2),
IN_DISC_ARTES varchar (2),
IN_DISC_EDUCACAO_FISICA varchar (2),
IN_DISC_HISTORIA varchar (2),
IN_DISC_GEOGRAFIA varchar (2),
IN_DISC_FILOSOFIA varchar (2),
IN_DISC_ENSINO_RELIGIOSO varchar (2),
IN_DISC_ESTUDOS_SOCIAIS varchar (2),
IN_DISC_SOCIOLOGIA varchar (2),
IN_DISC_EST_SOCIAIS_SOCIOLOGIA varchar (2),
IN_DISC_INFORMATICA_COMPUTACAO varchar (2),
IN_DISC_PROFISSIONALIZANTE varchar (2),
IN_DISC_ATENDIMENTO_ESPECIAIS varchar (2),
IN_DISC_DIVER_SOCIO_CULTURAL varchar (2),
IN_DISC_LIBRAS varchar (2),
IN_DISC_PEDAGOGICAS varchar (2),
IN_DISC_OUTRAS varchar (2),
IN_ESPECIALIZACAO varchar (2),
IN_MESTRADO varchar (2),
IN_DOUTORADO varchar (2),
IN_POS_NENHUM varchar (2),
IN_ESPECIFICO_CRECHE varchar (2),
IN_ESPECIFICO_PRE_ESCOLA varchar (2),
IN_ESPECIFICO_ANOS_INICIAIS varchar (2),
IN_ESPECIFICO_ANOS_FINAIS varchar (2),
IN_ESPECIFICO_ENS_MEDIO varchar (2),
IN_ESPECIFICO_EJA varchar (2),
IN_ESPECIFICO_ED_ESPECIAL varchar (2),
IN_ESPECIFICO_ED_INDIGENA varchar (2),
IN_ESPECIFICO_CAMPO varchar (2),
IN_ESPECIFICO_AMBIENTAL varchar (2),
IN_ESPECIFICO_DIR_HUMANOS varchar (2),
IN_ESPECIFICO_DIV_SEXUAL varchar (2),
IN_ESPECIFICO_DIR_ADOLESC varchar (2),
IN_ESPECIFICO_AFRO varchar (2),
IN_ESPECIFICO_OUTROS varchar (2),
IN_ESPECIFICO_NENHUM varchar (2),
TP_TIPO_DOCENTE varchar (15),
TP_TIPO_CONTRATACAO varchar (15),
ID_TURMA varchar (50),
TP_TIPO_TURMA varchar (15),
TP_MEDIACAO_DIDATICO_PEDAGO varchar (15),
IN_ESPECIAL_EXCLUSIVA varchar (2),
IN_REGULAR varchar (2),
IN_EJA varchar (2),
IN_PROFISSIONALIZANTE varchar (2),
TP_ETAPA_ENSINO varchar (15),
CO_CURSO_EDUC_PROFISSIONAL varchar (15),
CO_REGIAO varchar (15),
CO_MESORREGIAO varchar (15),
CO_MICRORREGIAO varchar (15),
CO_ENTIDADE varchar (15),
CO_UF varchar (15),
CO_MUNICIPIO varchar (15),
CO_DISTRITO varchar (15),
TP_DEPENDENCIA varchar (15),
TP_LOCALIZACAO varchar (15),
TP_CATEGORIA_ESCOLA_PRIVADA varchar (15),
IN_CONVENIADA_PP varchar (2),
TP_CONVENIO_PODER_PUBLICO varchar (15),
IN_MANT_ESCOLA_PRIVADA_EMP varchar (2),
IN_MANT_ESCOLA_PRIVADA_ONG varchar (2),
IN_MANT_ESCOLA_PRIVADA_SIND varchar (2),
IN_MANT_ESCOLA_PRIVADA_SIST_S varchar (2),
IN_MANT_ESCOLA_PRIVADA_S_FINS varchar (2),
TP_REGULAMENTACAO varchar (15),
TP_LOCALIZACAO_DIFERENCIADA varchar (15),
IN_EDUCACAO_INDIGENA varchar (2)
);

/* 
    Dados de docentes obtidos junto ao INEP
    são carregados na tabela SC_2017_DOCENTE.
*/    
load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/DOCENTES_CO.CSV'
into table SC_2017_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/DOCENTES_NORDESTE.CSV'
into table SC_2017_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/DOCENTES_NORTE.CSV'
into table SC_2017_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/DOCENTES_SUDESTE.CSV'
into table SC_2017_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/DOCENTES_SUL.CSV'
into table SC_2017_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;