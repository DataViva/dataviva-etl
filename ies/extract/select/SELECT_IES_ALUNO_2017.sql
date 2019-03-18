use dataviva_raw;
drop table if exists IES_2017_ALUNO_STEP1;
Create table IES_2017_ALUNO_STEP1 (    
    CO_IES varchar(5),
    CO_CATEGORIA_ADMINISTRATIVA varchar(1),
    CO_ORGANIZACAO_ACADEMICA varchar(1),
    CO_CURSO int(8),
    CO_ALUNO varchar(12),
    CO_GRAU_ACADEMICO varchar(2),
    CO_MODALIDADE_ENSINO varchar(1),
    IN_CONCLUINTE varchar(1),
    IN_INGRESSO_TOTAL varchar(1),
    ANO_INGRESSO varchar(4), 
    MES_INGRESSO varchar(2), 
    IN_SEXO_ALUNO varchar(2),
    NU_IDADE_ALUNO int(8),
    CO_COR_RACA_ALUNO varchar(2),
    CO_UF_NASCIMENTO varchar(2), 
    CO_MUNICIPIO_NASCIMENTO varchar(7),
    CO_TURNO_ALUNO varchar(2)
);

insert into IES_2017_ALUNO_STEP1
select CO_IES, 
       if(TP_CATEGORIA_ADMINISTRATIVA = '7', '3', TP_CATEGORIA_ADMINISTRATIVA),
       if(TP_ORGANIZACAO_ACADEMICA = '5', '4', TP_ORGANIZACAO_ACADEMICA),
       CO_CURSO,
       CO_ALUNO,
       if(TP_GRAU_ACADEMICO = '', '-1', TP_GRAU_ACADEMICO),
       TP_MODALIDADE_ENSINO,
       IN_CONCLUINTE,
       IN_INGRESSO_TOTAL,
       substring(DT_INGRESSO_CURSO, 7, 4),
       substring(DT_INGRESSO_CURSO, 4, 2),
       TP_SEXO,
       NU_IDADE,
       if(TP_COR_RACA = '0' or TP_COR_RACA = '9', '-1', TP_COR_RACA),
       if(CO_UF_NASCIMENTO = '', '-1', CO_UF_NASCIMENTO),
       if(CO_MUNICIPIO_NASCIMENTO = '', '-1', CO_MUNICIPIO_NASCIMENTO),
       if(TP_TURNO = '', '-1', TP_TURNO)
from IES_2017_ALUNO
where IN_MATRICULA = 1 and TP_NIVEL_ACADEMICO = 1;   

/*
	A tabela IES_2016_CURSO_STEP1 é criada para o passo 1 
    das transformações.
*/
drop table if exists IES_2017_CURSO_STEP1;

create table IES_2017_CURSO_STEP1 (
    CO_MUNICIPIO varchar(7),
    CO_UF varchar(2),
    CO_CURSO int(8),
    CO_OCDE varchar(6),
    CO_LOCAL_OFERTA varchar(7)
);

insert into IES_2017_CURSO_STEP1
select if(CO_MUNICIPIO = '', '-1', CO_MUNICIPIO),
       CO_UF,
       CO_CURSO,
       if(CO_OCDE = '', '-1', CO_OCDE),
       if(CO_LOCAL_OFERTA = '', '-1', CO_LOCAL_OFERTA)
from IES_2017_CURSO;       

/*
	A tabela IES_2016_ALUNO_STEP2 é criada para o passo 2 
    das transformações.
*/
drop table if exists IES_2017_ALUNO_STEP2;

create table IES_2017_ALUNO_STEP2 select * from IES_2017_ALUNO_STEP1;

/*
    As tabelas IES_2016_ALUNO_STEP2 e IES_2016_CURSO_STEP1
    são associadas. 
*/
alter table IES_2017_ALUNO_STEP2 add (CO_MUNICIPIO_CURSO varchar(7), CO_UF_CURSO varchar(2), CO_OCDE varchar(6), CO_LOCAL_OFERTA_CURSO varchar(7));

