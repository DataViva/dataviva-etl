-- Insere heades e/das atividades econômicas do Brasil
insert into stat_ybi (bra_id, year, cnae_id, wage, num_jobs, num_est, wage_avg)
 select 0, year, cnae_id, wage, num_jobs, num_est, wage_avg 
    from dataviva.rais_yi 
    where
    year = (select max(year) from dataviva.rais_yi) ;


-- Insere heades  das demais localidades
insert into stat_ybi (year, bra_id, cnae_id, wage, num_jobs, num_est, wage_avg, rca, distance, opp_gain)
select year, bra_id, cnae_id, wage, num_jobs, num_est, wage_avg, rca, distance, opp_gain 
from dataviva.rais_ybi 
where
year = (select max(year) from dataviva.rais_ybi);


ALTER TABLE stat_ybi ADD occupation_highest_jobs INT;
ALTER TABLE stat_ybi ADD occupation_highest_monthly_wage INT;
ALTER TABLE stat_ybi ADD top_municipality_employment INT;
ALTER TABLE stat_ybi ADD top_municipality_monthly_wage INT;

-- Busca ano 
select max(year) from dataviva.rais_yio where cnae_id = 'g' -- 2013

--Pega ocupacoes com maior numero de empregado para todas as industrias do brasil
update stat_ybi sybi set occupation_highest_jobs = (    
    select yio.num_jobs from dataviva.rais_yio yio
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

)where bra_id = '0';


-- Pega Ocupacoes com maior renda média mensal (Caso a Localidade seja diferente de Brasil) :
update stat_ybi sybi set occupation_highest_monthly_wage = (

    select wage_avg from dataviva.rais_ybio ybio
    where ybio.cnae_id = sybi.cnae_id and
    ybio.cbo_id_len = 4 and
    ybio.bra_id = sybi.bra_id and
    ybio.year = '2013'
    order by ybio.wage_avg desc
    limit 1

)where bra_id != '0';


-- Pega Municípios com maior número de empregos (caso seja Brasil) :
update stat_ybi sybi set top_municipality_employment = (
    select ybi.num_jobs from dataviva.rais_ybi ybi
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

)where bra_id = '0';





/* resolver 

select * from stat_ybi_tmp;


-- Município com maior número de empregos (caso seja selecionado localidade diferente de Brasil)

update stat_ybi_tmp sybi set top_municipality_employment = (

    select ybi.num_jobs from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = '2013'
    order by ybi.num_jobs desc
    limit 1

)where bra_id != '0';




select name_pt, num_jobs from rais_ybi ybi
inner join attrs_bra bra on bra.id = ybi.bra_id  
where cnae_id = 'g47113' and
bra_id_len = 9 and bra_id LIKE '4mg%' and
year = (select max(year) from rais_ybi where cnae_id = 'g47113' and bra_id LIKE '4mg%')
order by num_jobs desc
limit 1;

select * from stat_ybi_tmp where cnae_id='g47113' and bra_id = '4mg';



-- -------------------------------



-- Município com maior renda média mensal (caso não seja Brasil) :
update stat_ybi sybi set top_municipality_monthly_wage = (
    select  ybi.wage_avg from dataviva.rais_ybi ybi
    where ybi.cnae_id = sybi.cnae_id and
    ybi.bra_id_len = 9 and ybi.bra_id LIKE concat(@sybi.bra_id,'%') and
    ybi.year = "2013"
    order by ybi.wage_avg desc
    limit 1

)where bra_id != '0';
*/
