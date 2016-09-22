use dataviva_raw;

drop table if exists SC_2007_MATRICULA_BLOCO;
create table SC_2007_MATRICULA_BLOCO(dados varchar(2000) not null);

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_AC.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_AL.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_AM.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_AP.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_BA.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_CE.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_DF.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_ES.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_GO.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_MA.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_MG.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_MS.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_MT.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_PA.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_PB.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_PE.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_PI.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_PR.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_RJ.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_RN.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_RO.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_RR.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_RS.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_SC.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_SE.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_SP.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_MATRICULA_TO.txt'
into table SC_2007_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2007_MATRICULA;
create table SC_2007_MATRICULA select 
substring(dados,1,4) as ANO_CENSO,
substring(dados,5,12) as PK_COD_MATRICULA,
substring(dados,17,13) as FK_COD_ALUNO,
substring(dados,30,2) as NU_DIA,
substring(dados,32,2) as NU_MES,
substring(dados,34,4) as NU_ANO,
substring(dados,38,3) as NUM_IDADE,
substring(dados,41,1) as TP_SEXO,
substring(dados,42,1) as TP_COR_RACA,
substring(dados,43,1) as TP_NACIONALIDADE,
substring(dados,44,3) as FK_COD_PAIS_ORIGEM,
substring(dados,47,2) as FK_COD_ESTADO_NASC,
substring(dados,49,2) as SGL_UF_NASCIMENTO,
substring(dados,51,7) as FK_COD_MUNICIPIO_DNASC,
substring(dados,58,2) as FK_COD_ESTADO_END,
substring(dados,60,2) as SIGLA_END,
substring(dados,62,7) as FK_COD_MUNICIPIO_END,
substring(dados,69,1) as ID_ZONA_RESIDENCIAL,
substring(dados,70,1) as ID_TIPO_ATENDIMENTO,
substring(dados,71,1) as ID_N_T_E_P,
substring(dados,72,1) as ID_RESPONSAVEL_TRANSPORTE,
substring(dados,73,1) as ID_POSSUI_NEC_ESPECIAL,
substring(dados,74,1) as ID_TIPO_NEC_ESP_CEGUEIRA,
substring(dados,75,1) as ID_TIPO_NEC_ESP_BAIXA_VISAO,
substring(dados,76,1) as ID_TIPO_NEC_ESP_SURDEZ,
substring(dados,77,1) as ID_TIPO_NEC_ESP_DEF_AUDITIVA,
substring(dados,78,1) as ID_TIPO_NEC_ESP_SURDO_CEGUEIRA,
substring(dados,79,1) as ID_TIPO_NEC_ESP_DEF_FISICA,
substring(dados,80,1) as ID_TIPO_NEC_ESP_DEF_MENTAL,
substring(dados,81,1) as ID_TIPO_NEC_ESP_TRANSTORNOS,
substring(dados,82,1) as ID_TIPO_NEC_ESP_SINDROME_DOWN,
substring(dados,83,1) as ID_TIPO_NEC_ESP_DEF_MULTIPLAS,
substring(dados,84,1) as ID_TIPO_NEC_ESP_SUPERDOTACAO,
substring(dados,85,1) as ID_NEC_APO_ESP_PEDAGOGICO,
substring(dados,86,2) as FK_COD_MOD_ENSINO,
substring(dados,88,3) as FK_COD_ETAPA_ENSINO,
substring(dados,91,10) as PK_COD_TURMA,
substring(dados,101,8) as FK_COD_CURSO_PROF,
substring(dados,109,1) as COD_UNIFICADA,
substring(dados,110,2) as FK_COD_TIPO_TURMA,
substring(dados,112,8) as PK_COD_ENTIDADE,
substring(dados,120,2) as FK_COD_ESTADO_ESCOLA,
substring(dados,122,2) as SIGLA_ESCOLA,
substring(dados,124,7) as COD_MUNICIPIO_ESCOLA,
substring(dados,131,1) as ID_LOCALIZACAO_ESC,
substring(dados,132,1) as ID_DEPENDENCIA_ADM_ESC,
substring(dados,133,1) as DESC_CATA_ESCOLA_PRIV,
substring(dados,134,1) as ID_CONVENIADA_PP_ESC,
substring(dados,135,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,136,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,137,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,138,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,139,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,140,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,141,1) as ID_EDUCACAO_INDIGENA
from SC_2007_MATRICULA_BLOCO;

select * from SC_2007_MATRICULA;