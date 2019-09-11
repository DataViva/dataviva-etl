-- Processo de atualização dos dados gerais da aplicação (PIB, PIB per capita e População)
-- A ser executado no banco de ETL para depois ser exportado para o banco da aplicação

-- Tabela para carregar os dados
drop table if exists IBGE_2016;
create table IBGE_2016(
    year integer,
    ibge_id varchar (7),
    bra_id varchar (9),
    region_id varchar (1),
    region varchar (20),
    state_id integer,
    state varchar (2),
    municipality varchar (200),
    mesoregion_id varchar (4),
    microregion_id varchar (5),
    microregion varchar (200),
    gdp float(18,3),
    pop integer,
    gdp_pc float(18,2)
);

load data local infile 'ibge_data.csv'
into table IBGE_2016
character set 'latin1'
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;

-- Tabela final que após o processo pode ser importada no banco da aplicação
drop table if exists attrs_ybs;
create table attrs_ybs(
    year integer,
    bra_id varchar (9),
    stat_id varchar(10),
    stat_val float
);

-- Dados de PIB
insert into attrs_ybs
select
    year,
    LOWER(bra_id),
    'gdp',
    gdp
from IBGE_2016;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,3)) as bra_id,
    'gdp' as stat_id,
    SUM(gdp) as stat_val
from IBGE_2016
GROUP BY state;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,1)) as bra_id,
    'gdp' as stat_id,
    SUM(gdp) as stat_val
from IBGE_2016
GROUP BY region_id;

-- Dados de PIB per capita
insert into attrs_ybs
select
    year,
    LOWER(bra_id),
    'gdp_pc',
    gdp_pc
from IBGE_2016;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,3)) as bra_id,
    'gdp_pc' as stat_id,
    AVG(gdp_pc) as stat_val
from IBGE_2016
GROUP BY state;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,1)) as bra_id,
    'gdp_pc' as stat_id,
    AVG(gdp_pc) as stat_val
from IBGE_2016
GROUP BY region_id;

-- Dados de população
insert into attrs_ybs
select
    year,
    LOWER(bra_id),
    'pop',
    pop
from IBGE_2016;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,3)) as bra_id,
    'pop' as stat_id,
    SUM(pop) as stat_val
from IBGE_2016
GROUP BY state;

insert into attrs_ybs
select
    year,
    LOWER(SUBSTRING(bra_id,1,1)) as bra_id,
    'pop' as stat_id,
    SUM(pop) as stat_val
from IBGE_2016
GROUP BY region_id;

-- exportar dados da tabela
-- mysqldump -h <database_host> -u dataviva -p --database=dataviva attrs_ybs > attrs_ybs.sql

-- importar os dados no banco de destino
-- mysql -h <database_host> -u dataviva -p --database=dataviva  < attrs_ybs.sql
