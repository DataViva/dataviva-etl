use dataviva_raw;

drop table if exists SC_2014_MATRICULA;
create table SC_2014_MATRICULA(
ANO_CENSO varchar(5),
PK_COD_MATRICULA varchar(13),
FK_COD_ALUNO varchar(14),
NU_DIA varchar(3),
NU_MES varchar(3),
NU_ANO varchar(5),
NUM_IDADE_REFERENCIA integer(5),
NUM_IDADE integer(4),
NU_DUR_ESCOLARIZACAO varchar(6),
NU_DUR_ATIV_COMP_MESMA_REDE varchar(6),
NU_DUR_ATIV_COMP_OUTRAS_REDES varchar(6),
NUM_DUR_AEE_MESMA_REDE varchar(6),
NUM_DUR_AEE_OUTRAS_REDES varchar(6),
TP_SEXO varchar(1),
TP_COR_RACA varchar(1),
TP_NACIONALIDADE varchar(1),
FK_COD_PAIS_ORIGEM varchar(4),
FK_COD_ESTADO_NASC varchar(3),
FK_COD_MUNICIPIO_DNASC varchar(9),
FK_COD_ESTADO_END varchar(3),
FK_COD_MUNICIPIO_END varchar(9),
ID_ZONA_RESIDENCIAL varchar(1),
ID_TIPO_ATENDIMENTO varchar(1),
ID_N_T_E_P varchar(1),
ID_RESPONSAVEL_TRANSPORTE varchar(1),
ID_TRANSP_VANS_KOMBI varchar(1),
ID_TRANSP_MICRO_ONIBUS varchar(1),
ID_TRANSP_ONIBUS varchar(1),
ID_TRANSP_BICICLETA varchar(1),
ID_TRANSP_TR_ANIMAL varchar(1),
ID_TRANSP_OUTRO_VEICULO varchar(1),
ID_TRANSP_EMBAR_ATE5 varchar(1),
ID_TRANSP_EMBAR_5A15 varchar(1),
ID_TRANSP_EMBAR_15A35 varchar(1),
ID_TRANSP_EMBAR_35 varchar(1),
ID_TRANSP_TREM_METRO varchar(1),
ID_POSSUI_NEC_ESPECIAL varchar(1),
ID_TIPO_NEC_ESP_CEGUEIRA varchar(1),
ID_TIPO_NEC_ESP_BAIXA_VISAO varchar(1),
ID_TIPO_NEC_ESP_SURDEZ varchar(1),
ID_TIPO_NEC_ESP_DEF_AUDITIVA varchar(1),
ID_TIPO_NEC_ESP_SURDO_CEGUEIRA varchar(1),
ID_TIPO_NEC_ESP_DEF_FISICA varchar(1),
ID_TIPO_NEC_ESP_DEF_MENTAL varchar(1),
ID_TIPO_NEC_ESP_DEF_MULTIPLAS varchar(1),
ID_TIPO_NEC_ESP_AUTISMO varchar(1),
ID_TIPO_NEC_ESP_ASPERGER varchar(1),
ID_TIPO_NEC_ESP_RETT varchar(1),
ID_TIPO_NEC_ESP_TDI varchar(1),
ID_TIPO_NEC_ESP_SUPERDOTACAO varchar(1),
ID_TIPO_REC_ESP_LEDOR varchar(1),
ID_TIPO_REC_ESP_TRANSCRICAO varchar(1),
ID_TIPO_REC_ESP_INTERPRETE varchar(1),
ID_TIPO_REC_ESP_LIBRAS varchar(1),
ID_TIPO_REC_ESP_LABIAL varchar(1),
ID_TIPO_REC_ESP_BRAILLE varchar(1),
ID_TIPO_REC_ESP_AMPLIADA_16 varchar(1),
ID_TIPO_REC_ESP_AMPLIADA_20 varchar(1),
ID_TIPO_REC_ESP_AMPLIADA_24 varchar(1),
ID_TIPO_REC_ESP_NENHUM varchar(1),
ID_INGRESSO_FEDERAIS varchar(1),
FK_COD_MOD_ENSINO varchar(3),
FK_COD_ETAPA_ENSINO varchar(4),
ID_ETAPA_AGREGADA_MAT varchar(2),
PK_COD_TURMA varchar(11),
FK_COD_CURSO_PROF varchar(9),
COD_UNIFICADA varchar(2),
FK_COD_TIPO_TURMA varchar(3),
PK_COD_ENTIDADE varchar(9),
FK_COD_ESTADO_ESCOLA varchar(3),
COD_MUNICIPIO_ESCOLA varchar(9),
FK_CODIGO_DISTRITO varchar(9),
ID_LOCALIZACAO_ESC varchar(1),
ID_DEPENDENCIA_ADM_ESC varchar(1),
DESC_CATA_ESCOLA_PRIV varchar(1),
ID_CONVENIADA_PP_ESC varchar(1),
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

load data local infile 'Y:/Censo Escolar/2014/DADOS/MATRICULA_CO.csv'
into table SC_2014_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/MATRICULA_NORDESTE.csv'
into table SC_2014_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/MATRICULA_NORTE.csv'
into table SC_2014_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/MATRICULA_SUDESTE.csv'
into table SC_2014_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;

load data local infile 'Y:/Censo Escolar/2014/DADOS/MATRICULA_SUL.csv'
into table SC_2014_MATRICULA
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;


select * from SC_2014_DOCENTE;

