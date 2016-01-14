

show tables;
#select  * from raise limit 5 offset 10;

/*
DELIMITER $$
CREATE PROCEDURE ROWPERROW()
BEGIN
    DECLARE n INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    SELECT COUNT(*) FROM raise INTO n;
    SET i=0;
    WHILE i<n DO 
        SELECT * FROM raise LIMIT i,5;
        SET i = i + 5;
    END WHILE;
END $$
DELIMITER ;



call rowperrow();

*/