DROP FUNCTION IF EXISTS getReaderNameById;

DELIMITER $$

CREATE FUNCTION getReaderNameById(readerId INT) RETURNS VARCHAR (255) DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(20) DEFAULT 'Standard Customer';
    IF readerId <= 0 THEN
		SET result = 'incorrect ID';
	ELSE
		SELECT LASTNAME INTO result FROM readers WHERE READER_ID = readerId;
	END IF;
	RETURN result;
END $$

DELIMITER ;

SELECT getReaderNameById(10) AS LEVEL;