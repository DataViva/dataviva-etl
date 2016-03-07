-- isere atividades econômicas do Brasil
insert into stat_ybi (bra_id, year, cnae_id, wage, num_jobs, num_est, wage_avg)
 select 0, year, cnae_id, wage, num_jobs, num_est, wage_avg 
    from dataviva.rais_yi 
    where
    year = (select max(year) from dataviva.rais_yi) ;

--bra_id do Brasil 'e zero'
update stat_ybi set bra_id='0';

-- insere demais localidades
insert into stat_ybi (year, bra_id, cnae_id, wage, num_jobs, num_est, wage_avg, rca, distance, opp_gain)
select year, bra_id, cnae_id, wage, num_jobs, num_est, wage_avg, rca, distance, opp_gain 
from dataviva.rais_ybi 
where
year = (select max(year) from dataviva.rais_ybi);