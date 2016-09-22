use dataviva_raw;

create table SC_2007_DOCENTE_BLOCO(dados varchar(2000) not null);

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_AC.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_AL.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_AM.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_AP.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_BA.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_CE.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_DF.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_ES.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_GO.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_MA.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_MG.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_MS.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_MT.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_PA.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_PB.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_PE.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_PI.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_PR.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_RJ.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_RN.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_RO.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_RR.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_RS.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_SC.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_SE.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_SP.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_DOCENTES_TO.txt'
into table SC_2007_DOCENTE_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2007_DOCENTE;
create table SC_2007_DOCENTE select 
substring(dados,1,4) as ANO_CENSO,
substring(dados,5,12) as FK_COD_DOCENTE,
substring(dados,17,2) as NU_DIA,
substring(dados,19,2) as NU_MES,
substring(dados,21,4) as NU_ANO,
substring(dados,25,3) as NUM_IDADE,
substring(dados,28,1) as TP_SEXO,
substring(dados,29,1) as TP_COR_RACA,
substring(dados,30,1) as TP_NACIONALIDADE,
substring(dados,31,3) as FK_COD_PAIS_ORIGEM,
substring(dados,34,2) as FK_COD_ESTADO_DNASC,
substring(dados,36,2) as SIGLA_ESTADO_DNASC,
substring(dados,38,7) as FK_COD_MUNICIPIO_DNASC,
substring(dados,45,2) as FK_COD_ESTADO_DEND,
substring(dados,47,2) as SIGLA_ESTADO_DEND,
substring(dados,49,7) as FK_COD_MUNICIPIO_DEND,
substring(dados,56,1) as FK_COD_ESCOLARIDADE,
substring(dados,57,2) as COD_CURSO_1,
substring(dados,59,2) as COD_CURSO_2,
substring(dados,61,2) as COD_CURSO_3,
substring(dados,63,1) as ID_QUIMICA,
substring(dados,64,1) as ID_FISICA,
substring(dados,65,1) as ID_MATEMATICA,
substring(dados,66,1) as ID_BIOLOGIA,
substring(dados,67,1) as ID_CIENCIAS,
substring(dados,68,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,69,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,70,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,71,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,72,1) as ID_ARTES,
substring(dados,73,1) as ID_EDUCACAO_FISICA,
substring(dados,74,1) as ID_HISTORIA,
substring(dados,75,1) as ID_GEOGRAFIA,
substring(dados,76,1) as ID_FILOSOFIA,
substring(dados,77,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,78,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,79,1) as ID_PROFISSIONALIZANTE,
substring(dados,80,1) as ID_DIDATICA_METODOLOGIA,
substring(dados,81,1) as ID_FUNDAMENTOS_EDUCACAO,
substring(dados,82,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,83,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,84,1) as ID_OUTRAS_DISCIPLINAS_PEDAG,
substring(dados,85,1) as ID_LIBRAS,
substring(dados,86,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,87,1) as ID_ESPECIALIZACAO,
substring(dados,88,1) as ID_MESTRADO,
substring(dados,89,1) as ID_DOUTORADO,
substring(dados,90,1) as ID_POS_GRADUACAO_NENHUM,
substring(dados,91,1) as ID_ESPECIFICO_CRECHE,
substring(dados,92,1) as ID_ESPECIFICO_PRE_ESCOLA,
substring(dados,93,1) as ID_ESPECIFICO_NEC_ESP,
substring(dados,94,1) as ID_ESPECIFICO_ED_INDIGENA,
substring(dados,95,1) as ID_INTERCULTURAL_OUTROS,
substring(dados,96,1) as ID_ESPECIFICO_NENHUM,
substring(dados,97,1) as ID_TIPO_DOCENTE,
substring(dados,98,10) as PK_COD_TURMA,
substring(dados,108,2) as FK_TIPO_TURMA,
substring(dados,110,2) as FK_COD_MOD_ENSINO,
substring(dados,112,3) as FK_COD_ETAPA_ENSINO,
substring(dados,115,8) as FK_COD_CURSO_PROF,
substring(dados,123,8) as PK_COD_ENTIDADE,
substring(dados,131,2) as FK_COD_ESTADO,
substring(dados,133,2) as SIGLA,
substring(dados,135,7) as FK_COD_MUNICIPIO,
substring(dados,142,1) as ID_LOCALIZACAO,
substring(dados,143,1) as ID_DEPENDENCIA_ADM,
substring(dados,144,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,145,1) as ID_CONVENIADA_PP,
substring(dados,146,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,147,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,148,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,149,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,150,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,151,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,152,1) as ID_EDUCACAO_INDIGENA
from SC_2007_DOCENTE_BLOCO;

select * from SC_2007_DOCENTE;
select * from SC_2007_DOCENTE_BLOCO;