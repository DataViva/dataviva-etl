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

drop table if exists attrs_ybs;
create table attrs_ybs(
    year integer,
    bra_id varchar (9),
    stat_id varchar(10),
    stat_val float
);