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


-- locations 
drop table stat_yb;
create table stat_yb(
    year varchar(4),
    bra_id varchar(9),
    gdp varchar(255),
    life_exp varchar(255),
    pop varchar(255),
    gdp_pc varchar(255),
    hdi varchar(255),
    economic_complexity_index varchar(255),
);

-- Comércio Internacional
create table stat_ybpw(
    year varchar(4),
    bra_id varchar(9),
    top_product_export varchar(255),
    top_product_export_id varchar(10),
    top_product_import varchar(255),
    top_product_import_id varchar(10),
    export_val varchar(255),
    import_val varchar(255),
    top_export_destiny varchar(255),
    top_export_destiny_id varchar(10),
    top_import_origin varchar(255),
    top_import_origin_id varchar(10)
);

---- falta

-- Salário e Emprego
create table stat_ybio(
    year varchar(4),
    bra_id varchar(9),
    top_industry  varchar(255),
    top_industry_id  varchar(10),
    top_occupation_jobs  varchar(255),
    top_occupation_jobs_id  varchar(10),
    average_wage  varchar(255),
    wage  varchar(255),
    employers varchar(255)
);

-- Oportunidades Econômicas
create table stat_ybip(
    year varchar(4),
    bra_id varchar(9),
    product_less_distance  varchar(255),
    product_less_distance_id  varchar(10),
    industry_less_distance  varchar(255),
    industry_less_distance_id  varchar(10),
    product_highest_opp_gain  varchar(255),
    industry_opp_gain  varchar(255),
    industry_opp_gain_id  varchar(10)
);

-- Educação
create table stat_ybuc(
    year varchar(4),
    bra_id varchar(9),
    top_university_enrollments  varchar(255),
    top_university_enrollments_id  varchar(10),
    top_course_enrollments  varchar(255),
    top_course_enrollments_id  varchar(10),
    top_school_enrollment  varchar(255),
    top_school_enrollment_id  varchar(10)
    
);















