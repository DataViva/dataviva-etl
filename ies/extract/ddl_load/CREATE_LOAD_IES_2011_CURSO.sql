use dataviva_raw;

rename table IES_2011_CURSO to IES_2011_CURSO_T1;

drop table if exists IES_2011_CURSO_BLOCO;
create table IES_2011_CURSO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2011/DADOS/CURSO.txt'
into table IES_2011_CURSO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists IES_2011_CURSO;
create table IES_2011_CURSO select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,117,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,125,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,225,8) as CO_MUNICIPIO_CURSO,
substring(dados,233,150) as NO_MUNICIPIO_CURSO,
substring(dados,383,8) as CO_UF_CURSO,
substring(dados,391,2) as SGL_UF_CURSO,
substring(dados,393,30) as NO_REGIAO_CURSO,
substring(dados,423,8) as IN_CAPITAL_CURSO,
substring(dados,431,8) as CO_CURSO,
substring(dados,439,200) as NO_CURSO,
substring(dados,639,12) as CO_OCDE,
substring(dados,651,120) as NO_OCDE,
substring(dados,771,12) as CO_OCDE_AREA_GERAL,
substring(dados,783,120) as NO_OCDE_AREA_GERAL,
substring(dados,903,12) as CO_OCDE_AREA_ESPECIFICA,
substring(dados,915,120) as NO_OCDE_AREA_ESPECIFICA,
substring(dados,1035,12) as CO_OCDE_AREA_DETALHADA,
substring(dados,1047,120) as NO_OCDE_AREA_DETALHADA,
substring(dados,1167,8) as CO_GRAU_ACADEMICO,
substring(dados,1175,12) as DS_GRAU_ACADEMICO,
substring(dados,1187,8) as CO_MODALIDADE_ENSINO,
substring(dados,1195,11) as DS_MODALIDADE_ENSINO,
substring(dados,1206,8) as CO_NIVEL_ACADEMICO,
substring(dados,1214,33) as DS_NIVEL_ACADEMICO,
substring(dados,1247,8) as IN_GRATUITO,
substring(dados,1255,8) as TP_ATRIBUTO_INGRESSO,
substring(dados,1263,9) as CO_LOCAL_OFERTA,
substring(dados,1272,8) as NU_CARGA_HORARIA,
substring(dados,1280,38) as DT_INICIO_FUNCIONAMENTO,
substring(dados,1318,38) as DT_AUTORIZACAO_CURSO,
substring(dados,1356,8) as IN_AJUDA_DEFICIENTE,
substring(dados,1364,8) as IN_MATERIAL_DIGITAL,
substring(dados,1372,8) as IN_MATERIAL_IMPRESSO,
substring(dados,1380,8) as IN_MATERIAL_AUDIO,
substring(dados,1388,8) as IN_MATERIAL_BRAILLE,
substring(dados,1396,8) as IN_DISCIPLINA_LIBRAS,
substring(dados,1404,8) as IN_GUIA_INTERPRETE,
substring(dados,1412,8) as IN_MATERIAL_LIBRAS,
substring(dados,1420,8) as IN_TRADUTOR_LIBRAS,
substring(dados,1428,8) as IN_INTEGRAL_CURSO,
substring(dados,1436,8) as IN_MATUTINO_CURSO,
substring(dados,1444,8) as IN_NOTURNO_CURSO,
substring(dados,1452,8) as IN_VESPERTINO_CURSO,
substring(dados,1460,8) as IN_MATERIAL_AMPLIADO,
substring(dados,1468,8) as IN_MATERIAL_TATIL,
substring(dados,1476,8) as IN_RECURSOS_COMUNICACAO,
substring(dados,1484,8) as IN_RECURSOS_INFORMATICA,
substring(dados,1492,8) as NU_PERC_CARGA_HOR_DISTANCIA,
substring(dados,1500,8) as NU_INTEGRALIZACAO_MATUTINO,
substring(dados,1508,8) as NU_INTEGRALIZACAO_VESPERTINO,
substring(dados,1516,8) as NU_INTEGRALIZACAO_NOTURNO,
substring(dados,1524,8) as NU_INTEGRALIZACAO_INTEGRAL,
substring(dados,1532,8) as IN_OFERECE_DISC_DISTANCIA,
substring(dados,1540,8) as IN_POSSUI_LABORATORIO,
substring(dados,1548,8) as QT_MATRICULA_CURSO,
substring(dados,1556,8) as QT_CONCLUINTE_CURSO,
substring(dados,1564,8) as QT_INGRESSO_CURSO,
substring(dados,1572,8) as QT_INGRESSO_PROCESSO_SELETIVO,
substring(dados,1580,8) as QT_INGRESSO_OUTRA_FORMA,
substring(dados,1588,8) as QT_INSCRITOS_ANO_EAD,
substring(dados,1596,8) as QT_VAGAS_ANUAL_EAD,
substring(dados,1604,8) as QT_VAGAS_INTEGRAL_PRES,
substring(dados,1612,8) as QT_VAGAS_MATUTINO_PRES,
substring(dados,1620,8) as QT_VAGAS_VESPERTINO_PRES,
substring(dados,1628,8) as QT_VAGAS_NOTURNO_PRES,
substring(dados,1636,8) as QT_INSCRITOS_MATUTINO_PRES,
substring(dados,1644,8) as QT_INSCRITOS_VESPERTINO_PRES,
substring(dados,1652,8) as QT_INSCRITOS_NOTURNO_PRES,
substring(dados,1660,8) as QT_INSCRITOS_INTEGRAL_PRES,
substring(dados,1668,8) as NU_INTEGRALIZACAO_EAD
from IES_2011_CURSO_BLOCO;


select * from IES_2011_CURSO_BLOCO;
select * from IES_2011_CURSO;


