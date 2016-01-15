


/*
	criar tabelas RAIS2002TOTAL e RAIS2002TOTALe com script rais/extract/ddl/create_RAIS_2002.sql
*/
#select  * from RAIS2002TOTAL limit 5 offset 1
drop procedure rowperrow;

DELIMITER $$
CREATE PROCEDURE ROWPERROW()
BEGIN
    DECLARE n INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    SELECT COUNT(*) FROM RAIS2002TOTAL INTO n;
    SET i=0;
    WHILE i<n DO 
        INSERT INTO RAIS2002TOTAL2 SELECT * FROM RAIS2002TOTAL LIMIT i, 60000;
        SET i = i + 60000;
    END WHILE;
END $$
DELIMITER ;

#call rowperrow();
