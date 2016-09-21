use dataviva_raw;

drop table if exists SC_2007_TURMA_BLOCO;
create table SC_2007_TURMA_BLOCO(dados varchar(2000) not null);

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_TURMA.txt'
into table SC_2007_TURMA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2007_TURMA;
create table SC_2007_TURMA select 
substring(dados,1,4) as ANO_CENSO,
substring(dados,5,10) as PK_COD_TURMA,
substring(dados,15,80) as NO_TURMA,
substring(dados,95,2) as HR_INICIAL,
substring(dados,97,2) as HR_INICIAL_MINUTO,
substring(dados,99,3) as NU_DURACAO_TURMA,
substring(dados,102,3) as NUM_MATRICULAS,
substring(dados,105,2) as FK_COD_MOD_ENSINO,
substring(dados,107,3) as FK_COD_ETAPA_ENSINO,
substring(dados,110,8) as FK_COD_CURSO_PROF,
substring(dados,118,2) as FK_COD_TIPO_TURMA,
substring(dados,120,1) as ID_QUIMICA,
substring(dados,121,1) as ID_FISICA,
substring(dados,122,1) as ID_MATEMATICA,
substring(dados,123,1) as ID_BIOLOGIA,
substring(dados,124,1) as ID_CIENCIAS,
substring(dados,125,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,126,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,127,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,128,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,129,1) as ID_ARTES,
substring(dados,130,1) as ID_EDUCACAO_FISICA,
substring(dados,131,1) as ID_HISTORIA,
substring(dados,132,1) as ID_GEOGRAFIA,
substring(dados,133,1) as ID_FILOSOFIA,
substring(dados,134,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,135,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,136,1) as ID_PROFISSIONALIZANTE,
substring(dados,137,1) as ID_DIDATICA_METODOLOGIA,
substring(dados,138,1) as ID_FUNDAMENTOS_EDUCACAO,
substring(dados,139,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,140,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,141,1) as ID_OUTRAS_DISCIPLINAS_PEDAG,
substring(dados,142,1) as ID_LIBRAS,
substring(dados,143,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,144,8) as PK_COD_ENTIDADE,
substring(dados,152,2) as FK_COD_ESTADO,
substring(dados,154,2) as SIGLA,
substring(dados,156,7) as FK_COD_MUNICIPIO,
substring(dados,163,1) as ID_LOCALIZACAO,
substring(dados,164,1) as ID_DEPENDENCIA_ADM,
substring(dados,165,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,166,1) as ID_CONVENIADA_PP,
substring(dados,167,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,168,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,169,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,170,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,171,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,172,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,173,1) as ID_EDUCACAO_INDIGENA
from SC_2007_TURMA_BLOCO;

select * from SC_2007_TURMA;