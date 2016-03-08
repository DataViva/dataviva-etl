-- INSERT BRAZIL

INSERT INTO stat_ybhedu (year, bra_id, course_hedu_id, enrollemnts, entrants, graduates, top_university_enrollments, university_enrollments, top_municipality_enrollments, municipality_enrollments, top_university_entrants, university_entrants, top_municipality_entrants, municipality_entrants, top_university_graduates, university_graduates, top_municipality_graduates, municipality_graduates)
SELECT year, 0 as Brasil, course_hedu_id as Curso,
        enrolled as Matrículas_Curso,
        entrants as Ingressantes,
        graduates as Concluintes,
        (select name_pt from dataviva.hedu_yuc a INNER JOIN dataviva.attrs_university b ON a.university_id = b.id where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by enrolled desc limit 1) as Top_University_Enrolled,
        (select enrolled from dataviva.hedu_yuc where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by enrolled desc limit 1) as University_Enrolled,
        (select name_pt from dataviva.hedu_ybc a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by enrolled desc limit 1) as Top_Municipality_Enrolled,
        (select enrolled from dataviva.hedu_ybc where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by enrolled desc limit 1) as Municipality_Enrolled,
        (select name_pt from dataviva.hedu_yuc a INNER JOIN dataviva.attrs_university b ON a.university_id = b.id where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by entrants desc limit 1) as Top_University_Entrants,
        (select entrants from dataviva.hedu_yuc where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by entrants desc limit 1) as University_Entrants,
        (select name_pt from dataviva.hedu_ybc a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by entrants desc limit 1) as Top_Municipality_Entrants,
        (select entrants from dataviva.hedu_ybc where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by entrants desc limit 1) as Municipality_Entrants,
        (select name_pt from dataviva.hedu_yuc a INNER JOIN dataviva.attrs_university b ON a.university_id = b.id where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by graduates desc limit 1) as Top_University_Graduates,
        (select graduates from dataviva.hedu_yuc where year = '2013' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by graduates desc limit 1) as University_Graduates,
        (select name_pt from dataviva.hedu_ybc a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by graduates desc limit 1) as Top_Municipality_Graduates,
        (select graduates from dataviva.hedu_ybc where year = '2013' and bra_id_len = '9' and course_hedu_id = dataviva.hedu_yc.course_hedu_id order by graduates desc limit 1) as Municipality_Graduates
        FROM dataviva.hedu_yc
        where year = '2013';

-- INSERT LOCATIONS