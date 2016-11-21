use dataviva_raw;

drop table if exists SC_2014_DOCENTE;
create table SC_2014_DOCENTE(
ANO_CENSO varchar(5),
FK_COD_DOCENTE varchar(13),
NU_DIA varchar(3),
NU_MES varchar(3),
NU_ANO varchar(5),
NUM_IDADE_REF_DOCENTE integer(4),
NUM_IDADE integer(4),
TP_SEXO varchar(1),
TP_COR_RACA varchar(1),
TP_NACIONALIDADE varchar(1),
FK_COD_PAIS_ORIGEM varchar(4),
FK_COD_ESTADO_DNASC varchar(3),
FK_COD_MUNICIPIO_DNASC varchar(9),
FK_COD_ESTADO_DEND varchar(3),
FK_COD_MUNICIPIO_DEND varchar(9),
ID_ZONA_RESIDENCIAL varchar(2),
ID_POSSUI_NEC_ESPECIAL varchar(2),
ID_CEGUEIRA varchar(2),
ID_BAIXA_VISAO varchar(2),
ID_SURDEZ varchar(2),
ID_DEF_AUDITIVA varchar(2),
ID_SURDOCEGUEIRA varchar(2),
ID_DEF_FISICA varchar(2),
ID_DEF_INTELECTUAL varchar(2),
ID_DEF_MULTIPLA varchar(2),
FK_COD_ESCOLARIDADE varchar(2),
ID_SITUACAO_CURSO_1 varchar(1),
FK_CLASSE_CURSO_1 varchar(3),
FK_COD_AREA_OCDE_1 varchar(6),
ID_LICENCIATURA_1 varchar(2),
ID_COM_PEDAGOGICA_1 varchar(2),
NU_ANO_INICIO_1 varchar(5),
NU_ANO_CONCLUSAO_1 varchar(5),
ID_TIPO_INSTITUICAO_1 varchar(2),
ID_NOME_INSTITUICAO_1 varchar(100),
FK_COD_IES_1 varchar(9),
ID_SITUACAO_CURSO_2 varchar(1),
FK_CLASSE_CURSO_2 varchar(4),
FK_COD_AREA_OCDE_2 varchar(6),
ID_LICENCIATURA_2 varchar(2),
ID_COM_PEDAGOGICA_2 varchar(2),
NU_ANO_INICIO_2 varchar(5),
NU_ANO_CONCLUSAO_2 varchar(5),
ID_TIPO_INSTITUICAO_2 varchar(2),
ID_NOME_INSTITUICAO_2 varchar(100),
FK_COD_IES_2 varchar(9),
ID_SITUACAO_CURSO_3 varchar(1),
FK_CLASSE_CURSO_3 varchar(4),
FK_COD_AREA_OCDE_3 varchar(6),
ID_LICENCIATURA_3 varchar(2),
ID_COM_PEDAGOGICA_3 varchar(2),
NU_ANO_INICIO_3 varchar(5),
NU_ANO_CONCLUSAO_3 varchar(5),
ID_TIPO_INSTITUICAO_3 varchar(2),
ID_NOME_INSTITUICAO_3 varchar(100),
FK_COD_IES_3 varchar(9),
ID_QUIMICA varchar(1),
ID_FISICA varchar(1),
ID_MATEMATICA varchar(1),
ID_BIOLOGIA varchar(1),
ID_CIENCIAS varchar(1),
ID_LINGUA_LITERAT_PORTUGUESA varchar(1),
ID_LINGUA_LITERAT_INGLES varchar(1),
ID_LINGUA_LITERAT_ESPANHOL varchar(1),
ID_LINGUA_LITERAT_FRANCES varchar(1),
ID_LINGUA_LITERAT_OUTRA varchar(1),
ID_LINGUA_LITERAT_INDIGENA varchar(1),
ID_ARTES varchar(1),
ID_EDUCACAO_FISICA varchar(1),
ID_HISTORIA varchar(1),
ID_GEOGRAFIA varchar(1),
ID_FILOSOFIA varchar(1),
ID_ENSINO_RELIGIOSO varchar(1),
ID_ESTUDOS_SOCIAIS varchar(1),
ID_SOCIOLOGIA varchar(1),
ID_INFORMATICA_COMPUTACAO varchar(1),
ID_PROFISSIONALIZANTE varchar(1),
ID_DISC_ATENDIMENTO_ESPECIAIS varchar(1),
ID_DISC_DIVERSIDADE_SOCIO_CULT varchar(1),
ID_LIBRAS varchar(1),
ID_DISCIPLINAS_PEDAG varchar(1),
ID_OUTRAS_DISCIPLINAS varchar(1),
ID_ESPECIALIZACAO varchar(1),
ID_MESTRADO varchar(1),
ID_DOUTORADO varchar(1),
ID_POS_GRADUACAO_NENHUM varchar(1),
ID_ESPECIFICO_CRECHE varchar(1),
ID_ESPECIFICO_PRE_ESCOLA varchar(1),
ID_ESPECIFICO_ANOS_INICIAIS varchar(1),
ID_ESPECIFICO_ANOS_FINAIS varchar(1),
ID_ESPECIFICO_ENS_MEDIO varchar(1),
ID_ESPECIFICO_EJA varchar(1),
ID_ESPECIFICO_NEC_ESP varchar(1),
ID_ESPECIFICO_ED_INDIGENA varchar(1),
ID_ESPECIFICO_CAMPO varchar(1),
ID_ESPECIFICO_AMBIENTAL varchar(1),
ID_ESPECIFICO_DIR_HUMANOS varchar(1),
ID_ESPECIFICO_DIV_SEXUAL varchar(1),
ID_ESPECIFICO_DIR_ADOLESC varchar(1),
ID_ESPECIFICO_AFRO varchar(1),
ID_ESPECIFICO_OUTROS varchar(1),
ID_ESPECIFICO_NENHUM varchar(1),
ID_TIPO_DOCENTE varchar(1),
ID_TIPO_CONTRATACAO varchar(1),
PK_COD_TURMA varchar(11),
FK_COD_TIPO_TURMA varchar(3),
FK_COD_MOD_ENSINO varchar(3),
FK_COD_ETAPA_ENSINO varchar(4),
FK_COD_CURSO_PROF varchar(9),
PK_COD_ENTIDADE varchar(9),
FK_COD_ESTADO varchar(3),
FK_COD_MUNICIPIO varchar(9),
FK_COD_DISTRITO varchar(9),
ID_LOCALIZACAO varchar(1),
ID_DEPENDENCIA_ADM varchar(1),
DESC_CATEGORIA_ESCOLA_PRIVADA varchar(1),
ID_CONVENIADA_PP varchar(1),
ID_TIPO_CONVENIO_PODER_PUBLICO varchar(2),
ID_MANT_ESCOLA_PRIVADA_EMP varchar(1),
ID_MANT_ESCOLA_PRIVADA_ONG varchar(1),
ID_MANT_ESCOLA_PRIVADA_SIND varchar(1),
ID_MANT_ESCOLA_PRIVADA_SIST_S varchar(1),
ID_MANT_ESCOLA_PRIVADA_S_FINS varchar(1),
ID_DOCUMENTO_REGULAMENTACAO varchar(1),
ID_LOCALIZACAO_DIFERENCIADA varchar(1),
ID_EDUCACAO_INDIGENA varchar(5)
);

load data local infile 'Y:/Censo Escolar/2014/DADOS/DOCENTES_CO.csv'
into table SC_2014_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/DOCENTES_NORDESTE.csv'
into table SC_2014_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/DOCENTES_NORTE.csv'
into table SC_2014_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/DOCENTES_SUDESTE.csv'
into table SC_2014_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/DOCENTES_SUL.csv'
into table SC_2014_DOCENTE
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


select * from SC_2014_DOCENTE;

