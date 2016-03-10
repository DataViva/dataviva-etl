-- mysql -h dataviva-dev.cr7l9lbqkwhn.sa-east-1.rds.amazonaws.com -u dataviva-dev -pD4t4v1v4-d3v dataviva_client < static_tables/inserts/remote_inserts.sql



-- ################# updates to industry


-- Pega ocupacoes com maior numero de empregado

    --Brasil
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

    -- localidades Diferentes de Brasil
    update stat_ybi sybi set occupation_highest_jobs = (
        select ybio.num_jobs from dataviva.rais_ybio ybio
        where ybio.cnae_id = sybi.cnae_id and
        ybio.cbo_id_len = 4 and
        ybio.bra_id = sybi.bra_id and
        ybio.year = '2013'
        order by ybio.num_jobs desc
        limit 1
    ),
    occupation_highest_jobs_id = (
        select ybio.cbo_id from dataviva.rais_ybio ybio
        where ybio.cnae_id = sybi.cnae_id and
        ybio.cbo_id_len = 4 and
        ybio.bra_id = sybi.bra_id and
        ybio.year = '2013'
        order by ybio.num_jobs desc
        limit 1
    ) where sybi.bra_id != '0';

/**************************************************************************/
-- Pega Ocupacoes com maior renda média mensal

    -- Brasil
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


    -- Localidade Diferente de Brasil
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


/**************************************************************************/
-- Pega Municípios com maior número de empregos
    -- Brasil
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


    -- Localidade diferente de Brasil(tempo)
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


/**************************************************************************/
-- Pega Municípios com maior renda média mensal
    -- Brasil
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


    -- Localidade diferente de Brasil
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

/**************************************************************************/







-- ################# updates to occupations


/**************************************************************************/
-- Principal Município por empregos
    --Localidade Brasil

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


    -- Localidade Diferente de Brasil
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


/**************************************************************************/

-- Número de empregos da principal atividade economica
    -- Localidade  Brazil
    update stat_ybo sybo set industry_highest_jobs=(
        select yio.num_jobs from dataviva.rais_yio yio
        where yio.cbo_id = sybo.cbo_id and
        yio.cnae_id_len = 6 and
        yio.year = '2013'
        order by yio.num_jobs desc
        limit 1

    ),
    industry_highest_jobs_id=(
        select yio.cnae_id from dataviva.rais_yio yio
        where yio.cbo_id = sybo.cbo_id and
        yio.cnae_id_len = 6 and
        yio.year = '2013'
        order by yio.num_jobs desc
        limit 1
    )where sybo.bra_id='0'
    ;




    --Localidade  diferente de Brazil

    update stat_ybo sybo set industry_highest_jobs = (
        select  ybio.num_jobs from dataviva.rais_ybio ybio
        where ybio.cbo_id = sybo.cbo_id and
        ybio.cnae_id_len = 6 and
        ybio.bra_id = sybo.bra_id and
        ybio.year = '2013'
        order by ybio.num_jobs desc
        limit 1
    ),
    industry_highest_jobs_id = (
        select  ybio.cnae_id from dataviva.rais_ybio ybio
        where ybio.cbo_id = sybo.cbo_id and
        ybio.cnae_id_len = 6 and
        ybio.bra_id = sybo.bra_id and
        ybio.year = '2013'
        order by ybio.num_jobs desc
        limit 1

    ) where sybo.bra_id != '0';

