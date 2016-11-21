use dataviva_raw;

create table SC_2008_DOCENTE_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_AC.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_AL.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_AM.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_AP.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_BA.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_CE.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_DF.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_ES.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_GO.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_MA.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_MG.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_MS.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_MT.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_PA.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_PB.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_PE.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_PI.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_PR.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_RJ.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_RN.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_RO.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_RR.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_RS.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_SC.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_SE.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_SP.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_DOCENTES_TO.txt'
into table SC_2008_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2008_DOCENTE;
create table SC_2008_DOCENTE select 
substring(dados,1,7) as ANO_CENSO,
substring(dados,8,15) as FK_COD_DOCENTE,
substring(dados,23,5) as NU_DIA,
substring(dados,28,5) as NU_MES,
substring(dados,33,7) as NU_ANO,
substring(dados,40,5) as NUM_IDADE,
substring(dados,45,1) as TP_SEXO,
substring(dados,46,1) as TP_COR_RACA,
substring(dados,47,1) as TP_NACIONALIDADE,
substring(dados,48,6) as FK_COD_PAIS_ORIGEM,
substring(dados,54,5) as FK_COD_ESTADO_DNASC,
substring(dados,59,2) as SIGLA_ESTADO_DNASC,
substring(dados,61,15) as FK_COD_MUNICIPIO_DNASC,
substring(dados,76,5) as FK_COD_ESTADO_DEND,
substring(dados,81,2) as SIGLA_ESTADO_DEND,
substring(dados,83,15) as FK_COD_MUNICIPIO_DEND,
substring(dados,98,5) as FK_COD_ESCOLARIDADE,
substring(dados,103,5) as FK_CLASSE_CURSO_1,
substring(dados,108,6) as PK_COD_AREA_OCDE_1,
substring(dados,114,3) as ID_LICENCIATURA_1,
substring(dados,117,6) as NU_ANO_CONCLUSAO_1,
substring(dados,123,3) as ID_TIPO_INSTITUICAO_1,
substring(dados,126,100) as ID_NOME_IES_1,
substring(dados,226,9) as FK_COD_IES_1,
substring(dados,235,5) as FK_CLASSE_CURSO_2,
substring(dados,240,6) as PK_COD_AREA_OCDE_2,
substring(dados,246,3) as ID_LICENCIATURA_2,
substring(dados,249,6) as NU_ANO_CONCLUSAO_2,
substring(dados,255,3) as ID_TIPO_INSTITUICAO_2,
substring(dados,258,100) as ID_NOME_IES_2,
substring(dados,358,9) as FK_COD_IES_2,
substring(dados,367,5) as FK_CLASSE_CURSO_3,
substring(dados,372,6) as PK_COD_AREA_OCDE_3,
substring(dados,378,3) as ID_LICENCIATURA_3,
substring(dados,381,6) as NU_ANO_CONCLUSAO_3,
substring(dados,387,3) as ID_TIPO_INSTITUICAO_3,
substring(dados,390,100) as ID_NOME_IES_3,
substring(dados,490,9) as FK_COD_IES_3,
substring(dados,499,1) as ID_QUIMICA,
substring(dados,500,1) as ID_FISICA,
substring(dados,501,1) as ID_MATEMATICA,
substring(dados,502,1) as ID_BIOLOGIA,
substring(dados,503,1) as ID_CIENCIAS,
substring(dados,504,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,505,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,506,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,507,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,508,1) as ID_ARTES,
substring(dados,509,1) as ID_EDUCACAO_FISICA,
substring(dados,510,1) as ID_HISTORIA,
substring(dados,511,1) as ID_GEOGRAFIA,
substring(dados,512,1) as ID_FILOSOFIA,
substring(dados,513,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,514,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,515,1) as ID_PROFISSIONALIZANTE,
substring(dados,516,1) as ID_DIDATICA_METODOLOGIA,
substring(dados,517,1) as ID_FUNDAMENTOS_EDUCACAO,
substring(dados,518,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,519,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,520,1) as ID_OUTRAS_DISCIPLINAS_PEDAG,
substring(dados,521,1) as ID_LIBRAS,
substring(dados,522,1) as ID_ESPECIALIZACAO,
substring(dados,523,1) as ID_MESTRADO,
substring(dados,524,1) as ID_DOUTORADO,
substring(dados,525,1) as ID_POS_GRADUACAO_NENHUM,
substring(dados,526,1) as ID_ESPECIFICO_CRECHE,
substring(dados,527,1) as ID_ESPECIFICO_PRE_ESCOLA,
substring(dados,528,1) as ID_ESPECIFICO_NEC_ESP,
substring(dados,529,1) as ID_ESPECIFICO_ED_INDIGENA,
substring(dados,530,1) as ID_INTERCULTURAL_OUTROS,
substring(dados,531,1) as ID_ESPECIFICO_NENHUM,
substring(dados,532,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,533,1) as ID_TIPO_DOCENTE,
substring(dados,534,13) as PK_COD_TURMA,
substring(dados,547,5) as FK_TIPO_TURMA,
substring(dados,552,5) as FK_COD_MOD_ENSINO,
substring(dados,557,5) as FK_COD_ETAPA_ENSINO,
substring(dados,562,10) as FK_COD_CURSO_PROF,
substring(dados,572,11) as PK_COD_ENTIDADE,
substring(dados,583,5) as FK_COD_ESTADO,
substring(dados,588,2) as SIGLA,
substring(dados,590,15) as FK_COD_MUNICIPIO,
substring(dados,605,1) as ID_LOCALIZACAO,
substring(dados,606,1) as ID_DEPENDENCIA_ADM,
substring(dados,607,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,608,1) as ID_CONVENIADA_PP,
substring(dados,609,1) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,610,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,611,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,612,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,613,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,614,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,615,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,616,1) as ID_EDUCACAO_INDIGENA
from SC_2008_DOCENTE_BLOCO;

select * from SC_2008_DOCENTE;

drop table SC_2008_DOCENTE_BLOCO;

