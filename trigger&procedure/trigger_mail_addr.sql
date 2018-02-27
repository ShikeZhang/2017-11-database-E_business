

/*drop trigger ord_BEFORE_INSERT_1;*/

DELIMITER $$



USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`ord_BEFORE_INSERT_1` BEFORE INSERT ON `ord` FOR EACH ROW
BEGIN

if new.mail_addr not regexp '^[0-9]{6}$' then
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT ='mail address invalid';
end if;
END $$

DELIMITER ;
