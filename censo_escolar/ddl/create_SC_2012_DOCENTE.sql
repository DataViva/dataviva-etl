use dataviva_raw;

create table SC_2012_DOCENTE_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_AC.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_AL.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_AM.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_AP.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_BA.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_CE.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_DF.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_ES.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_GO.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_MA.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_MG.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_MS.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_MT.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_PA.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_PB.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_PE.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_PI.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_PR.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_RJ.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_RN.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_RO.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_RR.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_RS.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_SC.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_SE.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_SP.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_DOCENTES_TO.txt'
into table SC_2012_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2012_DOCENTE;
create table SC_2012_DOCENTE select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,13) as FK_COD_DOCENTE,
substring(dados,19,3) as NU_DIA,
substring(dados,22,3) as NU_MES,
substring(dados,25,5) as NU_ANO,
substring(dados,30,4) as NUM_IDADE,
substring(dados,34,1) as TP_SEXO,
substring(dados,35,1) as TP_COR_RACA,
substring(dados,36,1) as TP_NACIONALIDADE,
substring(dados,37,4) as FK_COD_PAIS_ORIGEM,
substring(dados,41,3) as FK_COD_ESTADO_DNASC,
substring(dados,44,2) as SIGLA_ESTADO_DNASC,
substring(dados,46,9) as FK_COD_MUNICIPIO_DNASC,
substring(dados,55,3) as FK_COD_ESTADO_DEND,
substring(dados,58,2) as SIGLA_ESTADO_DEND,
substring(dados,60,9) as FK_COD_MUNICIPIO_DEND,
substring(dados,69,2) as ID_ZONA_RESIDENCIAL,
substring(dados,71,2) as ID_POSSUI_NEC_ESPECIAL,
substring(dados,73,2) as ID_CEGUEIRA,
substring(dados,75,2) as ID_BAIXA_VISAO,
substring(dados,77,2) as ID_SURDEZ,
substring(dados,79,2) as ID_DEF_AUDITIVA,
substring(dados,81,2) as ID_SURDOCEGUEIRA,
substring(dados,83,2) as ID_DEF_FISICA,
substring(dados,85,2) as ID_DEF_INTELECTUAL,
substring(dados,87,2) as ID_DEF_MULTIPLA,
substring(dados,89,2) as FK_COD_ESCOLARIDADE,
substring(dados,91,1) as ID_SITUACAO_CURSO_1,
substring(dados,92,3) as FK_CLASSE_CURSO_1,
substring(dados,95,6) as FK_COD_AREA_OCDE_1,
substring(dados,101,2) as ID_LICENCIATURA_1,
substring(dados,103,2) as ID_COM_PEDAGOGICA_1,
substring(dados,105,5) as NU_ANO_INICIO_1,
substring(dados,110,5) as NU_ANO_CONCLUSAO_1,
substring(dados,115,2) as ID_TIPO_INSTITUICAO_1,
substring(dados,117,100) as ID_NOME_INSTITUICAO_1,
substring(dados,217,9) as FK_COD_IES_1,
substring(dados,226,1) as ID_SITUACAO_CURSO_2,
substring(dados,227,4) as FK_CLASSE_CURSO_2,
substring(dados,231,6) as FK_COD_AREA_OCDE_2,
substring(dados,237,2) as ID_LICENCIATURA_2,
substring(dados,239,2) as ID_COM_PEDAGOGICA_2,
substring(dados,241,5) as NU_ANO_INICIO_2,
substring(dados,246,5) as NU_ANO_CONCLUSAO_2,
substring(dados,251,2) as ID_TIPO_INSTITUICAO_2,
substring(dados,253,100) as ID_NOME_INSTITUICAO_2,
substring(dados,353,9) as FK_COD_IES_2,
substring(dados,362,1) as ID_SITUACAO_CURSO_3,
substring(dados,363,4) as FK_CLASSE_CURSO_3,
substring(dados,367,6) as FK_COD_AREA_OCDE_3,
substring(dados,373,2) as ID_LICENCIATURA_3,
substring(dados,375,2) as ID_COM_PEDAGOGICA_3,
substring(dados,377,5) as NU_ANO_INICIO_3,
substring(dados,382,5) as NU_ANO_CONCLUSAO_3,
substring(dados,387,2) as ID_TIPO_INSTITUICAO_3,
substring(dados,389,100) as ID_NOME_INSTITUICAO_3,
substring(dados,489,9) as FK_COD_IES_3,
substring(dados,498,1) as ID_QUIMICA,
substring(dados,499,1) as ID_FISICA,
substring(dados,500,1) as ID_MATEMATICA,
substring(dados,501,1) as ID_BIOLOGIA,
substring(dados,502,1) as ID_CIENCIAS,
substring(dados,503,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,504,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,505,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,506,1) as ID_LINGUA_LITERAT_FRANCES,
substring(dados,507,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,508,1) as ID_LINGUA_LITERAT_INDIGENA,
substring(dados,509,1) as ID_ARTES,
substring(dados,510,1) as ID_EDUCACAO_FISICA,
substring(dados,511,1) as ID_HISTORIA,
substring(dados,512,1) as ID_GEOGRAFIA,
substring(dados,513,1) as ID_FILOSOFIA,
substring(dados,514,1) as ID_ENSINO_RELIGIOSO,
substring(dados,515,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,516,1) as ID_SOCIOLOGIA,
substring(dados,517,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,518,1) as ID_PROFISSIONALIZANTE,
substring(dados,519,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,520,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,521,1) as ID_LIBRAS,
substring(dados,522,1) as ID_DISCIPLINAS_PEDAG,
substring(dados,523,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,524,1) as ID_ESPECIALIZACAO,
substring(dados,525,1) as ID_MESTRADO,
substring(dados,526,1) as ID_DOUTORADO,
substring(dados,527,1) as ID_POS_GRADUACAO_NENHUM,
substring(dados,528,1) as ID_ESPECIFICO_CRECHE,
substring(dados,529,1) as ID_ESPECIFICO_PRE_ESCOLA,
substring(dados,530,1) as ID_ESPECIFICO_ANOS_INICIAIS,
substring(dados,531,1) as ID_ESPECIFICO_ANOS_FINAIS,
substring(dados,532,1) as ID_ESPECIFICO_ENS_MEDIO,
substring(dados,533,1) as ID_ESPECIFICO_EJA,
substring(dados,534,1) as ID_ESPECIFICO_NEC_ESP,
substring(dados,535,1) as ID_ESPECIFICO_ED_INDIGENA,
substring(dados,536,1) as ID_ESPECIFICO_CAMPO,
substring(dados,537,1) as ID_ESPECIFICO_AMBIENTAL,
substring(dados,538,1) as ID_ESPECIFICO_DIR_HUMANOS,
substring(dados,539,1) as ID_ESPECIFICO_DIV_SEXUAL,
substring(dados,540,1) as ID_ESPECIFICO_DIR_ADOLESC,
substring(dados,541,1) as ID_ESPECIFICO_AFRO,
substring(dados,542,1) as ID_ESPECIFICO_OUTROS,
substring(dados,543,1) as ID_ESPECIFICO_NENHUM,
substring(dados,544,1) as ID_TIPO_DOCENTE,
substring(dados,545,1) as ID_TIPO_CONTRATACAO,
substring(dados,546,11) as PK_COD_TURMA,
substring(dados,557,3) as FK_COD_TIPO_TURMA,
substring(dados,560,3) as FK_COD_MOD_ENSINO,
substring(dados,563,4) as FK_COD_ETAPA_ENSINO,
substring(dados,567,9) as FK_COD_CURSO_PROF,
substring(dados,576,9) as PK_COD_ENTIDADE,
substring(dados,585,3) as FK_COD_ESTADO,
substring(dados,588,2) as SIGLA,
substring(dados,590,9) as FK_COD_MUNICIPIO,
substring(dados,599,9) as FK_COD_DISTRITO,
substring(dados,608,1) as ID_LOCALIZACAO,
substring(dados,609,1) as ID_DEPENDENCIA_ADM,
substring(dados,610,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,611,1) as ID_CONVENIADA_PP,
substring(dados,612,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,614,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,615,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,616,1) as ID_MANT_ESCOLA_PRIVADA_SIST_S,
substring(dados,617,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,618,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,619,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,620,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,621,1) as ID_EDUCACAO_INDIGENA
from SC_2012_DOCENTE_BLOCO;

select * from SC_2012_DOCENTE;

drop table SC_2012_DOCENTE_BLOCO;

