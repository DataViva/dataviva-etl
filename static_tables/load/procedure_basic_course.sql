DROP PROCEDURE IF EXISTS select_sc;

CREATE DEFINER=`dataviva`@`%` PROCEDURE `select_sc`()
BEGIN
    DECLARE course INT;
    DECLARE r_course CURSOR FOR SELECT id FROM dataviva.attrs_course_sc;
    OPEN r_course;
           read_loop_course: LOOP
        FETCH r_course INTO course;
        INSERT INTO dataviva_client.TbTeste(year, school_id, bra_id, course_sc_id, enrolled)
            SELECT
                year, school_id, bra_id, course_sc_id, enrolled FROM dataviva.sc_ybsc
                WHERE course_sc_id = course and
                bra_id like '4mg%' and
                year IN (select max(year) from dataviva.sc_ybsc where course_sc_id = course and bra_id = '4mg')
            ORDER BY enrolled desc LIMIT 1;
        END LOOP;
END


update dataviva_client.TbTeste set enrolled=(SELECT enrolled FROM dataviva.sc_yc src where TbTeste.course_sc_id = src.course_sc_id and year = 2014);




            SELECT
                year, school_id, bra_id, course_sc_id, enrolled FROM dataviva.sc_ybsc
                WHERE course_sc_id = course and
                bra_id like '4mg%' and
                year IN (select max(year) from dataviva.sc_ybsc where course_sc_id = course and bra_id = '4mg')
            ORDER BY enrolled desc LIMIT 1;