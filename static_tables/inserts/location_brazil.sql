insert into stat_yb (year, bra_id) values ('2010', 0);

-- Brasil 
    -- Headers 
        update stat_yb set gdp=(
        select sum(stat_val) from dataviva.attrs_ybs where year = '2010' and stat_id = 'gdp' and length(bra_id) = 1),  
        pop = (select sum(stat_val) from dataviva.attrs_ybs where year = '2010' and stat_id = 'pop' and length(bra_id) = 3),
        gdp_pc = (select avg(stat_val) from dataviva.attrs_ybs where year = '2010' and stat_id = 'gdp_pc' and length(bra_id) = 1);

    -- Comércio Internacional

        -- principal produto por valor exportado, 
        update stat_yb syb set top_product_export  = (
            select  export_val from dataviva.secex_ymbp secex
            where month = 0
            and hs_id_len = 6
            and export_val is not null
            and year = '2014'
            order by export_val desc
            limit 1
        ), 
        top_product_export_id = (   
            select  hs_id from dataviva.secex_ymbp secex
            where month = 0
            and hs_id_len = 6
            and export_val is not null
            and year = '2014'
            order by export_val desc
            limit 1
        ) where syb.bra_id = '0' ;
            

        update stat_yb syb set top_product_import = (
        -- Principal produto por valor total importado
            select import_val from dataviva.secex_ymbp secex
            where
            month = 0
            and hs_id_len = 6
            and import_val is not null
            and year = '2014'
            order by import_val desc
            limit 1 
        ),
        top_product_import_id = (
        -- Principal produto por valor total importado
            select hs_id from dataviva.secex_ymbp secex
            where 
            month = 0
            and hs_id_len = 6
            and import_val is not null
            and year = '2014'
            order by import_val desc
            limit 1 
        ), 
        export_val = (
        -- exportacao, importacao
            select sum(export_val) from dataviva.secex_ymb where year = '2014'  and month = 0 and bra_id_len=3),
        import_val = (
            select sum(import_val) from dataviva.secex_ymb where year = '2014' and month = 0 and bra_id_len=3),

        top_export_destiny = (

        -- Principal destino por valor exportado
            select export_val
            from dataviva.secex_ymbw secex
            where year = '2014'
            and wld_id_len = 5
            order by export_val desc
            limit 1
        ),
        top_export_destiny_id = (

        -- Principal destino por valor exportado
            select wld_id
            from dataviva.secex_ymbw secex
            where year = '2014'
            and wld_id_len = 5
            order by export_val desc
            limit 1
        ),
        top_import_origin = (
        -- Principal origem por valor importado

            select import_val 
            from dataviva.secex_ymbw 
            where year = '2014'  
            and wld_id_len = 5 
            order by import_val desc 
            limit 1
        ),
        top_import_origin_id = (
        -- Principal origem por valor importado

            select wld_id 
            from dataviva.secex_ymbw 
            where year = '2014'  
            and wld_id_len = 5 
            order by import_val desc 
            limit 1
        );


    -- Salário e Emprego:


