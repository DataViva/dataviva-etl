-- Indicadores header (se for nulo, esconda o indicador) {
    -- year = 2010
    update stat_yb set year = '2010' where bra_id != '0'
        -- Caso 1: Se município ou Estado ----- bra_id_len = 9 || 3 

            -- PIB -> GDP
            update stat_yb syb set gdp = (
                select stat_val from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                where name_pt = 'PIB'
                and year = 2010 
                and bra_id = syb.bra_id
            ), life_exp = (
            -- Esperança de vida ao nascer;
                select stat_val from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                where name_pt like '%esperanca%'
                and year = 2010 
                and bra_id = syb.bra_id
             ),
             pop = (
            -- População (Censo 2010);
                select stat_val from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                where name_pt like '%População total%'
                and year = 2010
                and bra_id = syb.bra_id
                ),
            gdp_pc = (
            -- PIB per capta;
                select stat_val from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                where name_pt like 'PIB %'
                and year = 2010
                and bra_id = syb.bra_id
            ),
            hdi = (
                
            -- IDHM;
                select stat_val from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                where name_pt = 'IDHM'
                and year = 2010
                and bra_id = syb.bra_id
            ),    
            economic_complexity_index  = (
            -- Índice de Complexidade Econômica ()
                select eci from dataviva.secex_ymb
                where month = 0
                and bra_id = syb.bra_id
                order by year desc
                limit 1
            ) where length(syb.bra_id) = 3 or length(syb.bra_id) = 9;
    

        -- Caso 2: Se microrregião, mesorregião ou Região  ----- bra_id_len = 7
  
            -- PIB;
            update stat_yb syb set gdp = ( 
                select sum(stat_val) from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                INNER JOIN dataviva.attrs_bra bra on ybs.bra_id = bra.id
                where stat.name_pt = 'PIB'
                and year = 2010
                and bra.id like concat(syb.bra_id,'%')
                and length(bra.id) = 9 
            ),
            pop = (
            -- População (Censo 2010);
                select sum(stat_val) from dataviva.attrs_ybs ybs
                INNER JOIN dataviva.attrs_stat stat on stat.id = ybs.stat_id
                INNER JOIN dataviva.attrs_bra bra on ybs.bra_id = bra.id
                where stat.name_en = 'Total population'
                and year = 2010
                and bra.id like concat(syb.bra_id,'%')
                and length(bra.id) = 9 
            ),
            economic_complexity_index = (
            -- Índice de Complexidade Econômica
                select eci from dataviva.secex_ymb
                where month = 0
                and bra_id = syb.bra_id
                order by year desc
                limit 1
            ) where length(syb.bra_id) = 7;



            