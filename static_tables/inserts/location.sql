insert into stat_ybpw (bra_id) 
select id from dataviva.attrs_bra;

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


-- Indicadores gerais: (nova tabela stat_ybpw)
    -- Comércio Internacional 
    insert into stat_ybpw (bra_id) 
        select id from dataviva.attrs_bra;

    update stat_ybpw sybpw set 
    year = '2014',
    top_product_export=(
    --  Principal produto por valor total exportado
        select export_val from dataviva.secex_ymbp secex
        where bra_id = sybpw.bra_id
        and month = 0
        and hs_id_len = 6
        and export_val is not null
        and year = '2014'
        order by export_val desc
        limit 1
    ),
    top_product_export_id=(
    --  Principal produto por valor total exportado
        select hs_id from dataviva.secex_ymbp secex
        where bra_id = sybpw.bra_id
        and month = 0
        and hs_id_len = 6
        and export_val is not null
        and year = '2014'
        order by export_val desc
        limit 1
    ),
    top_product_import = (
    -- Principal produto por valor total importado
        select import_val from dataviva.secex_ymbp secex
        where bra_id = sybpw.bra_id
        and month = 0
        and hs_id_len = 6
        and import_val is not null
        and year = '2014'
        order by import_val desc
        limit 1
    ),
    top_product_import_id = (
    -- Principal produto por valor total importado
        select hs_id from dataviva.secex_ymbp secex
        where bra_id = sybpw.bra_id
        and month = 0
        and hs_id_len = 6
        and import_val is not null
        and year = '2014'
        order by import_val desc
        limit 1
    ),
    export_val = (      
    -- Total de Exportações
        select export_val from dataviva.secex_ymb
        where month = 0
        and bra_id = sybpw.bra_id
        order by year desc
        limit 1
    ),
    import_val = (
    -- Total de Importações
        select import_val from dataviva.secex_ymb
        where month = 0
        and bra_id = sybpw.bra_id
        order by year desc
        limit 1
    ),
    top_export_destiny = (
    -- Principal destino por valor exportado
        select export_val from dataviva.secex_ymbw secex
        where month = 0
        and wld_id_len = 5
        and year = 2014
        and bra_id = sybpw.bra_id
        order by export_val desc
        limit 1
    ),
    top_export_destiny_id = (
    -- Principal destino por valor exportado
        select wld_id from dataviva.secex_ymbw secex
        where month = 0
        and wld_id_len = 5
        and year = 2014
        and bra_id = sybpw.bra_id
        order by export_val desc
        limit 1
    ),
    top_import_origin = (
    --  Principal origem por valor importado
        select import_val from dataviva.secex_ymbw secex
        where month = 0
        and wld_id_len = 5
        and year = 2014
        and bra_id = sybpw.bra_id
        order by export_val desc
        limit 1
    ),
    top_import_origin_id = (
    --  Principal origem por valor importado
        select wld_id from dataviva.secex_ymbw secex
        where month = 0
        and wld_id_len = 5
        and year = 2014
        and bra_id = sybpw.bra_id
        order by export_val desc
        limit 1
    );

-- Salário e Emprego --ano 2013 rais
    insert into stat_ybio (bra_id) 
        select id from dataviva.attrs_bra;


    update stat_ybio sybio set 
    year = '2013',
    top_industry = (
    -- Principal Atividade Econômica por número de empregos;
        select num_emp from dataviva.rais_ybi
        where bra_id = sybio.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and num_jobs is not null
        order by num_jobs desc
        limit 1
    ),
    top_industry_id = (
    -- Principal Atividade Econômica por número de empregos;
        select cnae_id from dataviva.rais_ybi
        where bra_id = sybio.bra_id
        and cnae_id_len = 6
        and year = '2013'
        and num_jobs is not null
        order by num_jobs desc
        limit 1
    ),
    top_occupation_jobs = (
    -- Principal Ocupação por número de empregos;
        select num_jobs from dataviva.rais_ybo
        where bra_id = sybio.bra_id
        and cbo_id_len = 4
        and year = '2013'
        and num_jobs is not null
        order by num_jobs desc
        limit 1
    ),
    top_occupation_jobs_id = (
    -- Principal Ocupação por número de empregos;
        select cbo_id from dataviva.rais_ybo
        where bra_id = sybio.bra_id
        and cbo_id_len = 4
        and year = '2013'
        and num_jobs is not null
        order by num_jobs desc
        limit 1
    ),
    average_wage = (
    -- Salário Médio;
        select wage_avg from dataviva.rais_yb
        where bra_id = sybio.bra_id
        and year = '2013'
    ),
    wage = (
    -- Massa Salarial;
        select wage from dataviva.rais_yb
        where bra_id = sybio.bra_id
        and year = '2013'
    ),
    employers = (
    -- Total de empregos;
        select num_jobs from dataviva.rais_yb
        where bra_id = sybio.bra_id
        and year = '2013'
    );

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
    
-- Educação
    insert into stat_ybuc (bra_id) 
        select id from dataviva.attrs_bra;

    update stat_ybuc sybu set 
    top_university_enrollments = (
    -- Universidade com maior número de matrícula
        select enrolled from dataviva.hedu_ybu
        where bra_id = sybu.bra_id
        and year = '2013'
        order by enrolled desc
        limit 1
    ),
    top_university_enrollments_id = (
    -- Universidade com maior número de matrícula
        select university_id from dataviva.hedu_ybu
        where bra_id = sybu.bra_id
        and year = '2013'
        order by enrolled desc
        limit 1
    ),
    top_course_enrollments = (
    -- Curso Superior com maior número de matrícula
        select enrolled from dataviva.hedu_ybc
        where bra_id = sybu.bra_id
        and course_hedu_id_len = 6
        and year = '2013'
        order by enrolled desc
        limit 1
    ),
    top_course_enrollments_id = (
    -- Curso Superior com maior número de matrícula
        select course_hedu_id from dataviva.hedu_ybc
        where bra_id = sybu.bra_id
        and course_hedu_id_len = 6
        and year = '2013'
        order by enrolled desc
        limit 1
    ),
    top_school_enrollment = (        
    --  Escola com maior número de matrícula em Cursos Técnicos
        select sum(enrolled) from dataviva.sc_ybsc
        where bra_id = sybu.bra_id
        and course_sc_id not like 'xx%'
        and year = '2014'
        group by sc_ybsc.school_id
        order by sum(enrolled) desc
        limit 1
    ),
    top_school_enrollment_id = (        
    --  Escola com maior número de matrícula em Cursos Técnicos
        select school_id from dataviva.sc_ybsc
        where bra_id = sybu.bra_id
        and course_sc_id not like 'xx%'
        and year = '2014'
        group by sc_ybsc.school_id
        order by sum(enrolled) desc
        limit 1
    ),
    technical_course_enrollment = (
    -- Curso Técnico com maior número de matrículas
        select sum(enrolled) from dataviva.sc_ybsc
        where bra_id = sybu.bra_id
        and course_sc_id not like 'xx%'
        and year = '2014'
        group by sc_ybsc.course_sc_id
        order by sum(enrolled) desc
        limit 1
    ),
     technical_course_enrollment_id = (
    -- Curso Técnico com maior número de matrículas
        select course_sc_id from dataviva.sc_ybsc
        where bra_id = sybu.bra_id
        and course_sc_id not like 'xx%'
        and year = '2014'
        group by sc_ybsc.course_sc_id
        order by sum(enrolled) desc
        limit 1
    );




