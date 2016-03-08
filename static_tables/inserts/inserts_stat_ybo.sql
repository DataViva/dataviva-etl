-- Insere Heades do Brasil
insert into stat_ybo (year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est)
    select year, '0', cbo_id, wage_avg, wage, num_jobs, num_est from dataviva.rais_yo;

-- Insere Heades das demais Localidades 
insert into stat_ybo (year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est)
    select year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est from dataviva.rais_ybo;

-- retorna ano maximo = 2013
select max(year) from dataviva.rais_yo where cbo_id = '2251' ;