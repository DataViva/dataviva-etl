-- INSERT BRAZIL

INSERT INTO stat_ybsc (year,  bra_id,  course_sc_id,  enrollemnts,  classes,  total_schools,  average_class_size,  average_age,  top_school_enrollments,  school_enrollments,  top_municipality_enrollments,  municipality_enrollments)
SELECT year, 0 as Brasil, course_sc_id as Curso,
        enrolled as Matrículas_Curso,
        classes as Turmas,
        (select count(*) from dataviva.sc_ysc where year = '2014' and course_sc_id = dataviva.sc_yc.course_sc_id order by enrolled desc limit 1) as Número_de_escolas,
        enrolled / classes as Tamanho_Médio_Turma,
        age as Média_Idade,
        (select school_id from dataviva.sc_ysc where year = '2014' and course_sc_id = dataviva.sc_yc.course_sc_id order by enrolled desc limit 1) as Escola,
        (select enrolled from dataviva.sc_ysc where year = '2014' and course_sc_id = dataviva.sc_yc.course_sc_id order by enrolled desc limit 1) as Matrículas_Escola,
        (select bra_id from dataviva.sc_ybc where year = '2014' and bra_id_len = '9' and course_sc_id = dataviva.sc_yc.course_sc_id order by enrolled desc limit 1) as Top_Municípios_Matrículas,
        (select enrolled from dataviva.sc_ybc where year = '2014' and bra_id_len = '9' and course_sc_id = dataviva.sc_yc.course_sc_id order by enrolled desc limit 1) as Matrículas_Municicípio
        FROM dataviva.sc_yc
        where year = '2014';

-- INSERT LOCATIONS