DROP FUNCTION IF EXISTS VipLevel;

DELIMITER $$

CREATE FUNCTION VipLevel(booksrented INT) RETURNS VARCHAR (20) DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(20) DEFAULT 'Standard Customer';
    IF booksrented >= 10 THEN
		SET result = 'Gold customer';
	ELSEIF booksrented >= 5 AND booksrented < 10 THEN
		SET result = 'Silver customer';
	ELSEIF booksrented >= 2 AND booksrented < 5 THEN
		SET result = 'Bronze customer';
	ELSE
		SET result = 'Standard customer';
	END IF;
	RETURN result;
END $$

DELIMITER ;

SELECT VipLevel(12) AS LEVEL;