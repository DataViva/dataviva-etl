-- Select DOCENTES

create table IES_2016_DOCENTE_STEP1 
select CO_IES, CO_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, CO_DOCENTE,
CO_SITUACAO_DOCENTE, CO_ESCOLARIDADE_DOCENTE, CO_REGIME_TRABALHO, IN_SEXO_DOCENTE, 
NU_IDADE_DOCENTE, CO_COR_RACA_DOCENTE, CO_UF_NASCIMENTO, CO_MUNICIPIO_NASCIMENTO, IN_ATU_PESQUISA,
IN_ATU_POS_PRESENCIAL
from IES_2016_DOCENTE;


create table IES_2016_IES_STEP1 
select CO_IES, CO_MANTENEDORA, CO_MUNICIPIO_IES, CO_UF_IES, QT_TEC_TOTAL, IN_REFERENTE, VL_RECEITA_PROPRIA,
VL_TRANSFERENCIA, VL_OUTRA_RECEITA, VL_DES_PESSOAL_REM_DOCENTE, VL_DES_PESSOAL_REM_TECNICO,
VL_DES_PESSOAL_ENCARGO, VL_DES_CUSTEIO, VL_DES_INVESTIMENTO, VL_DES_PESQUISA, VL_DES_OUTRAS
from IES_2016_IES;

create table IES_2016_DOCENTE_STEP2 select * from IES_2016_DOCENTE_STEP1;

alter table IES_2016_DOCENTE_STEP2 add (
CO_MANTENEDORA varchar(8), 
CO_MUNICIPIO_IES varchar(8), 
CO_UF varchar(8), 
QT_TEC_TOTAL varchar(8), 
IN_REFERENTE varchar(8), 
VL_RECEITA_PROPRIA varchar(14),
VL_TRANSFERENCIA varchar(14),
VL_OUTRA_RECEITA varchar(14), 
VL_DES_PESSOAL_REM_DOCENTE varchar(14), 
VL_DES_PESSOAL_REM_TECNICO varchar(14),
VL_DES_PESSOAL_ENCARGO varchar(14), 
VL_DES_CUSTEIO varchar(14), 
VL_DES_INVESTIMENTO varchar(14), 
VL_DES_PESQUISA varchar(14), 
VL_DES_OUTRAS varchar(14));

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.CO_MANTENEDORA = IES_2016_IES_STEP1.CO_MANTENEDORA;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.CO_MUNICIPIO_IES = IES_2016_IES_STEP1.CO_MUNICIPIO_IES;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.CO_UF = IES_2016_IES_STEP1.CO_UF_IES;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.QT_TEC_TOTAL = IES_2016_IES_STEP1.QT_TEC_TOTAL;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.IN_REFERENTE = IES_2016_IES_STEP1.IN_REFERENTE;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_RECEITA_PROPRIA = IES_2016_IES_STEP1.VL_RECEITA_PROPRIA;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_TRANSFERENCIA = IES_2016_IES_STEP1.VL_TRANSFERENCIA;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_OUTRA_RECEITA = IES_2016_IES_STEP1.VL_OUTRA_RECEITA;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_PESSOAL_REM_DOCENTE = IES_2016_IES_STEP1.VL_DES_PESSOAL_REM_DOCENTE;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_PESSOAL_REM_TECNICO = IES_2016_IES_STEP1.VL_DES_PESSOAL_REM_TECNICO;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_PESSOAL_ENCARGO = IES_2016_IES_STEP1.VL_DES_PESSOAL_ENCARGO;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_CUSTEIO = IES_2016_IES_STEP1.VL_DES_CUSTEIO;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_INVESTIMENTO = IES_2016_IES_STEP1.VL_DES_INVESTIMENTO;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_PESQUISA = IES_2016_IES_STEP1.VL_DES_PESQUISA;

