use dataviva_raw;

create table SC_2011_DOCENTE_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_AC.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_AL.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_AM.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_AP.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_BA.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_CE.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_DF.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_ES.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_GO.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_MA.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_MG.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_MS.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_MT.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_PA.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_PB.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_PE.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_PI.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_PR.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_RJ.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_RN.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_RO.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_RR.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_RS.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_SC.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_SE.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_SP.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_DOCENTES_TO.txt'
into table SC_2011_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2011_DOCENTE;
create table SC_2011_DOCENTE select 
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
substring(dados,46,8) as FK_COD_MUNICIPIO_DNASC,
substring(dados,54,3) as FK_COD_ESTADO_DEND,
substring(dados,57,2) as SIGLA_ESTADO_DEND,
substring(dados,59,8) as FK_COD_MUNICIPIO_DEND,
substring(dados,67,2) as FK_COD_ESCOLARIDADE,
substring(dados,69,1) as ID_SITUACAO_CURSO_1,
substring(dados,70,4) as FK_CLASSE_CURSO_1,
substring(dados,74,6) as FK_COD_AREA_OCDE_1,
substring(dados,80,2) as ID_LICENCIATURA_1,
substring(dados,82,2) as ID_COM_PEDAGOGICA_1,
substring(dados,84,5) as NU_ANO_INICIO_1,
substring(dados,89,5) as NU_ANO_CONCLUSAO_1,
substring(dados,94,2) as ID_TIPO_INSTITUICAO_1,
substring(dados,96,100) as ID_NOME_INSTITUICAO_1,
substring(dados,196,9) as FK_COD_IES_1,
substring(dados,205,1) as ID_SITUACAO_CURSO_2,
substring(dados,206,4) as FK_CLASSE_CURSO_2,
substring(dados,210,6) as FK_COD_AREA_OCDE_2,
substring(dados,216,2) as ID_LICENCIATURA_2,
substring(dados,218,2) as ID_COM_PEDAGOGICA_2,
substring(dados,220,5) as NU_ANO_INICIO_2,
substring(dados,225,5) as NU_ANO_CONCLUSAO_2,
substring(dados,230,2) as ID_TIPO_INSTITUICAO_2,
substring(dados,232,100) as ID_NOME_INSTITUICAO_2,
substring(dados,332,9) as FK_COD_IES_2,
substring(dados,341,1) as ID_SITUACAO_CURSO_3,
substring(dados,342,4) as FK_CLASSE_CURSO_3,
substring(dados,346,6) as FK_COD_AREA_OCDE_3,
substring(dados,352,2) as ID_LICENCIATURA_3,
substring(dados,354,2) as ID_COM_PEDAGOGIAC_3,
substring(dados,356,5) as NU_ANO_INICIO_3,
substring(dados,361,5) as NU_ANO_CONCLUSAO_3,
substring(dados,366,2) as ID_TIPO_INSTITUICAO_3,
substring(dados,368,100) as ID_NOME_INSTITUICAO_3,
substring(dados,468,9) as FK_COD_IES_3,
substring(dados,477,1) as ID_QUIMICA,
substring(dados,478,1) as ID_FISICA,
substring(dados,479,1) as ID_MATEMATICA,
substring(dados,480,1) as ID_BIOLOGIA,
substring(dados,481,1) as ID_CIENCIAS,
substring(dados,482,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,483,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,484,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,485,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,486,1) as ID_LINGUA_LITERAT_INDIGENA,
substring(dados,487,1) as ID_ARTES,
substring(dados,488,1) as ID_EDUCACAO_FISICA,
substring(dados,489,1) as ID_HISTORIA,
substring(dados,490,1) as ID_GEOGRAFIA,
substring(dados,491,1) as ID_FILOSOFIA,
substring(dados,492,1) as ID_ENSINO_RELIGIOSO,
substring(dados,493,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,494,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,495,1) as ID_PROFISSIONALIZANTE,
substring(dados,496,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,497,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,498,1) as ID_LIBRAS,
substring(dados,499,1) as ID_DISCIPLINAS_PEDAG,
substring(dados,500,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,501,1) as ID_ESPECIALIZACAO,
substring(dados,502,1) as ID_MESTRADO,
substring(dados,503,1) as ID_DOUTORADO,
substring(dados,504,1) as ID_POS_GRADUACAO_NENHUM,
substring(dados,505,1) as ID_ESPECIFICO_CRECHE,
substring(dados,506,1) as ID_ESPECIFICO_PRE_ESCOLA,
substring(dados,507,1) as ID_ESPECIFICO_ANOS_INICIAIS,
substring(dados,508,1) as ID_ESPECIFICO_ANOS_FINAIS,
substring(dados,509,1) as ID_ESPECIFICO_ENS_MEDIO,
substring(dados,510,1) as ID_ESPECIFICO_EJA,
substring(dados,511,1) as ID_ESPECIFICO_NEC_ESP,
substring(dados,512,1) as ID_ESPECIFICO_ED_INDIGENA,
substring(dados,513,1) as ID_INTERCULTURAL_OUTROS,
substring(dados,514,1) as ID_ESPECIFICO_OUTROS,
substring(dados,515,1) as ID_ESPECIFICO_NENHUM,
substring(dados,516,1) as ID_TIPO_DOCENTE,
substring(dados,517,1) as ID_TIPO_CONTRATACAO,
substring(dados,518,11) as PK_COD_TURMA,
substring(dados,529,3) as FK_COD_TIPO_TURMA,
substring(dados,532,3) as FK_COD_MOD_ENSINO,
substring(dados,535,4) as FK_COD_ETAPA_ENSINO,
substring(dados,539,9) as FK_COD_CURSO_PROF,
substring(dados,548,9) as PK_COD_ENTIDADE,
substring(dados,557,3) as FK_COD_ESTADO,
substring(dados,560,2) as SIGLA,
substring(dados,562,8) as FK_COD_MUNICIPIO,
substring(dados,570,8) as FK_COD_DISTRITO,
substring(dados,578,1) as ID_LOCALIZACAO,
substring(dados,579,1) as ID_DEPENDENCIA_ADM,
substring(dados,580,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,581,1) as ID_CONVENIADA_PP,
substring(dados,582,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,584,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,585,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,586,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,587,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,588,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,589,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,590,1) as ID_EDUCACAO_INDIGENA
from SC_2011_DOCENTE_BLOCO;

select * from SC_2011_DOCENTE;

drop table SC_2011_DOCENTE_BLOCO;