/**************************************************************************/
-- Renda média mensal do municipior com maior média
    -- Localidade Brasil

    update stat_ybo sybo set top_municipality_monthly_wage = (
        select ybo.wage_avg from dataviva.rais_ybo ybo
        where cbo_id = sybo.cbo_id and
        ybo.year = '2013' and
        ybo.bra_id_len = 9
        order by ybo.wage_avg desc
        limit 1
    ),
    top_municipality_monthly_wage_id = (
        select ybo.bra_id from dataviva.rais_ybo ybo
        where cbo_id = sybo.cbo_id and
        ybo.year = '2013' and
        ybo.bra_id_len = 9
        order by ybo.wage_avg desc
        limit 1
    )where sybo.bra_id = '0';


    --Localidade diferente de Brasil

    update stat_ybo sybo set top_municipality_monthly_wage=(
        select ybo.wage_avg from dataviva.rais_ybo ybo
        where ybo.cbo_id = sybo.cbo_id and
        ybo.bra_id like concat(@sybo.bra_id,'%') and
        length(sybo.bra_id) != 9 and -- nao retorna nada pra minicipio
        ybo.year = '2013' and
        ybo.bra_id_len = 9
        order by ybo.wage_avg desc
        limit 1
    ),
    top_municipality_monthly_wage_id=(
        select ybo.bra_id from dataviva.rais_ybo ybo
        where ybo.cbo_id = sybo.cbo_id and
        ybo.bra_id like concat(@sybo.bra_id,'%') and
        length(sybo.bra_id) != 9 and -- nao retorna nada pra minicipio
        ybo.year = '2013' and
        ybo.bra_id_len = 9
        order by ybo.wage_avg desc
        limit 1
    ) where sybo.bra_id != '0';
/**************************************************************************/
-- Renda média mensal da atividade com maior média l
    -- Localidade Brasil
    update stat_ybo sybo set industry_highest_monthly_wage = (
        select yio.wage_avg from dataviva.rais_yio yio
        where yio.cbo_id = sybo.cbo_id and
        yio.cnae_id_len = 6 and
        year = '2013'
        order by yio.wage_avg desc
        limit 1
    ),
    industry_highest_monthly_wage_id = (
        select yio.cnae_id from dataviva.rais_yio yio
        where yio.cbo_id = sybo.cbo_id and
        yio.cnae_id_len = 6 and
        year = '2013'
        order by yio.wage_avg desc
        limit 1
    )where sybo.bra_id = '0' ;

    -- Localidade diferente de Brasil

    update stat_ybo sybo set industry_highest_monthly_wage = (
        select ybio.wage_avg from dataviva.rais_ybio ybio
        where ybio.cbo_id = sybo.cbo_id and
        ybio.bra_id = sybo.bra_id and
        ybio.cnae_id_len = 6 and
        year = '2013'
        order by ybio.wage_avg desc
        limit 1
    ),
    industry_highest_monthly_wage_id = (
        select ybio.cnae_id from dataviva.rais_ybio ybio
        where ybio.cbo_id = sybo.cbo_id and
        ybio.bra_id = sybo.bra_id and
        ybio.cnae_id_len = 6 and
        year = '2013'
        order by ybio.wage_avg desc
        limit 1
    )where sybo.bra_id != '0' ;
/**************************************************************************/

-- Insere na tabela stat_ybhs dados onde bra_id são todas as localidades brasileiras

INSERT into stat_ybhs (year, bra_id, hs_id, trade_balance, export_val, weight_value_export, import_val, weight_value_import, pci, rca, distance, opp_gain, top_municipality_export, municipality_export, top_municipality_import, municipality_import, top_export_destiny, top_export_value, top_import_origin, top_import_value)
SELECT year, bra_id as Brazil, hs_id as Product, export_val - import_val as Trade_Balance, export_val, export_kg/export_val as Weight_Value_Export, import_val, import_kg/import_val as Weight_Value_Import,
(select pci from dataviva.secex_ymp where year = '2014' and month = '0' and hs_id = dataviva.secex_ymbp.hs_id) as pci,
rca_wld as RCA, distance_wld as Distance, opp_gain_wld as Opp_gain,
CASE WHEN dataviva.secex_ymbp.bra_id_len = 9 THEN null ELSE(select name_pt from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by export_val desc limit 1) END as Top_Municipality_Export,
CASE WHEN dataviva.secex_ymbp.bra_id_len = 9 THEN null ELSE(select export_val from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by export_val desc limit 1) END as Municipality_Export,
CASE WHEN dataviva.secex_ymbp.bra_id_len = 9 THEN null ELSE(select name_pt from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by import_val desc limit 1) END as Top_Municipality_Import,
CASE WHEN dataviva.secex_ymbp.bra_id_len = 9 THEN null ELSE(select import_val from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by import_val desc limit 1) END as Municipality_Import,
(select wld_id from dataviva.secex_ymbpw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by export_val desc limit 1) as Top_Export_Destiny,
(select export_val from dataviva.secex_ymbpw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by export_val desc limit 1) as Top_Export_Value,
(select wld_id from dataviva.secex_ymbpw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by import_val desc limit 1) as Top_Import_Origin,
(select import_val from dataviva.secex_ymbpw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymbp.hs_id and bra_id like concat(dataviva.secex_ymbp.bra_id, '%') order by import_val desc limit 1) as Top_Import_Value
 from dataviva.secex_ymbp where year = '2014' and month = '0' and bra_id <> 0;

