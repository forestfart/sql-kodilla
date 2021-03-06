SHOW PROCESSLIST;

SET GLOBAL EVENT_SCHEDULER=ON;

USE KODILLA_COURSE;

CREATE EVENT UPDATE_VIPS
	ON SCHEDULE EVERY 1 MINUTE 
    DO CALL UpdateVipLevels();
    
UPDATE READERS
SET VIP_LEVEL = "Not set"
WHERE READER_ID IN (6,7,8,9,10);

DROP EVENT UPDATE_VIPS;

COMMIT;

SELECT * FROM READERS;