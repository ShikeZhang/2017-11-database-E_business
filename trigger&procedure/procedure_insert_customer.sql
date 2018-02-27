drop procedure insert_customer;

DELIMITER $$

create procedure insert_customer()
begin
declare num char(10);
declare od int;
declare base int;
declare cnt int;
declare age int;
declare id char;
	set base = 80000000;
	set od = (select count(1) from store);
    set id = od;
	set num = base+od;
    set cnt = 1;
    set age = 20+59*rand();
    
		while   cnt <= 100 do
			insert into customer value(num, 'john', 'm', age);
            insert into CA value(num, concat('c', id));
            insert into account value(concat('c', id), '0', '1');
            set od = od+1;
            set id = od;
            set num = base + od;
            set cnt = cnt + 1;
		end while;
 end$$
 
 show create procedure insert_customer;

    


DELIMITER ;