/**************************************************************************/

-- Insere na tabela stat_ybtrade_partner dados onde bra_id são todas as localidades brasileiras

INSERT INTO stat_ybtrade_partner (year, bra_id, wld_id, trade_balance, export_val, weight_value_export, import_val, weight_value_import, top_municipality_export, municipality_export, top_municipality_import, municipality_import, top_export_product, top_export_product_value, top_import_product, top_import_product_value, product_higher_trade_balance, product_higher_value, product_lower_trade_balance, product_lower_value)
SELECT year, bra_id as Location, wld_id as World, export_val - import_val as trade_balance, export_val, export_val / export_kg, import_val, import_val / import_kg,
CASE WHEN dataviva.secex_ymbw.bra_id_len = 9 THEN null ELSE (SELECT bra_id from dataviva.secex_ymbw where year = '2014' and month = '0' and bra_id_len = 9 and wld_id = World and bra_id like concat(Location, '%') order by export_val desc limit 1) END as Top_municipality_export_to,
CASE WHEN dataviva.secex_ymbw.bra_id_len = 9 THEN null ELSE (SELECT export_val from dataviva.secex_ymbw where year = '2014' and month = '0' and bra_id_len = 9 and wld_id = World and bra_id like concat(Location, '%') order by export_val desc limit 1) END as Top_municipality_export_value,
CASE WHEN dataviva.secex_ymbw.bra_id_len = 9 THEN null ELSE (SELECT bra_id from dataviva.secex_ymbw where year = '2014' and month = '0' and bra_id_len = 9 and wld_id = World and bra_id like concat(Location, '%') order by import_val desc limit 1) END as Top_municipality_import_to,
CASE WHEN dataviva.secex_ymbw.bra_id_len = 9 THEN null ELSE (SELECT import_val from dataviva.secex_ymbw where year = '2014' and month = '0' and bra_id_len = 9 and wld_id = World and bra_id like concat(Location, '%') order by import_val desc limit 1) END as Top_municipality_import_value,
(SELECT hs_id from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by export_val desc limit 1) as Top_product_export,
(SELECT export_val from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by export_val desc limit 1) as Top_product_export_value,
(SELECT hs_id from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by import_val desc limit 1) as Top_product_import,
(SELECT import_val from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by import_val desc limit 1) as Top_product_import_value,
(SELECT hs_id from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by CASE WHEN export_val is null THEN 0 ELSE export_val END - CASE WHEN import_val is null THEN 0 ELSE import_val END desc limit 1) as Top_product_balance,
(SELECT CASE WHEN export_val is null THEN 0 ELSE export_val END - CASE WHEN import_val is null THEN 0 ELSE import_val END as trade_balance from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by trade_balance desc limit 1) as Top_product_balance_value,
(SELECT hs_id from dataviva.secex_ympw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by CASE WHEN export_val is null THEN 0 ELSE export_val END - CASE WHEN import_val is null THEN 0 ELSE import_val END asc limit 1) as Min_product_balance,
(SELECT CASE WHEN export_val is null THEN 0 ELSE export_val END - CASE WHEN import_val is null THEN 0 ELSE import_val END as trade_balance from dataviva.secex_ymbpw where year = '2014' and month = '0' and hs_id_len = 6 and wld_id = World and bra_id like concat(Location, '%') order by trade_balance asc limit 1) as Min_product_balance_value
from dataviva.secex_ymbw where year = '2014' and month = '0' and bra_id not like '0%';



