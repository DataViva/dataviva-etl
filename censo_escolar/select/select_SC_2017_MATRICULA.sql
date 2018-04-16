/* 
	Transformações nos dados do Censo Escolar a partir da tabela
	SC_2017_MATRICULA 
*/

use dataviva_raw;

/*
	A tabela SC_2017_MATRICULA_STEP1 é criada para o passo 1 das
	transformações.
*/
drop table if exists SC_2017_MATRICULA_STEP1;

create table SC_2017_MATRICULA_STEP1 (
	ANO_CENSO varchar(8),
	CO_REGIAO varchar(1),
	CO_MESORREGIAO varchar(4),
	CO_MICRORREGIAO varchar(5),
	CO_UF varchar(2),
	COD_MUNICIPIO varchar(20),
	COD_CURSO_PROF varchar(5),
	COD_ENTIDADE varchar(12),
	COD_TURMA varchar(14),
	DEPENDENCIA_ADM varchar(1),
	IDADE int(3),
	SEXO varchar(1),
	TP_COR_RACA varchar(2),
	COD_MATRICULA  int(16),
	COD_ETAPA_ENSINO_A int(10)
);

/*
	São mantidos apenas os registros de alunos com matrícula em
	turma diferente de Atividade Complementar.
*/	
INSERT INTO SC_2017_MATRICULA_STEP1
select NU_ANO_CENSO, CO_REGIAO, CO_MESORREGIAO, CO_MICRORREGIAO, CO_UF, CO_MUNICIPIO,
	if(CO_CURSO_EDUC_PROFISSIONAL = '', null, CO_CURSO_EDUC_PROFISSIONAL), CO_ENTIDADE, ID_TURMA, TP_DEPENDENCIA,
	NU_IDADE, TP_SEXO, TP_COR_RACA, ID_MATRICULA, if(TP_ETAPA_ENSINO = '', null, TP_ETAPA_ENSINO)
from SC_2017_MATRICULA
where TP_TIPO_TURMA != '4';

/*
	A tabela SC_2017_MATRICULA_STEP2 é criada para o passo 2 das
	transformações.
*/
drop table if exists SC_2017_MATRICULA_STEP2;

create table SC_2017_MATRICULA_STEP2 select * from SC_2017_MATRICULA_STEP1;

-- A codificação de gêneros é modificada.
update SC_2017_MATRICULA_STEP2 set SEXO = if(SEXO = 2, 0, 1);

-- A codificação de etnias é modificada.
create table etnia(FONTE varchar(1), COR_RACA int(1));

insert into etnia values(0,-1),(1,2),(2,4),(3,8),(4,6),(5,1);

alter table SC_2017_MATRICULA_STEP2 add COR_RACA varchar(2);

update SC_2017_MATRICULA_STEP2 left join etnia
on SC_2017_MATRICULA_STEP2.TP_COR_RACA = etnia.FONTE
set SC_2017_MATRICULA_STEP2.COR_RACA = etnia.COR_RACA;

drop table etnia;

alter table SC_2017_MATRICULA_STEP2 drop TP_COR_RACA;

/*
	Os códigos da etapa de ensino são alterados de acordo com 
	mapeamento armazenado no serviço Amazon S3.
*/	
create table etapa_ensino(FONTE int(10), COD_ETAPA_ENSINO int(10));

load data local infile '/home/dev1/Documents/Correspondencias_Classificacoes/ensino_tecnico/codigo_etapa_ensino_2017.txt'
into table etapa_ensino
character set 'utf8'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

alter table SC_2017_MATRICULA_STEP2 add COD_ETAPA_ENSINO int(10);

update SC_2017_MATRICULA_STEP2 left join etapa_ensino
on SC_2017_MATRICULA_STEP2.COD_ETAPA_ENSINO_A = etapa_ensino.FONTE
set SC_2017_MATRICULA_STEP2.COD_ETAPA_ENSINO = etapa_ensino.COD_ETAPA_ENSINO;

drop table etapa_ensino;

alter table SC_2017_MATRICULA_STEP2 drop COD_ETAPA_ENSINO_A;

/*
	A tabela SC_2017_MATRICULA_STEP3 é criada para o passo 3 das
	transformações. São removidos os registros com etapas de ensino
	iguais a EJA, Educação Infantil e NULL.
*/
drop table if exists SC_2017_MATRICULA_STEP3;

create table SC_2017_MATRICULA_STEP3
select * from SC_2017_MATRICULA_STEP2
where COD_ETAPA_ENSINO not in (1,7);

/*
	O dígito 0 é adicionado à esquerda dos códigos de
	curso que apresentam apenas 4 dígitos.
*/	
update dataviva_raw.SC_2017_MATRICULA_STEP3
set COD_CURSO_PROF = concat('0', COD_CURSO_PROF)
where length(COD_CURSO_PROF) = 4;