update IES_2016_DOCENTE_STEP2 left join IES_2016_IES_STEP1 
on IES_2016_DOCENTE_STEP2.CO_IES = IES_2016_IES_STEP1.CO_IES
set IES_2016_DOCENTE_STEP2.VL_DES_OUTRAS = IES_2016_IES_STEP1.VL_DES_OUTRAS;

-- ---------------------------------------------------------------------------------------------
-- Recodificações

-- Categoria Administrativa
update IES_2016_DOCENTE_STEP2 set CO_CATEGORIA_ADMINISTRATIVA = 
if(CO_CATEGORIA_ADMINISTRATIVA = '7', '6', CO_CATEGORIA_ADMINISTRATIVA);

-- Organização Acadêmica
update IES_2016_DOCENTE_STEP2 set CO_ORGANIZACAO_ACADEMICA = 
if(CO_ORGANIZACAO_ACADEMICA = '5', '4', CO_ORGANIZACAO_ACADEMICA);

-- Regime de trabalho
update IES_2016_DOCENTE_STEP2 set CO_REGIME_TRABALHO = 
if(CO_REGIME_TRABALHO = '        ', '-1', CO_REGIME_TRABALHO);

-- COR-RACA
update IES_2016_DOCENTE_STEP2 set CO_COR_RACA_DOCENTE = 
if(CO_COR_RACA_DOCENTE = '0' OR CO_COR_RACA_DOCENTE='6', '-1', CO_COR_RACA_DOCENTE);

-- UF NASCIMENTO
update IES_2016_DOCENTE_STEP2 set CO_UF_NASCIMENTO = 
if(CO_UF_NASCIMENTO = '        ', '-1', CO_UF_NASCIMENTO);

-- MUNICIPIO NASCIMENTO
update IES_2016_DOCENTE_STEP2 set CO_MUNICIPIO_NASCIMENTO = 
if(CO_MUNICIPIO_NASCIMENTO = '        ', '-1', CO_MUNICIPIO_NASCIMENTO);

-- ATUA EM PESQUISA
update IES_2016_DOCENTE_STEP2 set IN_ATU_PESQUISA = 
if(IN_ATU_PESQUISA = '        ', '-1', IN_ATU_PESQUISA);

-- ATUA POS PRESENCIAL
update IES_2016_DOCENTE_STEP2 set IN_ATU_POS_PRESENCIAL = 
if(IN_ATU_POS_PRESENCIAL = '        ', '-1', IN_ATU_POS_PRESENCIAL);

-- Criando tabela final
drop table if exists IES_2016_DOCENTE_STEP3;
create table IES_2016_DOCENTE_STEP3 select * from IES_2016_DOCENTE_STEP2;

-- Retirando os espaços


alter table IES_2016_DOCENTE_STEP3 change VL_RECEITA_PROPRIA VL_RECEITA_PROPRIA double(14,2);
select distinct VL_RECEITA_PROPRIA from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_TRANSFERENCIA VL_TRANSFERENCIA double(14,2);
select distinct VL_TRANSFERENCIA from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_OUTRA_RECEITA VL_OUTRA_RECEITA double(14,2);
select distinct VL_OUTRA_RECEITA from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_PESSOAL_REM_DOCENTE VL_DES_PESSOAL_REM_DOCENTE double(14,2);
select distinct VL_DES_PESSOAL_REM_DOCENTE from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_PESSOAL_REM_TECNICO VL_DES_PESSOAL_REM_TECNICO double(14,2);
select distinct VL_DES_PESSOAL_REM_TECNICO from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_PESSOAL_ENCARGO VL_DES_PESSOAL_ENCARGO double(14,2);
select distinct VL_DES_PESSOAL_ENCARGO from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_CUSTEIO VL_DES_CUSTEIO double(14,2);
select distinct VL_DES_CUSTEIO from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_INVESTIMENTO VL_DES_INVESTIMENTO double(14,2);
select distinct VL_DES_INVESTIMENTO from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_PESQUISA VL_DES_PESQUISA double(14,2);
select distinct VL_DES_PESQUISA from IES_2016_DOCENTE_STEP3;

