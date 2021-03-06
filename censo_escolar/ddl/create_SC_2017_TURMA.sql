use dataviva_raw;

/* 
    Tabela SC_2017_TURMA é removida, caso exista. 
    Uma nova tabela SC_2017_TURMA é criada.
*/
drop table if exists SC_2017_TURMA;
create table SC_2017_TURMA(
NU_ANO_CENSO varchar (5),
ID_TURMA varchar (15),
NO_TURMA varchar (200),
TX_HR_INICIAL varchar (50),
TX_MI_INICIAL varchar (50),
NU_DURACAO_TURMA varchar (10),
NU_MATRICULAS varchar (10),
TP_MEDIACAO_DIDATICO_PEDAGO varchar (10),
IN_ESPECIAL_EXCLUSIVA varchar (2),
IN_REGULAR varchar (2),
IN_EJA varchar (2),
IN_PROFISSIONALIZANTE varchar (2),
TP_ETAPA_ENSINO varchar (10),
CO_CURSO_EDUC_PROFISSIONAL varchar (50),
TP_TIPO_TURMA varchar (15),
IN_MAIS_EDUCACAO varchar (2),
NU_DIAS_ATIVIDADE varchar (10),
IN_DIA_SEMANA_DOMINGO varchar (2),
IN_DIA_SEMANA_SEGUNDA varchar (2),
IN_DIA_SEMANA_TERCA varchar (2),
IN_DIA_SEMANA_QUARTA varchar (2),
IN_DIA_SEMANA_QUINTA varchar (2),
IN_DIA_SEMANA_SEXTA varchar (2),
IN_DIA_SEMANA_SABADO varchar (2),
CO_TIPO_ATIVIDADE_1 varchar (15),
CO_TIPO_ATIVIDADE_2 varchar (15),
CO_TIPO_ATIVIDADE_3 varchar (15),
CO_TIPO_ATIVIDADE_4 varchar (15),
CO_TIPO_ATIVIDADE_5 varchar (15),
CO_TIPO_ATIVIDADE_6 varchar (15),
IN_BRAILLE varchar (2),
IN_RECURSOS_BAIXA_VISAO varchar (2),
IN_PROCESSOS_MENTAIS varchar (2),
IN_ORIENTACAO_MOBILIDADE varchar (2),
IN_SINAIS varchar (2),
IN_COMUNICACAO_ALT_AUMENT varchar (2),
IN_ENRIQ_CURRICULAR varchar (2),
IN_SOROBAN varchar (2),
IN_INFORMATICA_ACESSIVEL varchar (2),
IN_PORT_ESCRITA varchar (2),
IN_AUTONOMIA_ESCOLAR varchar (2),
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
CO_ENTIDADE varchar (50),
CO_REGIAO varchar (10),
CO_MESORREGIAO varchar (10),
CO_MICRORREGIAO varchar (10),
CO_UF varchar (2),
CO_MUNICIPIO varchar (9),
CO_DISTRITO varchar (9),
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
    Dados de turmas obtidos junto ao INEP
    são carregados na tabela SC_2017_TURMA.
*/
load data local infile '/home/dev1/Documents/ETL/Escolar/Microdados_Censo_Escolar_2017/DADOS/TURMAS.CSV'
into table SC_2017_TURMA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;
