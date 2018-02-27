
drop trigger ord_c_AFTER_INSERT_1;
drop trigger back_od_AFTER_INSERT;

drop trigger cmt_AFTER_INSERT;

drop trigger ord_AFTER_UPDATE;


DELIMITER $$



USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`ord_c_AFTER_INSERT_1` AFTER INSERT ON `ord_c` FOR EACH ROW
BEGIN

if (new.number >
(select remain from commodity 
 where c_id=new.c_id))
 then 
 SIGNAL SQLSTATE '45000'
    SET message_text = 'Do not have that amount of goods! ';
end if;

if(new.number <=
(select remain from commodity 
 where c_id=new.c_id))
 then 
 update commodity
 set remain = remain-new.number
 where c_id = new.c_id;
 
 update ord
 set state = '1' 
 where od_id = new.od_id;
 
end if;

update ord
set money=
(select sum(number*price*discnt) from (ord_c natural join commodity) group by od_id having od_id=new.od_id)
where od_id=new.od_id;



update ord
set money = money * (select disCnt from cDiscount natural join purchase where od_id = new.od_id)
where od_id=new.od_id;



END$$




USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`back_od_AFTER_INSERT` AFTER INSERT ON `back_od` FOR EACH ROW
BEGIN

declare num int;
declare  cid char(16);
declare done int default 0;
declare cur_1 cursor for select c_id,number from ord_c where od_id=new.od_id ;

DECLARE CONTINUE HANDLER FOR NOT FOUND set done=1;


open cur_1;

read_loop_1: loop

 		fetch cur_1 into cid, num;
    
 		if done=1 then 
			leave read_loop_1;
		end if;
    
	update commodity 
	set remain=remain+num
	where c_id = cid;
    

end loop;


update ord
set state='4' 
where od_id=new.od_id;
END$$





USE `m3DBS`$$
CREATE DEFINER = CURRENT_USER TRIGGER `m3DBS`.`ord_AFTER_UPDATE` AFTER UPDATE ON `ord` FOR EACH ROW
BEGIN

if new.state='3'
then 
update member 
set score=score+3 where ID =
(select ID from purchase where od_id=new.od_id);
end if;

END$$












DELIMITER ;


