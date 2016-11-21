use dataviva_raw;

drop table if exists SC_2008_TURMA_BLOCO;
create table SC_2008_TURMA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2008/DADOS/TS_TURMA.txt'
into table SC_2008_TURMA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2008_TURMA;
create table SC_2008_TURMA select 
substring(dados,1,6) as ANO_CENSO,
substring(dados,7,12) as PK_COD_TURMA,
substring(dados,19,80) as NO_TURMA,
substring(dados,99,2) as HR_INICIAL,
substring(dados,101,2) as HR_INICIAL_MINUTO,
substring(dados,103,7) as NU_DURACAO_TURMA,
substring(dados,110,7) as NUM_MATRICULAS,
substring(dados,117,4) as FK_COD_MOD_ENSINO,
substring(dados,121,4) as FK_COD_ETAPA_ENSINO,
substring(dados,125,9) as FK_COD_CURSO_PROF,
substring(dados,134,4) as FK_COD_TIPO_TURMA,
substring(dados,138,2) as ID_VEZ_ATIVIDADE_COMPLEMENTAR,
substring(dados,140,6) as FK_COD_TIPO_ATIVIDADE_1,
substring(dados,146,5) as FK_COD_TIPO_ATIVIDADE_2,
substring(dados,151,5) as FK_COD_TIPO_ATIVIDADE_3,
substring(dados,156,5) as FK_COD_TIPO_ATIVIDADE_4,
substring(dados,161,5) as FK_COD_TIPO_ATIVIDADE_5,
substring(dados,166,5) as FK_COD_TIPO_ATIVIDADE_6,
substring(dados,171,1) as ID_QUIMICA,
substring(dados,172,1) as ID_FISICA,
substring(dados,173,1) as ID_MATEMATICA,
substring(dados,174,1) as ID_BIOLOGIA,
substring(dados,175,1) as ID_CIENCIAS,
substring(dados,176,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,177,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,178,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,179,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,180,1) as ID_ARTES,
substring(dados,181,1) as ID_EDUCACAO_FISICA,
substring(dados,182,1) as ID_HISTORIA,
substring(dados,183,1) as ID_GEOGRAFIA,
substring(dados,184,1) as ID_FILOSOFIA,
substring(dados,185,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,186,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,187,1) as ID_PROFISSIONALIZANTE,
substring(dados,188,1) as ID_DIDATICA_METODOLOGIA,
substring(dados,189,1) as ID_FUNDAMENTOS_EDUCACAO,
substring(dados,190,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,191,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,192,1) as ID_OUTRAS_DISCIPLINAS_PEDAG,
substring(dados,193,1) as ID_LIBRAS,
substring(dados,194,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,195,10) as PK_COD_ENTIDADE,
substring(dados,205,4) as FK_COD_ESTADO,
substring(dados,209,2) as SIGLA,
substring(dados,211,14) as FK_COD_MUNICIPIO,
substring(dados,225,1) as ID_LOCALIZACAO,
substring(dados,226,1) as ID_DEPENDENCIA_ADM,
substring(dados,227,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,228,1) as ID_CONVENIADA_PP,
substring(dados,229,8) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,237,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,238,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,239,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,240,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,241,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,242,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,243,1) as ID_EDUCACAO_INDIGENA
from SC_2008_TURMA_BLOCO;

select * from SC_2008_TURMA;

drop table SC_2008_TURMA_BLOCO;

