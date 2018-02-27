

drop trigger member_AFTER_UPDATE;

DELIMITER $$

USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`member_AFTER_UPDATE` AFTER UPDATE ON `member` FOR EACH ROW
BEGIN

if (new.score < 101)
then
update cDiscount 
set disCnt = '0.9'
where ID = new.ID;

update rank
set rank = '1'
where ID = new.ID;

end if;



if (new.score >= 101 and new.score <= 500)
then
update cDiscount 
set disCnt = '0.8'
where ID = new.ID;

update rank
set rank = '2'
where ID = new.ID;

end if;



if(new.score >= 501)
then 
update cDiscount
set disCnt = '0.7'
where ID = new.ID; 

update rank
set rank = '3'
where ID = new.ID;

end if;


END$$

DELIMITER ;
