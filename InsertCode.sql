/*找到customer1和customer2*/
/*--customer1=c68,customer2=c69--*/

select t1.name, t2.disCnt, t3.ID from customer as t1 left join (CA as t3 natural join cDiscount as t2) 
			on t1.phone_number = t3.phone_number and t3.ID = t2.ID
		 where age = (select min(age) from customer) or age = (select max(age) from customer);
         



/*--找到c68和c69要买的东西--*/


/*g17,g138,g31,g68*/
select c_id from commodity where price*discnt in (select min(price*discnt) from commodity group by genre); 


/*g152,g147,g150,g158,g157*/
select c_id from commodity where remain in (select max(remain) from commodity group by genre);


/*----c68和c69下单---*/

call insert_ord_c; 		/*----见procedure_insert_ord_c---*/


/*---c68退货---*/

insert into back_od VALUES('oc10', 'no reason');


/*---c69完成订单---*/
/*---评价---*/
insert into cmt
VALUES('oc11', 'good', null, 5);

/*---订单状态升级---*/
update ord set state='3' where od_id='oc11';


