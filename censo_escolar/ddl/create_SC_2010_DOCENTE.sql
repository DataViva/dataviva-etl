use dataviva_raw;

create table SC_2010_DOCENTE_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_AC.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_AL.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_AM.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_AP.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_BA.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_CE.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_DF.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_ES.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_GO.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_MA.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_MG.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_MS.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_MT.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_PA.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_PB.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_PE.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_PI.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_PR.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_RJ.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_RN.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_RO.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_RR.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_RS.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_SC.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_SE.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_SP.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_DOCENTES_TO.txt'
into table SC_2010_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2010_DOCENTE;
create table SC_2010_DOCENTE select 
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
substring(dados,69,4) as FK_CLASSE_CURSO_1,
substring(dados,73,6) as FK_COD_AREA_OCDE_1,
substring(dados,79,2) as ID_LICENCIATURA_1,
substring(dados,81,5) as NU_ANO_CONCLUSAO_1,
substring(dados,86,2) as ID_TIPO_INSTITUICAO_1,
substring(dados,88,100) as ID_NOME_INSTITUICAO_1,
substring(dados,188,9) as FK_COD_IES_1,
substring(dados,197,4) as FK_CLASSE_CURSO_2,
substring(dados,201,6) as FK_COD_AREA_OCDE_2,
substring(dados,207,2) as ID_LICENCIATURA_2,
substring(dados,209,5) as NU_ANO_CONCLUSAO_2,
substring(dados,214,2) as ID_TIPO_INSTITUICAO_2,
substring(dados,216,100) as ID_NOME_INSTITUICAO_2,
substring(dados,316,9) as FK_COD_IES_2,
substring(dados,325,4) as FK_CLASSE_CURSO_3,
substring(dados,329,6) as FK_COD_AREA_OCDE_3,
substring(dados,335,2) as ID_LICENCIATURA_3,
substring(dados,337,5) as NU_ANO_CONCLUSAO_3,
substring(dados,342,2) as ID_TIPO_INSTITUICAO_3,
substring(dados,344,100) as ID_NOME_INSTITUICAO_3,
substring(dados,444,9) as FK_COD_IES_3,
substring(dados,453,1) as ID_QUIMICA,
substring(dados,454,1) as ID_FISICA,
substring(dados,455,1) as ID_MATEMATICA,
substring(dados,456,1) as ID_BIOLOGIA,
substring(dados,457,1) as ID_CIENCIAS,
substring(dados,458,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,459,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,460,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,461,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,462,1) as ID_ARTES,
substring(dados,463,1) as ID_EDUCACAO_FISICA,
substring(dados,464,1) as ID_HISTORIA,
substring(dados,465,1) as ID_GEOGRAFIA,
substring(dados,466,1) as ID_FILOSOFIA,
substring(dados,467,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,468,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,469,1) as ID_PROFISSIONALIZANTE,
substring(dados,470,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,471,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,472,1) as ID_LIBRAS,
substring(dados,473,1) as ID_ESPECIALIZACAO,
substring(dados,474,1) as ID_MESTRADO,
substring(dados,475,1) as ID_DOUTORADO,
substring(dados,476,1) as ID_POS_GRADUACAO_NENHUM,
substring(dados,477,1) as ID_ESPECIFICO_CRECHE,
substring(dados,478,1) as ID_ESPECIFICO_PRE_ESCOLA,
substring(dados,479,1) as ID_ESPECIFICO_NEC_ESP,
substring(dados,480,1) as ID_ESPECIFICO_ED_INDIGENA,
substring(dados,481,1) as ID_INTERCULTURAL_OUTROS,
substring(dados,482,1) as ID_ESPECIFICO_NENHUM,
substring(dados,483,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,484,1) as ID_TIPO_DOCENTE,
substring(dados,485,11) as PK_COD_TURMA,
substring(dados,496,3) as FK_COD_TIPO_TURMA,
substring(dados,499,3) as FK_COD_MOD_ENSINO,
substring(dados,502,4) as FK_COD_ETAPA_ENSINO,
substring(dados,506,9) as FK_COD_CURSO_PROF,
substring(dados,515,9) as PK_COD_ENTIDADE,
substring(dados,524,3) as FK_COD_ESTADO,
substring(dados,527,2) as SIGLA,
substring(dados,529,8) as FK_COD_MUNICIPIO,
substring(dados,537,1) as ID_LOCALIZACAO,
substring(dados,538,1) as ID_DEPENDENCIA_ADM,
substring(dados,539,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,540,1) as ID_CONVENIADA_PP,
substring(dados,541,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,543,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,544,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,545,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,546,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,547,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,548,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,549,1) as ID_EDUCACAO_INDIGENA,
substring(dados,550,1) as ID_LINGUA_LITERAT_INDIGENA,
substring(dados,551,1) as ID_ENSINO_RELIGIOSO,
substring(dados,552,1) as ID_DISCIPLINAS_PEDAG
from SC_2010_DOCENTE_BLOCO;

select * from SC_2010_DOCENTE;

drop table SC_2010_DOCENTE_BLOCO;

