use dataviva_raw;

rename table IES_2012_CURSO to IES_2012_CURSO_T1;

drop table if exists IES_2012_CURSO_BLOCO;
drop table if exists IES_2012_CURSO;
create table IES_2012_CURSO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2012/DADOS/CURSO.txt'
into table IES_2012_CURSO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2012_CURSO select 
substring(dados,1,8) as CO_IES,
substring(dados,9,200) as NO_IES,
substring(dados,209,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,217,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,317,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,325,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,425,8) as CO_MUNICIPIO_CURSO,
substring(dados,433,150) as NO_MUNICIPIO_CURSO,
substring(dados,583,8) as CO_UF_CURSO,
substring(dados,591,2) as SGL_UF_CURSO,
substring(dados,593,30) as NO_REGIAO_CURSO,
substring(dados,623,8) as IN_CAPITAL_CURSO,
substring(dados,631,8) as CO_CURSO,
substring(dados,639,200) as NO_CURSO,
substring(dados,839,12) as CO_OCDE,
substring(dados,851,120) as NO_OCDE,
substring(dados,971,12) as CO_OCDE_AREA_GERAL,
substring(dados,983,120) as NO_OCDE_AREA_GERAL,
substring(dados,1103,12) as CO_OCDE_AREA_ESPECIFICA,
substring(dados,1115,120) as NO_OCDE_AREA_ESPECIFICA,
substring(dados,1235,12) as CO_OCDE_AREA_DETALHADA,
substring(dados,1247,120) as NO_OCDE_AREA_DETALHADA,
substring(dados,1367,8) as CO_GRAU_ACADEMICO,
substring(dados,1375,12) as DS_GRAU_ACADEMICO,
substring(dados,1387,8) as CO_MODALIDADE_ENSINO,
substring(dados,1395,11) as DS_MODALIDADE_ENSINO,
substring(dados,1406,8) as CO_NIVEL_ACADEMICO,
substring(dados,1414,33) as DS_NIVEL_ACADEMICO,
substring(dados,1447,8) as IN_GRATUITO,
substring(dados,1455,8) as TP_ATRIBUTO_INGRESSO,
substring(dados,1463,8) as CO_LOCAL_OFERTA,
substring(dados,1471,8) as NU_CARGA_HORARIA,
substring(dados,1479,38) as DT_INICIO_FUNCIONAMENTO,
substring(dados,1517,38) as DT_AUTORIZACAO_CURSO,
substring(dados,1555,8) as IN_AJUDA_DEFICIENTE,
substring(dados,1563,8) as IN_MATERIAL_DIGITAL,
substring(dados,1571,8) as IN_MATERIAL_AMPLIADO,
substring(dados,1579,8) as IN_MATERIAL_TATIL,
substring(dados,1587,8) as IN_MATERIAL_IMPRESSO,
substring(dados,1595,8) as IN_MATERIAL_AUDIO,
substring(dados,1603,8) as IN_MATERIAL_BRAILLE,
substring(dados,1611,8) as IN_DISCIPLINA_LIBRAS,
substring(dados,1619,8) as IN_GUIA_INTERPRETE,
substring(dados,1627,8) as IN_MATERIAL_LIBRAS,
substring(dados,1635,8) as IN_RECURSOS_COMUNICACAO,
substring(dados,1643,8) as IN_RECURSOS_INFORMATICA,
substring(dados,1651,8) as IN_TRADUTOR_LIBRAS,
substring(dados,1659,8) as IN_INTEGRAL_CURSO,
substring(dados,1667,8) as IN_MATUTINO_CURSO,
substring(dados,1675,8) as IN_NOTURNO_CURSO,
substring(dados,1683,8) as IN_VESPERTINO_CURSO,
substring(dados,1691,8) as NU_PERC_CARGA_HOR_DISTANCIA,
substring(dados,1699,8) as NU_INTEGRALIZACAO_MATUTINO,
substring(dados,1707,8) as NU_INTEGRALIZACAO_VESPERTINO,
substring(dados,1715,8) as NU_INTEGRALIZACAO_NOTURNO,
substring(dados,1723,8) as NU_INTEGRALIZACAO_INTEGRAL,
substring(dados,1731,8) as NU_INTEGRALIZACAO_EAD,
substring(dados,1739,8) as IN_OFERECE_DISC_DISTANCIA,
substring(dados,1747,8) as IN_POSSUI_LABORATORIO,
substring(dados,1755,8) as QT_INSCRITOS_ANO_EAD,
substring(dados,1763,8) as QT_VAGAS_ANUAL_EAD,
substring(dados,1771,8) as QT_VAGAS_INTEGRAL_PRES,
substring(dados,1779,8) as QT_VAGAS_MATUTINO_PRES,
substring(dados,1787,8) as QT_VAGAS_VESPERTINO_PRES,
substring(dados,1795,8) as QT_VAGAS_NOTURNO_PRES,
substring(dados,1803,8) as QT_INSCRITOS_MATUTINO_PRES,
substring(dados,1811,8) as QT_INSCRITOS_VESPERTINO_PRES,
substring(dados,1819,8) as QT_INSCRITOS_NOTURNO_PRES,
substring(dados,1827,8) as QT_INSCRITOS_INTEGRAL_PRES,
substring(dados,1835,8) as QT_MATRICULA_CURSO,
substring(dados,1843,8) as QT_CONCLUINTE_CURSO,
substring(dados,1851,8) as QT_INGRESSO_CURSO,
substring(dados,1859,8) as QT_INGRESSO_PROCESSO_SELETIVO,
substring(dados,1867,8) as QT_INGRESSO_OUTRA_FORMA
from IES_2012_CURSO_BLOCO;

select * from IES_2012_CURSO;


