use dataviva_raw;

drop table if exists SC_2009_MATRICULA_BLOCO;
create table SC_2009_MATRICULA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_AC.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_AL.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_AM.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_AP.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_BA.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_CE.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_DF.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_ES.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_GO.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_MA.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_MG.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_MS.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_MT.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_PA.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_PB.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_PE.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_PI.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_PR.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_RJ.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_RN.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_RO.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_RR.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_RS.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_SC.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_SE.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_SP.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2009/DADOS/TS_MATRICULA_TO.txt'
into table SC_2009_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2009_MATRICULA;
create table SC_2009_MATRICULA select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,13) as PK_COD_MATRICULA,
substring(dados,19,14) as FK_COD_ALUNO,
substring(dados,33,3) as NU_DIA,
substring(dados,36,3) as NU_MES,
substring(dados,39,5) as NU_ANO,
substring(dados,44,5) as NUM_IDADE,
substring(dados,49,1) as TP_SEXO,
substring(dados,50,1) as TP_COR_RACA,
substring(dados,51,1) as TP_NACIONALIDADE,
substring(dados,52,4) as FK_COD_PAIS_ORIGEM,
substring(dados,56,3) as FK_COD_ESTADO_NASC,
substring(dados,59,2) as SGL_UF_NASCIMENTO,
substring(dados,61,8) as FK_COD_MUNICIPIO_DNASC,
substring(dados,69,3) as FK_COD_ESTADO_END,
substring(dados,72,2) as SIGLA_END,
substring(dados,74,8) as FK_COD_MUNICIPIO_END,
substring(dados,82,1) as ID_ZONA_RESIDENCIAL,
substring(dados,83,1) as ID_TIPO_ATENDIMENTO,
substring(dados,84,1) as ID_N_T_E_P,
substring(dados,85,1) as ID_RESPONSAVEL_TRANSPORTE,
substring(dados,86,1) as ID_POSSUI_NEC_ESPECIAL,
substring(dados,87,1) as ID_TIPO_NEC_ESP_CEGUEIRA,
substring(dados,88,1) as ID_TIPO_NEC_ESP_BAIXA_VISAO,
substring(dados,89,1) as ID_TIPO_NEC_ESP_SURDEZ,
substring(dados,90,1) as ID_TIPO_NEC_ESP_DEF_AUDITIVA,
substring(dados,91,1) as ID_TIPO_NEC_ESP_SURDO_CEGUEIRA,
substring(dados,92,1) as ID_TIPO_NEC_ESP_DEF_FISICA,
substring(dados,93,1) as ID_TIPO_NEC_ESP_DEF_MENTAL,
substring(dados,94,1) as ID_TIPO_NEC_ESP_DEF_MULTIPLAS,
substring(dados,95,1) as ID_TIPO_NEC_ESP_AUTISMO,
substring(dados,96,1) as ID_TIPO_NEC_ESP_ASPERGER,
substring(dados,97,1) as ID_TIPO_NEC_ESP_RETT,
substring(dados,98,1) as ID_TIPO_NEC_ESP_TDI,
substring(dados,99,1) as ID_TIPO_NEC_ESP_SUPERDOTACAO,
substring(dados,100,3) as FK_COD_MOD_ENSINO,
substring(dados,103,4) as FK_COD_ETAPA_ENSINO,
substring(dados,107,11) as PK_COD_TURMA,
substring(dados,118,9) as FK_COD_CURSO_PROF,
substring(dados,127,2) as COD_UNIFICADA,
substring(dados,129,3) as FK_COD_TIPO_TURMA,
substring(dados,132,9) as PK_COD_ENTIDADE,
substring(dados,141,3) as FK_COD_ESTADO_ESCOLA,
substring(dados,144,2) as SIGLA_ESCOLA,
substring(dados,146,8) as COD_MUNICIPIO_ESCOLA,
substring(dados,154,1) as ID_LOCALIZACAO_ESC,
substring(dados,155,1) as ID_DEPENDENCIA_ADM_ESC,
substring(dados,156,1) as DESC_CATA_ESCOLA_PRIV,
substring(dados,157,1) as ID_CONVENIADA_PP_ESC,
substring(dados,158,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,160,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,161,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,162,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,163,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,164,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,165,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,166,1) as ID_EDUCACAO_INDIGENA
from SC_2009_MATRICULA_BLOCO;

select * from SC_2009_MATRICULA;

DROP TABLE SC_2009_MATRICULA_BLOCO;
