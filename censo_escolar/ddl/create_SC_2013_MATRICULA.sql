use dataviva_raw;

drop table if exists SC_2013_MATRICULA_BLOCO;
create table SC_2013_MATRICULA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_AC.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_AL.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_AM.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_AP.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_BA.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_CE.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_DF.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_ES.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_GO.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_MA.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_MG.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_MS.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_MT.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_PA.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_PB.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_PE.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_PI.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_PR.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_RJ.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_RN.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_RO.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_RR.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_RS.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_SC.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_SE.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_SP.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2013/DADOS/TS_MATRICULA_TO.txt'
into table SC_2013_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2013_MATRICULA;
create table SC_2013_MATRICULA select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,13) as PK_COD_MATRICULA,
substring(dados,19,14) as FK_COD_ALUNO,
substring(dados,33,3) as NU_DIA,
substring(dados,36,3) as NU_MES,
substring(dados,39,5) as NU_ANO,
substring(dados,44,5) as NUM_IDADE_REFERENCIA,
substring(dados,49,4) as NUM_IDADE,
substring(dados,53,6) as NU_DUR_ESCOLARIZACAO ,
substring(dados,59,6) as NU_DUR_ATIV_COMP_MESMA_REDE ,
substring(dados,65,6) as NU_DUR_ATIV_COMP_OUTRAS_REDES ,
substring(dados,71,1) as TP_SEXO,
substring(dados,72,1) as TP_COR_RACA,
substring(dados,73,1) as TP_NACIONALIDADE,
substring(dados,74,4) as FK_COD_PAIS_ORIGEM,
substring(dados,78,3) as FK_COD_ESTADO_NASC,
substring(dados,81,2) as SGL_UF_NASCIMENTO,
substring(dados,83,9) as FK_COD_MUNICIPIO_DNASC,
substring(dados,92,3) as FK_COD_ESTADO_END,
substring(dados,95,2) as SIGLA_END,
substring(dados,97,9) as FK_COD_MUNICIPIO_END,
substring(dados,106,1) as ID_ZONA_RESIDENCIAL,
substring(dados,107,1) as ID_TIPO_ATENDIMENTO,
substring(dados,108,1) as ID_N_T_E_P,
substring(dados,109,1) as ID_RESPONSAVEL_TRANSPORTE,
substring(dados,110,1) as ID_TRANSP_VANS_KOMBI,
substring(dados,111,1) as ID_TRANSP_MICRO_ONIBUS,
substring(dados,112,1) as ID_TRANSP_ONIBUS,
substring(dados,113,1) as ID_TRANSP_BICICLETA,
substring(dados,114,1) as ID_TRANSP_TR_ANIMAL,
substring(dados,115,1) as ID_TRANSP_OUTRO_VEICULO,
substring(dados,116,1) as ID_TRANSP_EMBAR_ATE5,
substring(dados,117,1) as ID_TRANSP_EMBAR_5A15,
substring(dados,118,1) as ID_TRANSP_EMBAR_15A35,
substring(dados,119,1) as ID_TRANSP_EMBAR_35,
substring(dados,120,1) as ID_TRANSP_TREM_METRO,
substring(dados,121,1) as ID_POSSUI_NEC_ESPECIAL,
substring(dados,122,1) as ID_TIPO_NEC_ESP_CEGUEIRA,
substring(dados,123,1) as ID_TIPO_NEC_ESP_BAIXA_VISAO,
substring(dados,124,1) as ID_TIPO_NEC_ESP_SURDEZ,
substring(dados,125,1) as ID_TIPO_NEC_ESP_DEF_AUDITIVA,
substring(dados,126,1) as ID_TIPO_NEC_ESP_SURDO_CEGUEIRA,
substring(dados,127,1) as ID_TIPO_NEC_ESP_DEF_FISICA,
substring(dados,128,1) as ID_TIPO_NEC_ESP_DEF_MENTAL,
substring(dados,129,1) as ID_TIPO_NEC_ESP_DEF_MULTIPLAS,
substring(dados,130,1) as ID_TIPO_NEC_ESP_AUTISMO,
substring(dados,131,1) as ID_TIPO_NEC_ESP_ASPERGER,
substring(dados,132,1) as ID_TIPO_NEC_ESP_RETT,
substring(dados,133,1) as ID_TIPO_NEC_ESP_TDI,
substring(dados,134,1) as ID_TIPO_NEC_ESP_SUPERDOTACAO,
substring(dados,135,1) as ID_TIPO_REC_ESP_LEDOR,
substring(dados,136,1) as ID_TIPO_REC_ESP_TRANSCRICAO,
substring(dados,137,1) as ID_TIPO_REC_ESP_INTERPRETE,
substring(dados,138,1) as ID_TIPO_REC_ESP_LIBRAS,
substring(dados,139,1) as ID_TIPO_REC_ESP_LABIAL,
substring(dados,140,1) as ID_TIPO_REC_ESP_BRAILLE,
substring(dados,141,1) as ID_TIPO_REC_ESP_AMPLIADA_16,
substring(dados,142,1) as ID_TIPO_REC_ESP_AMPLIADA_20,
substring(dados,143,1) as ID_TIPO_REC_ESP_AMPLIADA_24,
substring(dados,144,1) as ID_TIPO_REC_ESP_NENHUM,
substring(dados,145,1) as ID_INGRESSO_FEDERAIS,
substring(dados,146,3) as FK_COD_MOD_ENSINO,
substring(dados,149,4) as FK_COD_ETAPA_ENSINO,
substring(dados,153,11) as PK_COD_TURMA,
substring(dados,164,9) as FK_COD_CURSO_PROF,
substring(dados,173,2) as COD_UNIFICADA,
substring(dados,175,3) as FK_COD_TIPO_TURMA,
substring(dados,178,9) as PK_COD_ENTIDADE,
substring(dados,187,3) as FK_COD_ESTADO_ESCOLA,
substring(dados,190,2) as SIGLA_ESCOLA,
substring(dados,192,9) as COD_MUNICIPIO_ESCOLA,
substring(dados,201,9) as  FK_CODIGO_DISTRITO,
substring(dados,210,1) as ID_LOCALIZACAO_ESC,
substring(dados,211,1) as ID_DEPENDENCIA_ADM_ESC,
substring(dados,212,1) as DESC_CATA_ESCOLA_PRIV,
substring(dados,213,1) as ID_CONVENIADA_PP_ESC,
substring(dados,214,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,216,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,217,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,218,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,219,1) as ID_MANT_ESCOLA_PRIVADA_SIST_S,
substring(dados,220,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,221,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,222,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,223,1) as ID_EDUCACAO_INDIGENA
from SC_2013_MATRICULA_BLOCO;

select * from SC_2013_MATRICULA;

DROP TABLE SC_2013_MATRICULA_BLOCO;