alter table IES_2016_DOCENTE_STEP3 change VL_DES_OUTRAS VL_DES_OUTRAS decimal(14,2);
select distinct VL_DES_OUTRAS from IES_2016_DOCENTE_STEP3;

-- Verificacao

select CO_IES, count(*) from IES_2016_DOCENTE_STEP3 group by CO_IES;
select CO_CATEGORIA_ADMINISTRATIVA, count(*) from IES_2016_DOCENTE_STEP3 group by CO_CATEGORIA_ADMINISTRATIVA;
select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2016_DOCENTE_STEP3 group by CO_ORGANIZACAO_ACADEMICA;
select CO_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by CO_DOCENTE;
select CO_SITUACAO_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by CO_SITUACAO_DOCENTE;
select CO_ESCOLARIDADE_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by CO_ESCOLARIDADE_DOCENTE;
select CO_REGIME_TRABALHO, count(*) from IES_2016_DOCENTE_STEP3 group by CO_REGIME_TRABALHO;
select IN_SEXO_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by IN_SEXO_DOCENTE;
select NU_IDADE_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by NU_IDADE_DOCENTE;
select CO_COR_RACA_DOCENTE, count(*) from IES_2016_DOCENTE_STEP3 group by CO_COR_RACA_DOCENTE;
select CO_UF_NASCIMENTO, count(*) from IES_2016_DOCENTE_STEP3 group by CO_UF_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2016_DOCENTE_STEP3 group by CO_MUNICIPIO_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2016_DOCENTE_STEP3 group by CO_MUNICIPIO_NASCIMENTO;
select IN_ATU_PESQUISA, count(*) from IES_2016_DOCENTE_STEP3 group by IN_ATU_PESQUISA;
select IN_ATU_POS_PRESENCIAL, count(*) from IES_2016_DOCENTE_STEP3 group by IN_ATU_POS_PRESENCIAL;
select CO_MANTENEDORA, count(*) from IES_2016_DOCENTE_STEP3 group by CO_MANTENEDORA;
select CO_MUNICIPIO_IES, count(*) from IES_2016_DOCENTE_STEP3 group by CO_MUNICIPIO_IES;
select CO_UF, count(*) from IES_2016_DOCENTE_STEP3 group by CO_UF;
select QT_TEC_TOTAL, count(*) from IES_2016_DOCENTE_STEP3 group by QT_TEC_TOTAL;
select IN_REFERENTE, count(*) from IES_2016_DOCENTE_STEP3 group by IN_REFERENTE;

-- Verificação, comparando com a Sinopse do INEP (disponível em http://portal.inep.gov.br/web/guest/sinopses-estatisticas - acessado em 05/02/2018)

-- Verificando IES por UF separado por categoria administrativa
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '11%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '12%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '13%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '14%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '15%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '16%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '17%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '21%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '22%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '23%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '24%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '25%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '26%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '27%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '28%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '29%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '31%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '32%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '33%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '35%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '41%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '42%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '43%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '50%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '51%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '52%' group by CO_CATEGORIA_ADMINISTRATIVA;
SELECT CO_CATEGORIA_ADMINISTRATIVA, count(distinct CO_IES) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '53%' group by CO_CATEGORIA_ADMINISTRATIVA;

-- Verificando o número de docentes por UF
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '11%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '12%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '13%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '14%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '15%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '16%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '17%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '21%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '22%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '23%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '24%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '25%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '26%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '27%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '28%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '29%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '31%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '32%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '33%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '35%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '41%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '42%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '43%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '50%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '51%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '52%';
SELECT count(*) FROM dataviva_raw.IES_2016_DOCENTE_STEP3 where CO_MUNICIPIO_IES like '53%';