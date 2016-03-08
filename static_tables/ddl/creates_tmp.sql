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
    economic_activity_highest_jobs  int,
    economic_activity_highest_jobs_id varchar(10),
    economic_activity_highest_monthly_wage float,
    economic_activity_highest_monthly_wage_id varchar(10)
    
);
