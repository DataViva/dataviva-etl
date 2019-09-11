load data local infile 'ibge_data.csv'
into table IBGE_2016
character set 'latin1'
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;

-- GDP data
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

-- GDP per capita data
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

-- Population data
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