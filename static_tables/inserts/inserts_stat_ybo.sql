-- Insere Heades do Brasil
insert into stat_ybo (year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est)
    select year, '0', cbo_id, wage_avg, wage, num_jobs, num_est from dataviva.rais_yo;

-- Insere Heades das demais Localidades 
insert into stat_ybo (year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est)
    select year, bra_id, cbo_id, wage_avg, wage, num_jobs, num_est from dataviva.rais_ybo;


/* Body 

    top_municipality_employment ,
        Brasil :                    remoto
        Demais Localidades :        remoto
    
    top_municipality_monthly_wage ,
        Brasil : 
        Demais Localidades :

    industry_highest_jobs  ,
        Brasil :                    remoto
        Demais Localidades :

    industry_highest_monthly_wage ,
        Brasil : 
        Demais Localidades :
*/


-- retorna ano maximo = 2013
select max(year) from dataviva.rais_yo where cbo_id = '2251' ;

-- Principal Município por empregos Localidade Brasil

update stat_ybo sybo set top_municipality_employment=(
    select num_jobs from dataviva.rais_ybo ybo
    where cbo_id = sybo.cbo_id and
    year = '2013' and
    bra_id_len = 9
    order by num_jobs desc
    limit 1
),
top_municipality_employment_id=(
    select bra_id from dataviva.rais_ybo ybo
    where cbo_id = sybo.cbo_id and
    year = '2013' and
    bra_id_len = 9
    order by num_jobs desc
    limit 1
)where sybo.bra_id='0';




-- TEMPO

-- -- Principal Município por empregos Localidade Diferente de Brasil 
update stat_ybo sybo set top_municipality_employment = (
    select num_jobs from dataviva.rais_ybo ybo
    where cbo_id = sybo.cbo_id and
    bra_id like concat(@sybo.bra_id,'%') and
    year = '2013' and
    bra_id_len = 9
    and length(sybo.bra_id) != 9
    order by num_jobs desc
    limit 1
),
top_municipality_employment_id = (
    select bra_id from dataviva.rais_ybo ybo
    where cbo_id = sybo.cbo_id and
    bra_id like concat(@sybo.bra_id,'%') and
    year = '2013' and
    bra_id_len = 9
    and length(sybo.bra_id) != 9
    order by num_jobs desc
    limit 1
)where bra_id != '0';

-- Número de empregos da principal atividade economica, localidade  Brazil
update stat_ybo sybo set economic_activity_highest_jobs=(
    select yio.num_jobs from dataviva.rais_yio yio
    where yio.cbo_id = sybo.cbo_id and
    yio.cnae_id_len = 6 and
    yio.year = '2013'
    order by yio.num_jobs desc
    limit 1

),
economic_activity_highest_jobs_id=(
    select yio.cnae_id from dataviva.rais_yio yio
    where yio.cbo_id = sybo.cbo_id and
    yio.cnae_id_len = 6 and
    yio.year = '2013'
    order by yio.num_jobs desc
    limit 1
)where sybo.bra_id='0'
;


