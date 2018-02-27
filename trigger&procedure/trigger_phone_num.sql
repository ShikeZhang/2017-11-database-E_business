

drop trigger customer_BEFORE_INSERT_1;

DELIMITER $$



USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`customer_BEFORE_INSERT_1` BEFORE INSERT ON `customer` FOR EACH ROW
BEGIN

if new.phone_number not regexp '^[0-9]{8}$' then
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT ='phone number invalid';
end if;


if(new.age > 80)
then
	SIGNAL SQLSTATE '45000'
    SET message_text = 'cannot insert row with age > 80!';
    end if;
    
    
END $$



DELIMITER ;

