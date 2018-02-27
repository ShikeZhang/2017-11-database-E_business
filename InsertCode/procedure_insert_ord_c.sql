use m3DBS;

drop procedure insert_ord_c;

DELIMITER $$

create procedure insert_ord_c()
begin
declare cid_c1 char(20);
declare cid_c2 char(20);
declare num int;
declare rm int;
declare done int default 0;


DECLARE cur1 cursor for select c_id from commodity where price*discnt in (select min(price*discnt) from commodity group by genre);
DECLARE cur2 cursor for select c_id,remain from commodity where remain in (select max(remain) from commodity group by genre);
DECLARE CONTINUE HANDLER FOR NOT FOUND set done=1;


open cur1;
open cur2;

read_loop_1: loop

	fetch cur1 into cid_c1;
    
    if done=1 then 
		leave read_loop_1;
	end if;
    
	set num = 3+rand()*10;

    insert into ord_c
	VALUES('oc10', cid_c1, num);
    
    
end loop;

set done = 0;

read_loop_2: loop

    fetch cur2 into cid_c2, rm;
    
    if done=1 then 
		leave read_loop_2;
	end if;
    

    insert into ord_c
	VALUES('oc11', cid_c2, rm);
    
    
    
    
end loop;





 end$$
 
 
 
 
 
 
 show create procedure insert_store;

    


DELIMITER ;