/*
	Ensinos Fundamental 1, Fundamental 2 e Médio recebem
	códigos de curso (xx002, xx003 e xx004, respectivamente).
*/
update dataviva_raw.SC_2017_MATRICULA_STEP3
set COD_CURSO_PROF = concat('xx00', COD_ETAPA_ENSINO)
where COD_CURSO_PROF is null and
(COD_ETAPA_ENSINO = 2 or COD_ETAPA_ENSINO = 3 or COD_ETAPA_ENSINO = 4);

/*
	A tabela SC_2017_MATRICULA_STEP4 é criada para o passo 4 das
	transformações. Os dados são preparados para inserção no
	banco Amazon Redshift.
*/
CREATE TABLE SC_2017_MATRICULA_STEP4 (
	year integer,
	region varchar(1),
	mesoregion varchar(4),
	microregion varchar(5),
	state varchar(2),
	municipality varchar(7),
	sc_course_field varchar(2),
	sc_course varchar(5),
	sc_school varchar(8),
	sc_class varchar(8),
	administrative_dependency varchar(1),
	age integer,
	gender varchar(1),
	ethnicity varchar(2)
);

INSERT INTO SC_2017_MATRICULA_STEP4 (
	year, region, mesoregion, microregion, state, municipality, sc_course_field, sc_course,
	sc_school, sc_class, administrative_dependency, age, gender, ethnicity)
SELECT 2017, CO_REGIAO, CO_MESORREGIAO, CO_MICRORREGIAO, CO_UF, COD_MUNICIPIO,
	substring(COD_CURSO_PROF, 1, 2 ), COD_CURSO_PROF, COD_ENTIDADE, COD_TURMA, DEPENDENCIA_ADM,
	IDADE, SEXO, COR_RACA
FROM SC_2017_MATRICULA_STEP3;

-- Verificações

select count(*) from SC_2017_MATRICULA_STEP4;

select year, count(*) from SC_2017_MATRICULA_STEP4 group by year;

select age, count(*) from SC_2017_MATRICULA_STEP4 group by age;

select gender, count(*) from SC_2017_MATRICULA_STEP4 group by gender;

select municipality, count(*) from SC_2017_MATRICULA_STEP4 group by municipality;

select administrative_dependency, count(*) from SC_2017_MATRICULA_STEP4 group by administrative_dependency;

select ethnicity, count(*) from SC_2017_MATRICULA_STEP4 group by ethnicity;

select sc_course, count(*) from SC_2017_MATRICULA_STEP4 group by sc_course;

-- Matrículas

-- Ensino fundamental
select state, administrative_dependency, count(*) from SC_2017_MATRICULA_STEP4
where sc_course = 'xx002' or sc_course = 'xx003' group by state, administrative_dependency;	

select state, gender, count(*) from SC_2017_MATRICULA_STEP4 where sc_course = 'xx002' or sc_course = 'xx003'
group by state, gender order by gender,state;

select state, ethnicity, count(*) from SC_2017_MATRICULA_STEP4 where sc_course = 'xx002' or sc_course = 'xx003'
group by state, ethnicity order by ethnicity,state;

/*
	Ensino médio
	DataViva não considera curso técnico integrado (ensino médio
	integrado) nos dados de ensino médio.  Consequentemente, a 
	validação deve ser feita considerando-se a diferença entre o
	número de matrículas no ensino médio e o número de matrículas
	em curso técnico integrado (ensino médio integrado).
*/
select state, administrative_dependency, count(*) from SC_2017_MATRICULA_STEP4
where sc_course = 'xx004' group by state, administrative_dependency;


/* 
	Ensino profissionalizante
	Para validação de matrículas em cursos profissionalizantes, 
	deve-se considerar a soma dos seguintes dados da sinopse: 
	curso técnico integrado (ensino médio integrado), curso
	técnico-concomitante e curso técnico-subsequente. Dados
	de cursos FIC (formação inicial e continuada) não foram
	incluídos na plataforma DataViva. 
*/	
select state, administrative_dependency, count(*) from SC_2017_MATRICULA_STEP4 where sc_course_field != 'xx' 
group by state, administrative_dependency order by administrative_dependency, state;

-- Estabelecimentos

-- Ensino fundamental
select state, count(distinct sc_school) from SC_2017_MATRICULA_STEP4
where (sc_course = 'xx003' or sc_course = 'xx002') group by state order by state;

-- Turmas

-- Ensino fundamental
select state, count(distinct sc_class) from SC_2017_MATRICULA_STEP4
where (sc_course = 'xx003' or sc_course = 'xx002') group by state order by state;

-- Ensino médio (vide comentários feitos anteriormente)
select state, count(distinct sc_class) from SC_2017_MATRICULA_STEP4 where (sc_course = 'xx004')
group by state order by state;

-- Ensino profissionalizante (vide comentários feitos anteriormente)
select state, count(distinct sc_class) from SC_2017_MATRICULA_STEP4 where (sc_course_field != 'xx')
group by state order by state;