/**************************************************************************/
 -- locations 

 -- Oportunidades Econômicas -- rodar remoto
    insert into stat_ybip (bra_id) 
        select id from dataviva.attrs_bra;

   update stat_ybip sybip set 
   product_less_distance = ( 
   -- Produto com menor distância
        select distance_wld from dataviva.secex_ymbp secex
        where bra_id = sybip.bra_id
        and month = 0
        and hs_id_len = 6
        and distance_wld is not null
        and year = '2014'
        order by distance_wld asc
        limit 1
        -- Em caso de empate, olhar ao produto com a maio oportunidade (opp_gain_wld)
    ),
    product_less_distance_id = ( 
   -- Produto com menor distância
        select hs_id from dataviva.secex_ymbp secex
        where bra_id = sybip.bra_id
        and month = 0
        and hs_id_len = 6
        and distance_wld is not null
        and year = '2014'
        order by distance_wld asc
        limit 1
        -- Em caso de empate, olhar ao produto com a maio oportunidade (opp_gain_wld)
    ),
    industry_less_distance = (
    -- Atividade Econômica com menor distância
        select distance from dataviva.rais_ybi
        where bra_id = sybip.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and distance is not null
        order by distance asc
        limit 1
        -- Em caso de empate, olhar a atividade com maior oportunidade. (opp_gain_wld)
    ),industry_less_distance_id = (
    -- Atividade Econômica com menor distância
        select cnae_id from dataviva.rais_ybi
        where bra_id = sybip.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and distance is not null
        order by distance asc
        limit 1
        -- Em caso de empate, olhar a atividade com maior oportunidade. (opp_gain_wld)
    ),
    product_highest_opp_gain = (
    -- Produto com maior ganho de oportunidade
        select opp_gain_wld from dataviva.secex_ymbp secex
        where bra_id = sybip.bra_id
        and month = 0
        and hs_id_len = 6
        and opp_gain_wld is not null
        and year = (select max(year) from dataviva.secex_ymbp)
        order by opp_gain_wld desc
        limit 1
        -- Em caso de empate, olhar ao produto com a menor distancia (distance_wld)
    ), product_highest_opp_gain_id = (
    -- Produto com maior ganho de oportunidade
        select hs_id from dataviva.secex_ymbp secex
        where bra_id = sybip.bra_id
        and month = 0
        and hs_id_len = 6
        and opp_gain_wld is not null
        and year = (select max(year) from dataviva.secex_ymbp)
        order by opp_gain_wld desc
        limit 1
        -- Em caso de empate, olhar ao produto com a menor distancia (distance_wld)
    ),
    industry_opp_gain = (
    -- Atividade Econômica com maior ganho de oportunidade
        select opp_gain from dataviva.rais_ybi
        where bra_id = sybip.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and opp_gain is not null
        and opp_gain = (
            select max(opp_gain) from dataviva.rais_ybi
            where bra_id = sybip.bra_id
            and year = '2013'
            and opp_gain is not null
        )
        order by opp_gain desc
        limit 1
        -- Em caso de empate, olhar a atividade com maior número de empregos (num_jobs)
    ),
    industry_opp_gain_id = (
    -- Atividade Econômica com maior ganho de oportunidade
        select cnae_id from dataviva.rais_ybi
        where bra_id = sybip.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and opp_gain is not null
        and opp_gain = (
            select max(opp_gain) from dataviva.rais_ybi
            where bra_id = sybip.bra_id
            and year = '2013'
            and opp_gain is not null
        )
        order by opp_gain desc
        limit 1
        -- Em caso de empate, olhar a atividade com maior número de empregos (num_jobs)
    );