-- ALTER TABLE BOOKS ADD BESTSELLER BOOLEAN;

DROP PROCEDURE IF EXISTS UpdateBestsellers;

DELIMITER $$

CREATE PROCEDURE UpdateBestsellers()
BEGIN
	DECLARE bookRentCount, days, bookId INT;
    DECLARE rentsPerMonth DECIMAL(5,2);
    DECLARE finished INT DEFAULT 0;
    DECLARE allBooks CURSOR FOR SELECT BOOK_ID FROM BOOKS;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    OPEN allBooks;
    WHILE (finished = 0) DO
		FETCH allBooks INTO bookID;
        IF (finished = 0) THEN
			SELECT COUNT(*) FROM RENTS
			WHERE BOOK_ID = bookId
			INTO bookRentCount;
			SELECT DATEDIFF(MAX(RENT_DATE), MIN(RENT_DATE)) FROM RENTS
			WHERE BOOK_ID = bookId
			INTO days;
			SET rentsPerMonth = bookRentCount / days * 30;
            IF rentsPerMonth > 2 THEN
				UPDATE BOOKS SET BESTSELLER = TRUE
                WHERE BOOK_ID = bookId;
			ELSE
				UPDATE BOOKS SET BESTSELLER = FALSE
                WHERE BOOK_ID = bookId;
			END IF;
			COMMIT;
		END IF;
	END WHILE;
    CLOSE allBooks;
END $$

DELIMITER ;

Call UpdateBestsellers();