use dataviva_raw;

drop table if exists SC_2012_TURMA_BLOCO;
create table SC_2012_TURMA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2012/DADOS/TS_TURMA.txt'
into table SC_2012_TURMA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2012_TURMA;
create table SC_2012_TURMA select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,11) as PK_COD_TURMA,
substring(dados,17,80) as NO_TURMA,
substring(dados,97,2) as HR_INICIAL,
substring(dados,99,2) as HR_INICIAL_MINUTO,
substring(dados,101,6) as NU_DURACAO_TURMA,
substring(dados,107,6) as NUM_MATRICULAS,
substring(dados,113,3) as FK_COD_MOD_ENSINO,
substring(dados,116,4) as FK_COD_ETAPA_ENSINO,
substring(dados,120,9) as FK_COD_CURSO_PROF,
substring(dados,129,3) as FK_COD_TIPO_TURMA,
substring(dados,132,1) as ID_MAIS_EDUCACAO,
substring(dados,133,1) as ID_DIA_SEMANA_DOMINGO,
substring(dados,134,1) as ID_DIA_SEMANA_SEGUNDA,
substring(dados,135,1) as ID_DIA_SEMANA_TERCA,
substring(dados,136,1) as ID_DIA_SEMANA_QUARTA,
substring(dados,137,1) as ID_DIA_SEMANA_QUINTA,
substring(dados,138,1) as ID_DIA_SEMANA_SEXTA,
substring(dados,139,1) as ID_DIA_SEMANA_SABADO,
substring(dados,140,6) as FK_COD_TIPO_ATIVIDADE_1,
substring(dados,146,6) as FK_COD_TIPO_ATIVIDADE_2,
substring(dados,152,6) as FK_COD_TIPO_ATIVIDADE_3,
substring(dados,158,6) as FK_COD_TIPO_ATIVIDADE_4,
substring(dados,164,6) as FK_COD_TIPO_ATIVIDADE_5,
substring(dados,170,6) as FK_COD_TIPO_ATIVIDADE_6,
substring(dados,176,1) as ID_BRAILLE,
substring(dados,177,1) as ID_RECURSOS_BAIXA_VISAO,
substring(dados,178,1) as ID_PROCESSOS_MENTAIS,
substring(dados,179,1) as ID_ORIENTACAO_MOBILIDADE,
substring(dados,180,1) as ID_SINAIS,
substring(dados,181,1) as ID_COM_ALT_AUMENT,
substring(dados,182,1) as ID_ENRIQ_CURRICULAR,
substring(dados,183,1) as ID_SOROBAN,
substring(dados,184,1) as ID_INF_ACESSIVEL,
substring(dados,185,1) as ID_PORT_ESC,
substring(dados,186,1) as ID_AUT_ESCOLAR,
substring(dados,187,1) as ID_QUIMICA,
substring(dados,188,1) as ID_FISICA,
substring(dados,189,1) as ID_MATEMATICA,
substring(dados,190,1) as ID_BIOLOGIA,
substring(dados,191,1) as ID_CIENCIAS,
substring(dados,192,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,193,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,194,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,195,1) as ID_LINGUA_LITERAT_FRANCES,
substring(dados,196,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,197,1) as ID_LINGUA_LITERAT_INDIGENA,
substring(dados,198,1) as ID_ARTES,
substring(dados,199,1) as ID_EDUCACAO_FISICA,
substring(dados,200,1) as ID_HISTORIA,
substring(dados,201,1) as ID_GEOGRAFIA,
substring(dados,202,1) as ID_FILOSOFIA,
substring(dados,203,1) as ID_ENSINO_RELIGIOSO,
substring(dados,204,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,205,1) as ID_SOCIOLOGIA,
substring(dados,206,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,207,1) as ID_PROFISSIONALIZANTE,
substring(dados,208,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,209,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,210,1) as ID_LIBRAS,
substring(dados,211,1) as ID_DISCIPLINAS_PEDAG,
substring(dados,212,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,213,9) as PK_COD_ENTIDADE,
substring(dados,222,3) as FK_COD_ESTADO,
substring(dados,225,2) as SIGLA,
substring(dados,227,9) as FK_COD_MUNICIPIO,
substring(dados,236,9) as FK_COD_DISTRITO,
substring(dados,245,1) as ID_LOCALIZACAO,
substring(dados,246,1) as ID_DEPENDENCIA_ADM,
substring(dados,247,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,248,1) as ID_CONVENIADA_PP,
substring(dados,249,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,251,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,252,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,253,1) as ID_MANT_ESCOLA_PRIVADA_SIST_S,
substring(dados,254,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,255,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,256,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,257,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,258,1) as ID_EDUCACAO_INDIGENA
from SC_2012_TURMA_BLOCO;

select * from SC_2012_TURMA;

drop table SC_2012_TURMA_BLOCO;

