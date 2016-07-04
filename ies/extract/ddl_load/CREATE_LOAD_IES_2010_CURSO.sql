use dataviva_raw;

drop table if exists IES_2010_CURSO_BLOCO;
drop table if exists IES_2010_CURSO;
create table IES_2010_CURSO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2010/DADOS/CURSO.txt'
into table IES_2010_CURSO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2010_CURSO select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,117,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,125,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,225,8) as CO_MUNICIPIO,
substring(dados,233,8) as CO_UF,
substring(dados,241,8) as CO_CURSO,
substring(dados,249,200) as NO_CURSO,
substring(dados,449,12) as CO_OCDE,
substring(dados,461,120) as NO_OCDE,
substring(dados,581,12) as CO_OCDE_AREA_GERAL,
substring(dados,593,120) as NO_AREA_GERAL,
substring(dados,713,12) as CO_OCDE_AREA_ESPECIFICA,
substring(dados,725,120) as NO_AREA_ESPECIFICA,
substring(dados,845,12) as CO_OCDE_AREA_DETALHADA,
substring(dados,857,120) as NO_AREA_DETALHADA,
substring(dados,977,8) as CO_GRAU_ACADEMICO,
substring(dados,985,8) as CO_MODALIDADE_ENSINO,
substring(dados,993,8) as CO_NIVEL_ACADEMICO,
substring(dados,1001,8) as IN_GRATUITO,
substring(dados,1009,8) as TP_ATRIBUTO_INGRESSO,
substring(dados,1017,8) as CO_LOCAL_OFERTA_IES,
substring(dados,1025,8) as NU_CARGA_HORARIA,
substring(dados,1033,10) as DT_INICIO_FUNCIONAMENTO,
substring(dados,1043,8) as IN_AJUDA_DEFICIENTE,
substring(dados,1051,8) as IN_MATERIAL_DIGITAL,
substring(dados,1059,8) as IN_MATERIAL_IMPRESSO,
substring(dados,1067,8) as IN_MATERIAL_AUDIO,
substring(dados,1075,8) as IN_MATERIAL_BRAILLE,
substring(dados,1083,8) as IN_DISCIPLINA_LIBRAS,
substring(dados,1091,8) as IN_GUIA_INTERPRETE,
substring(dados,1099,8) as IN_MATERIAL_LIBRAS,
substring(dados,1107,8) as IN_SINTESE_VOZ,
substring(dados,1115,8) as IN_TRADUTOR_LIBRAS,
substring(dados,1123,8) as IN_INTEGRAL_CURSO,
substring(dados,1131,8) as IN_MATUTINO_CURSO,
substring(dados,1139,8) as IN_NOTURNO_CURSO,
substring(dados,1147,8) as IN_VESPERTINO_CURSO,
substring(dados,1155,8) as NU_PERC_CARGA_HOR_DISTANCIA,
substring(dados,1163,8) as NU_INTEGRALIZACAO_MATUTINO,
substring(dados,1171,8) as NU_INTEGRALIZACAO_VESPERTINO,
substring(dados,1179,8) as NU_INTEGRALIZACAO_NOTURNO,
substring(dados,1187,8) as NU_INTEGRALIZACAO_INTEGRAL,
substring(dados,1195,8) as TP_MOTIVO_SEM_VINCULO,
substring(dados,1203,8) as CO_CURSO_REPRESENTADO,
substring(dados,1211,8) as IN_OFERECE_DISC_DISTANCIA,
substring(dados,1219,8) as IN_UTILIZA_LABORATORIO,
substring(dados,1227,8) as QT_INSCRITOS_ANO_EAD,
substring(dados,1235,8) as QT_VAGAS_ANUAL_EAD,
substring(dados,1243,8) as QT_VAGAS_INTEGRAL_PRES,
substring(dados,1251,8) as QT_VAGAS_MATUTINO_PRES,
substring(dados,1259,8) as QT_VAGAS_NOTURNO_PRES,
substring(dados,1267,8) as QT_VAGAS_VESPERTINO_PRES,
substring(dados,1275,8) as QT_INSCRITOS_MATUTINO_PRES,
substring(dados,1283,8) as QT_INSCRITOS_VESPERTINO_PRES,
substring(dados,1291,8) as QT_INSCRITOS_NOTURNO_PRES,
substring(dados,1299,8) as QT_INSCRITOS_INTEGRAL_PRES,
substring(dados,1307,8) as QT_MATRICULA_CURSO,
substring(dados,1315,8) as QT_CONCLUINTE_CURSO,
substring(dados,1323,8) as QT_INGRESSO_CURSO,
substring(dados,1331,8) as QT_INGRESSO_PROCESSO_SELETIVO,
substring(dados,1339,8) as QT_INGRESSO_OUTRA_FORMA
from IES_2010_CURSO_BLOCO;

select * from IES_2010_CURSO;


