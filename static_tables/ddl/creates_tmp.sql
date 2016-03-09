drop table stat_ybi;
create table stat_ybi(
    year varchar(4),
    bra_id varchar(9),
    cnae_id varchar(6),
    wage float,
    num_jobs int,
    num_est int,
    wage_avg float,
    rca float,
    distance float,
    opp_gain float,
    occupation_highest_jobs int,
    occupation_highest_jobs_id varchar(10),
    occupation_highest_monthly_wage float,
    occupation_highest_monthly_wage_id varchar(10),
    top_municipality_employment int ,
    top_municipality_employment_id varchar(10) ,
    top_municipality_monthly_wage float,
    top_municipality_monthly_wage_id varchar(10)
    
);

drop table stat_ybo;
create table stat_ybo(
    year varchar(4),
    bra_id varchar(9),
    cbo_id varchar(6),
    wage_avg float,
    wage float,
    num_jobs int,
    num_est int,
    top_municipality_employment int,
    top_municipality_employment_id varchar(10),
    top_municipality_monthly_wage float,
    top_municipality_monthly_wage_id varchar(10),
    industry_highest_jobs  int,
    industry_highest_jobs_id varchar(10),
    industry_highest_monthly_wage float,
    industry_highest_monthly_wage_id varchar(10)
    
);


-- products 
drop table stat_yb;
create table stat_ybp(
    year varchar(4),
    bra_id varchar(9),
    trade_balance float,
    export_val float,
    weight_value_export float,
    import_val float,
    weight_value_import float,
    pci float,
    rca float,
    distance float,
    opp_gain float,
    occupation_highest_monthly_wage float,
    occupation_highest_monthly_wage_id varchar(10),
    top_municipality_employment int ,
    top_municipality_employment_id varchar(10) ,
    top_municipality_monthly_wage float,
    top_municipality_monthly_wage_id varchar(10)
    
);