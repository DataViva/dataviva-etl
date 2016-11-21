use dataviva_raw;

drop table if exists SC_2010_TURMA_BLOCO;
create table SC_2010_TURMA_BLOCO(dados varchar(2000) not null);

load data local infile 'Y:/Censo Escolar/2010/DADOS/TS_TURMA.txt'
into table SC_2010_TURMA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists SC_2010_TURMA;
create table SC_2010_TURMA select 
substring(dados,1,5) as ANO_CENSO,
substring(dados,6,11) as PK_COD_TURMA,
substring(dados,17,80) as NO_TURMA,
substring(dados,97,2) as HR_INICIAL,
substring(dados,99,2) as HR_INICIAL_MINUTO,
substring(dados,101,5) as NU_DURACAO_TURMA,
substring(dados,106,6) as NUM_MATRICULAS,
substring(dados,112,3) as FK_COD_MOD_ENSINO,
substring(dados,115,4) as FK_COD_ETAPA_ENSINO,
substring(dados,119,9) as FK_COD_CURSO_PROF,
substring(dados,128,3) as FK_COD_TIPO_TURMA,
substring(dados,131,2) as ID_VEZ_ATIVIDADE_COMPLEMENTAR,
substring(dados,133,6) as FK_COD_TIPO_ATIVIDADE_1,
substring(dados,139,6) as FK_COD_TIPO_ATIVIDADE_2,
substring(dados,145,6) as FK_COD_TIPO_ATIVIDADE_3,
substring(dados,151,6) as FK_COD_TIPO_ATIVIDADE_4,
substring(dados,157,6) as FK_COD_TIPO_ATIVIDADE_5,
substring(dados,163,6) as FK_COD_TIPO_ATIVIDADE_6,
substring(dados,169,1) as ID_BRAILLE,
substring(dados,170,1) as ID_AUTONOMA,
substring(dados,171,1) as ID_RECURSOS_BAIXA_VISAO,
substring(dados,172,1) as ID_PROCESSOS_MENTAIS,
substring(dados,173,1) as ID_ORIENTACAO_MOBILIDADE,
substring(dados,174,1) as ID_SINAIS,
substring(dados,175,1) as ID_COM_ALT_AUMENT,
substring(dados,176,1) as ID_ENRIQ_CURRICULAR,
substring(dados,177,1) as ID_SOROBAN,
substring(dados,178,1) as ID_INF_ACESSIVEL,
substring(dados,179,1) as ID_PORT_ESC,
substring(dados,180,1) as ID_QUIMICA,
substring(dados,181,1) as ID_FISICA,
substring(dados,182,1) as ID_MATEMATICA,
substring(dados,183,1) as ID_BIOLOGIA,
substring(dados,184,1) as ID_CIENCIAS,
substring(dados,185,1) as ID_LINGUA_LITERAT_PORTUGUESA,
substring(dados,186,1) as ID_LINGUA_LITERAT_INGLES,
substring(dados,187,1) as ID_LINGUA_LITERAT_ESPANHOL,
substring(dados,188,1) as ID_LINGUA_LITERAT_OUTRA,
substring(dados,189,1) as ID_LINGUA_LITERAT_INDIGENA,
substring(dados,190,1) as ID_ARTES,
substring(dados,191,1) as ID_EDUCACAO_FISICA,
substring(dados,192,1) as ID_HISTORIA,
substring(dados,193,1) as ID_GEOGRAFIA,
substring(dados,194,1) as ID_FILOSOFIA,
substring(dados,195,1) as ID_ENSINO_RELIGIOSO,
substring(dados,196,1) as ID_ESTUDOS_SOCIAIS,
substring(dados,197,1) as ID_INFORMATICA_COMPUTACAO,
substring(dados,198,1) as ID_PROFISSIONALIZANTE,
substring(dados,199,1) as ID_DISC_ATENDIMENTO_ESPECIAIS,
substring(dados,200,1) as ID_DISC_DIVERSIDADE_SOCIO_CULT,
substring(dados,201,1) as ID_LIBRAS,
substring(dados,202,1) as ID_DISCIPLINAS_PEDAG,
substring(dados,203,1) as ID_OUTRAS_DISCIPLINAS,
substring(dados,204,9) as PK_COD_ENTIDADE,
substring(dados,213,3) as FK_COD_ESTADO,
substring(dados,216,2) as SIGLA,
substring(dados,218,8) as FK_COD_MUNICIPIO,
substring(dados,226,1) as ID_LOCALIZACAO,
substring(dados,227,1) as ID_DEPENDENCIA_ADM,
substring(dados,228,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,229,1) as ID_CONVENIADA_PP,
substring(dados,230,2) as ID_TIPO_CONVENIO_PODER_PUBLICO,
substring(dados,232,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,233,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,234,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,235,1) as ID_MANT_ESCOLA_PRIVADA_S_FINS,
substring(dados,236,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,237,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,238,1) as ID_EDUCACAO_INDIGENA
from SC_2010_TURMA_BLOCO;

select * from SC_2010_TURMA;

drop table SC_2010_TURMA_BLOCO;

