-- mysql -h dataviva-dev.cr7l9lbqkwhn.sa-east-1.rds.amazonaws.com -u dataviva-dev -pD4t4v1v4-d3v dataviva_client < static_tables/inserts/remote_inserts.sql 


update stat_ybi sybi set occupation_highest_jobs = (    
    select yio.num_jobs from dataviva.rais_yio yio
    where yio.cnae_id = sybi.cnae_id and
    yio.cbo_id_len = 4 and
    year = '2013'
    order by num_jobs desc
    limit 1
), 
occupation_highest_jobs_id = (    
    select yio.cbo_id from dataviva.rais_yio yio
    where yio.cnae_id = sybi.cnae_id and
    yio.cbo_id_len = 4 and
    year = '2013'
    order by num_jobs desc
    limit 1
)
where bra_id = '0'
;

-- Pega Ocupacoes com maior renda média mensal (caso seja Brasil) :
update stat_ybi sybi set occupation_highest_monthly_wage = (

select wage_avg from dataviva.rais_yio yio
where yio.cnae_id = sybi.cnae_id and
yio.cbo_id_len = 4 and
year = '2013'
order by yio.wage_avg desc
limit 1

),
occupation_highest_monthly_wage_id = (

select cbo_id from dataviva.rais_yio yio
where yio.cnae_id = sybi.cnae_id and
yio.cbo_id_len = 4 and
year = '2013'
order by yio.wage_avg desc
limit 1

)
where bra_id = '0';


-- Pega Ocupacoes com maior renda média mensal (Caso a Localidade seja diferente de Brasil) :
update stat_ybi sybi set occupation_highest_monthly_wage = (

    select wage_avg from dataviva.rais_ybio ybio
    where ybio.cnae_id = sybi.cnae_id and
    ybio.cbo_id_len = 4 and
    ybio.bra_id = sybi.bra_id and
    ybio.year = '2013'
    order by ybio.wage_avg desc
    limit 1

),
occupation_highest_monthly_wage_id = (

    select cbo_id from dataviva.rais_ybio ybio
    where ybio.cnae_id = sybi.cnae_id and
    ybio.cbo_id_len = 4 and
    ybio.bra_id = sybi.bra_id and
    ybio.year = '2013'
    order by ybio.wage_avg desc
    limit 1

)
where bra_id != '0';


-- Pega Municípios com maior número de empregos (caso seja Brasil) :
update stat_ybi sybi set top_municipality_employment = (
    select ybi.num_jobs from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and
    ybi.year = '2013'
    order by ybi.num_jobs desc
    limit 1

),
top_municipality_employment_id = (
    select ybi.bra_id from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and
    ybi.year = '2013'
    order by ybi.num_jobs desc
    limit 1

)where bra_id = '0';



-- Pega Municípios com maior renda média mensal (caso seja Brasil):
update stat_ybi sybi set top_municipality_monthly_wage = (

    select ybi.wage_avg from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and
    ybi.year = '2013'
    order by ybi.wage_avg desc
    limit 1

),
top_municipality_monthly_wage_id = (

    select ybi.bra_id from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and
    ybi.year = '2013'
    order by ybi.wage_avg desc
    limit 1

)
where bra_id = '0';




update stat_ybi_tmp sybi set top_municipality_employment = (

    select ybi.num_jobs from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = '2013'
    order by ybi.num_jobs desc
    limit 1

),
top_municipality_employment_id = (

    select ybi.bra_id from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = '2013'
    order by ybi.num_jobs desc
    limit 1

)where bra_id != '0';



-- Município com maior renda média mensal (caso não seja Brasil) :
update stat_ybi sybi set top_municipality_monthly_wage = (
    select  ybi.wage_avg from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = "2013"
    order by ybi.wage_avg desc
    limit 1

),
top_municipality_monthly_wage_id = (
    select  ybi.bra_id from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = "2013"
    order by ybi.wage_avg desc
    limit 1

)where bra_id != '0';

