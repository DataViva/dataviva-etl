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

-- Oportunidades Econômicas 







/*

Oportunidades Econômicas {
    Produto com menor distância
        select name_pt, hs_id, distance_wld from secex_ymbp secex
        inner join attrs_hs hs on hs.id = secex.hs_id
        where bra_id = '1ac'
        and month = 0
        and hs_id_len = 6
        and distance_wld is not null
        and year = (select max(year) from secex_ymbp)
        order by distance_wld asc
        limit 1;
        -- Em caso de empate, olhar ao produto com a maio oportunidade (opp_gain_wld)
    Atividade Econômica com menor distância
        select name_pt, distance from rais_ybi
        inner join attrs_cnae on rais_ybi.cnae_id = attrs_cnae.id
        where bra_id = '4mg'
        and cnae_id_len = 6
        and year = (select max(year) from rais_ybi)
        and distance is not null
        order by distance asc
        limit 1;
        -- Em caso de empate, olhar a atividade com maior oportunidade. (opp_gain_wld)
    Produto com maior ganho de oportunidade
        select name_pt, hs_id, opp_gain_wld from secex_ymbp secex
        inner join attrs_hs hs on hs.id = secex.hs_id
        where bra_id = '1ac'
        and month = 0
        and hs_id_len = 6
        and opp_gain_wld is not null
        and year = (select max(year) from secex_ymbp)
        order by opp_gain_wld desc
        limit 1;
        -- Em caso de empate, olhar ao produto com a menor distancia (distance_wld)
    Atividade Econômica com maior ganho de oportunidade
        select name_pt, opp_gain, num_jobs from rais_ybi
        inner join attrs_cnae on rais_ybi.cnae_id = attrs_cnae.id
        where bra_id = '1ac'
        and cnae_id_len = 6
        and year = (select max(year) from rais_ybi)
        and opp_gain is not null
        and opp_gain = (
            select max(opp_gain) from rais_ybi
            where bra_id = '1ac'
            and year = (select max(year) from rais_ybi)
            and opp_gain is not null
        )
        order by opp_gain desc;
        -- Em caso de empate, olhar a atividade com maior número de empregos (num_jobs)
}
Educação {
    Universidade com maior número de matrícula
        select name_en, enrolled from hedu_ybu
        inner join attrs_university on hedu_ybu.university_id = attrs_university.id
        where bra_id = '4sp'
        and year = (select max(year) from hedu_ybu)
        order by enrolled desc;
    Curso Superior com maior número de matrícula
        select name_pt, enrolled from hedu_ybc
        inner join attrs_course_hedu on hedu_ybc.course_hedu_id = attrs_course_hedu.id
        where bra_id = '4mg'
        and course_hedu_id_len = 6
        and year = (select max(year) from hedu_ybc)
        order by enrolled desc;
    Escola com maior número de matrícula em Cursos Técnicos
        select name_pt, sum(enrolled) from sc_ybsc
        inner join attrs_school on sc_ybsc.school_id = attrs_school.id
        where bra_id = '4mg'
        and course_sc_id not like 'xx%'
        and year = (select max(year) from sc_ybsc)
        group by sc_ybsc.school_id, name_pt
        order by sum(enrolled) desc;
    Curso Técnico com maior número de matrículas
        select name_pt, sum(enrolled) from sc_ybsc
        inner join attrs_course_sc on sc_ybsc.course_sc_id = attrs_course_sc.id
        where bra_id = '4mg'
        and course_sc_id not like 'xx%'
        and year = (select max(year) from sc_ybsc)
        group by sc_ybsc.course_sc_id, name_pt
        order by sum(enrolled) desc;
}
*/

