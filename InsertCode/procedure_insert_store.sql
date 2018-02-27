use m3DBS;

drop procedure insert_store;

DELIMITER $$

create procedure insert_store()
begin
declare num char(10);
declare od int;
declare cnt int;
declare c_id char(10);
declare g_num int;
declare genre_id int;
declare genre_num int;
declare cnt_2 int;
declare cnt_3 int;
declare price int;
	set od = (select count(1) from store);
    set genre_num = (select count(1) from commodity);
	set num = od;
    set cnt = 1;
    set cnt_2 = 1;
    set cnt_3 = 1;
    set genre_num = (select count(1) from commodity);
    
	while   cnt <= 10 do
		insert into store value(concat('s',num));
			while cnt_3 <= 4 do
				while cnt_2 <=4 do 

					insert into commodity value(concat('g',genre_num), concat(concat('s',num), '_', cnt_3, '_', cnt_2 ), 20+genre_num%10, rand(), cnt_3, null,null,genre_num+rand()*20,'1');
                    insert into reservation value(concat('s',num), concat('g',genre_num));
                    set genre_num = genre_num + 1,
							cnt_2 = cnt_2 + 1;
				end while;
                set cnt_3 = cnt_3 +1,cnt_2 = 1;
                
            end while;
            
            set c_id = c_id + 1 , 
					num = num+1,
					cnt = cnt+1,
                    cnt_3 = 1;
	end while;
 end$$
 
 show create procedure insert_store;

    


DELIMITER ;