use dataviva_raw;

drop table if exists SC_2011_MATRICULA_BLOCO;
create table SC_2011_MATRICULA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_AC.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_AL.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_AM.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_AP.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_BA.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_CE.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_DF.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_ES.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_GO.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_MA.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_MG.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_MS.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_MT.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_PA.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_PB.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_PE.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_PI.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_PR.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_RJ.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_RN.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_RO.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_RR.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_RS.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_SC.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_SE.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_SP.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

load data local infile 'Y:/Censo Escolar/2011/DADOS/TS_MATRICULA_TO.txt'
into table SC_2011_MATRICULA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2011_MATRICULA;
create table SC_2011_MATRICULA select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,13) as PK_COD_MATRICULA,
substring(dados,19,14) as FK_COD_ALUNO,
substring(dados,33,3) as NU_DIA,
substring(dados,36,3) as NU_MES,
substring(dados,39,5) as NU_ANO,
substring(dados,44,5) as NUM_IDADE,
substring(dados,49,3) as NU_DUR_ESCOLARIZACAO,
substring(dados,52,3) as NU_DUR_ATIV_COMP_MESMA_REDE,
substring(dados,55,3) as NU_DUR_ATIV_COMP_OUTRAS_REDES,
substring(dados,58,1) as TP_SEXO,
substring(dados,59,1) as TP_COR_RACA,
substring(dados,60,1) as TP_NACIONALIDADE,
substring(dados,61,4) as FK_COD_PAIS_ORIGEM,
substring(dados,65,3) as FK_COD_ESTADO_NASC,
substring(dados,68,2) as SGL_UF_NASCIMENTO,
substring(dados,70,8) as FK_COD_MUNICIPIO_DNASC,
substring(dados,78,3) as FK_COD_ESTADO_END,
substring(dados,81,2) as SIGLA_END,
substring(dados,83,8) as FK_COD_MUNICIPIO_END,
substring(dados,91,1) as ID_ZONA_RESIDENCIAL,
substring(dados,92,1) as ID_TIPO_ATENDIMENTO,
substring(dados,93,1) as ID_N_T_E_P,
substring(dados,94,1) as ID_RESPONSAVEL_TRANSPORTE,
substring(dados,95,1) as ID_POSSUI_NEC_ESPECIAL,
substring(dados,96,1) as ID_TIPO_NEC_ESP_CEGUEIRA,
substring(dados,97,1) as ID_TIPO_NEC_ESP_BAIXA_VISAO,
substring(dados,98,1) as ID_TIPO_NEC_ESP_SURDEZ,
substring(dados,99,1) as ID_TIPO_NEC_ESP_DEF_AUDITIVA,
substring(dados,100,1) as ID_TIPO_NEC_ESP_SURDO_CEGUEIRA,
substring(dados,101,1) as ID_TIPO_NEC_ESP_DEF_FISICA,
substring(dados,102,1) as ID_TIPO_NEC_ESP_DEF_MENTAL,
substring(dados,103,1) as ID_TIPO_NEC_ESP_DEF_MULTIPLAS,
substring(dados,104,1) as ID_TIPO_NEC_ESP_AUTISMO,
substring(dados,105,1) as ID_TIPO_NEC_ESP_ASPERGER,
substring(dados,106,1) as ID_TIPO_NEC_ESP_RETT,
substring(dados,107,1) as ID_TIPO_NEC_ESP_TDI,
substring(dados,108,1) as ID_TIPO_NEC_ESP_SUPERDOTACAO,
substring(dados,109,3) as FK_COD_MOD_ENSINO,
substring(dados,112,4) as FK_COD_ETAPA_ENSINO,
substring(dados,116,11) as PK_COD_TURMA,
substring(dados,127,9) as FK_COD_CURSO_PROF,
substring(dados,136,2) as COD_UNIFICADA,
substring(dados,138,3) as FK_COD_TIPO_TURMA,
substring(dados,141,9) as PK_COD_ENTIDADE,
substring(dados,150,3) as FK_COD_ESTADO_ESCOLA,
substring(dados,153,2) as SIGLA_ESCOLA,
substring(dados,155,8) as COD_MUNICIPIO_ESCOLA,
substring(dados,163,8) as FK_CODIGO_DISTRITO,
substring(dados,171,1) as ID_LOCALIZACAO_ESC,
substring(dados,172,1) as ID_DEPENDENCIA_ADM_ESC,
substring(dados,173,1) as DESC_CATA_ESCOLA_PRIV,
substring(dados,174,1) as ID_CONVENIADA_PP_ESC,
substring(dados,175,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,177,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,178,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,179,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,180,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,181,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,182,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,183,1) as ID_EDUCACAO_INDIGENA
from SC_2011_MATRICULA_BLOCO;

select * from SC_2011_MATRICULA;

DROP TABLE SC_2011_MATRICULA_BLOCO;