update IES_2017_ALUNO_STEP2 left join IES_2017_CURSO_STEP1
on IES_2017_ALUNO_STEP2.CO_CURSO = IES_2017_CURSO_STEP1.CO_CURSO
set IES_2017_ALUNO_STEP2.CO_MUNICIPIO_CURSO = IES_2017_CURSO_STEP1.CO_MUNICIPIO,
    IES_2017_ALUNO_STEP2.CO_UF_CURSO = IES_2017_CURSO_STEP1.CO_UF,
    IES_2017_ALUNO_STEP2.CO_OCDE = IES_2017_CURSO_STEP1.CO_OCDE,
    IES_2017_ALUNO_STEP2.CO_LOCAL_OFERTA_CURSO = IES_2017_CURSO_STEP1.CO_LOCAL_OFERTA;

   /* Consultas para validação com a sinopse do INEP, disponível em
    http://portal.inep.gov.br/web/guest/sinopses-estatisticas */

select CO_MODALIDADE_ENSINO, count(*) from IES_2017_ALUNO_STEP2 group by CO_MODALIDADE_ENSINO;
select count(*) from IES_2016_ALUNO_STEP2 where CO_MODALIDADE_ENSINO = 1;
select CO_IES, count(*) from IES_2017_ALUNO_STEP2 group by CO_IES;
select CO_CATEGORIA_ADMINISTRATIVA, count(*) from IES_2017_ALUNO_STEP2 where CO_MODALIDADE_ENSINO = 1 group by CO_CATEGORIA_ADMINISTRATIVA;
select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2017_ALUNO_STEP2 where CO_MODALIDADE_ENSINO = 1 group by CO_ORGANIZACAO_ACADEMICA;
select CO_CURSO, count(*) from IES_2017_ALUNO_STEP2 group by CO_CURSO;
select CO_GRAU_ACADEMICO, count(*) from IES_2017_ALUNO_STEP2 where CO_MODALIDADE_ENSINO = 1 group by CO_GRAU_ACADEMICO;
select IN_CONCLUINTE, CO_CURSO, count(*) from IES_2017_ALUNO_STEP2 where CO_MODALIDADE_ENSINO = 1 and IN_CONCLUINTE group by IN_CONCLUINTE, CO_CURSO;
select IN_INGRESSO_TOTAL, count(*) from IES_2017_ALUNO_STEP2 group by IN_INGRESSO_TOTAL;
select IN_SEXO_ALUNO, count(*) from IES_2017_ALUNO_STEP2 group by IN_SEXO_ALUNO;
select NU_IDADE_ALUNO, count(*) from IES_2017_ALUNO_STEP2 group by NU_IDADE_ALUNO;
select CO_COR_RACA_ALUNO, count(*) from IES_2017_ALUNO_STEP2 group by CO_COR_RACA_ALUNO;
select CO_UF_NASCIMENTO, count(*) from IES_2017_ALUNO_STEP2 group by CO_UF_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2017_ALUNO_STEP2 group by CO_MUNICIPIO_NASCIMENTO;
select CO_TURNO_ALUNO, count(*) from IES_2017_ALUNO_STEP2 group by CO_TURNO_ALUNO;
select CO_MUNICIPIO_CURSO, count(*) from IES_2017_ALUNO_STEP2 group by CO_MUNICIPIO_CURSO;
select CO_OCDE, count(*) from IES_2017_ALUNO_STEP2 group by CO_OCDE;
select CO_LOCAL_OFERTA_CURSO, count(*) from IES_2017_ALUNO_STEP2 group by CO_LOCAL_OFERTA_CURSO;
select ANO_INGRESSO, count(*) from IES_2017_ALUNO_STEP2 group by ANO_INGRESSO;
select MES_INGRESSO, count(*) from IES_2017_ALUNO_STEP2 group by MES_INGRESSO;

/*
	A tabela IES_2016_ALUNO_STEP3 é criada para o passo 3 
    das transformações.
*/
drop table if exists IES_2017_ALUNO_STEP3;

create table IES_2017_ALUNO_STEP3 select * from IES_2017_ALUNO_STEP2;

/* 
    Códigos de municípios, mesorregiões e microrregiões do IBGE 
    (ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/)
    são carregados na tabela MUNICIPIOS_REGIOES_2016 e depois 
    incorporados à tabela IES_2016_ALUNO_STEP3.
*/    
drop table if exists MUNICIPIOS_REGIOES_2017;


create table MUNICIPIOS_REGIOES_2017 (
    CO_REGIAO varchar(1),
    CO_UF varchar(2),
    CO_MESORREGIAO varchar(4),
    CO_MICRORREGIAO varchar(5),
    CO_MUNICIPIO varchar(7)
);

load data local infile 'C:/Users/E003004/Desktop/Municipios_Micro_Meso_Regioes.csv'
into table MUNICIPIOS_REGIOES_2017
character set 'latin1'
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines;

alter table IES_2017_ALUNO_STEP3 add (CO_REGIAO varchar(1), CO_MESORREGIAO varchar(4), CO_MICRORREGIAO varchar(5));

update IES_2017_ALUNO_STEP3 left join MUNICIPIOS_REGIOES_2017
on IES_2017_ALUNO_STEP3.CO_MUNICIPIO_CURSO = MUNICIPIOS_REGIOES_2017.CO_MUNICIPIO
set IES_2017_ALUNO_STEP3.CO_REGIAO = MUNICIPIOS_REGIOES_2017.CO_REGIAO,
    IES_2017_ALUNO_STEP3.CO_MESORREGIAO = MUNICIPIOS_REGIOES_2017.CO_MESORREGIAO,
    IES_2017_ALUNO_STEP3.CO_MICRORREGIAO = MUNICIPIOS_REGIOES_2017.CO_MICRORREGIAO;

/*
    Para registros com valores de CO_MUNICIPIO_CURSO iguais a -1,
    os valores de CO_REGIAO, CO_MICRORREGIAO e CO_MESORREGIAO são
    preenchidos com espaço em branco.
*/    
update IES_2017_ALUNO_STEP3
set CO_REGIAO = '',
    CO_MICRORREGIAO = '',
    CO_MESORREGIAO = ''
where CO_MUNICIPIO_CURSO = '-1';    

/*
	A tabela IES_2016_ALUNO_STEP4 é criada para o passo 4 das
	transformações. Os dados são preparados para inserção no
	banco Amazon Redshift.
*/
drop table if exists IES_2017_ALUNO_STEP4;

create table dataviva_raw.IES_2017_ALUNO_STEP4 (
year integer,
region varchar(1),
mesoregion varchar(4),
microregion varchar(5),
state varchar(2),
municipality varchar(7),
university varchar(5),
university_campus varchar(7),
funding_type varchar(1),
school_type varchar(1),
hedu_course_field varchar(6),
hedu_course varchar(6),
enrolled varchar(12),
graduate varchar(1),
entrant varchar(1),
academic_degree varchar(2),
distance_learning varchar(1),
shift varchar(2),
gender varchar(2),
age integer,
ethnicity varchar(2),
state_of_birth varchar(2),
municipality_of_birth varchar(7),
admission_year varchar(4),
admission_month varchar(2),
hidden boolean
); 

insert into IES_2017_ALUNO_STEP4 (
	year, region, mesoregion, microregion, state, municipality, university, university_campus,
	funding_type,school_type,hedu_course_field,hedu_course, enrolled, graduate, entrant,
	academic_degree, distance_learning, shift, gender, age, ethnicity, state_of_birth,
	municipality_of_birth, admission_year, admission_month, hidden)
select 2017, CO_REGIAO, CO_MESORREGIAO, CO_MICRORREGIAO, CO_UF_CURSO, CO_MUNICIPIO_CURSO, lpad(CO_IES, 5, '0'), CO_LOCAL_OFERTA_CURSO, 
    CO_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, substring( CO_OCDE, 1, 2 ), CO_OCDE, CO_ALUNO, IN_CONCLUINTE, IN_INGRESSO_TOTAL,
	CO_GRAU_ACADEMICO, CO_MODALIDADE_ENSINO, CO_TURNO_ALUNO, IN_SEXO_ALUNO, NU_IDADE_ALUNO, CO_COR_RACA_ALUNO, CO_UF_NASCIMENTO,
    CO_MUNICIPIO_NASCIMENTO, ANO_INGRESSO, trim(leading '0' from MES_INGRESSO), true   
from IES_2017_ALUNO_STEP3;