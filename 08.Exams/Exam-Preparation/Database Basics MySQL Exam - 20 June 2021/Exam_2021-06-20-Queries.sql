# problem 2 - Insert

insert into clients (full_name, phone_number)
select concat_ws(' ', first_name, last_name), concat('(088) 9999', id*2) from drivers
where id between 10 and 20;



# problem 3 - Update

update cars
set `condition` = 'C'
where `year` < 2011 and mileage >= 800000 or mileage is null and `make` != 'Mercedes-Benz';



# problem 4 - Delete

delete clients from clients
left join courses cr on clients.id = cr.client_id
where length(clients.full_name) > 3 and cr.client_id is null;



# problem 5 - Cars

select `make`, `model`, `condition` from cars
order by id;



# problem 6 - Drivers and Cars

select d.first_name, d.last_name, c.make, c.model, c.mileage from drivers d
left join cars_drivers cd on d.id = cd.driver_id
join cars c on c.id = cd.car_id
where mileage is not null
order by mileage desc, first_name;



# problem 7 - Number of courses

select c.id as `car_id`, c.make, c.mileage,  count(cr.id) as `count_of_courses`, round(avg(cr.bill),2) as `avg_bill`
from cars c
left join courses cr on c.id = cr.car_id
group by c.id
having `count_of_courses` != 2
order by `count_of_courses` desc, c.id;



# problem 8 - Regular clients

select cl.full_name, count(cr.id) as 'count_of_cars', sum(cr.bill) from clients cl
join courses cr on cl.id = cr.client_id
group by cl.id
having cl.full_name like '_a%' and `count_of_cars` > 1
order by cl.full_name;



# problem 9 - Full info for courses

select a.`name`, if(hour(cr.start) between 6 and 20, 'Day', 'Night'), cr.bill, cl.full_name,
	c.make, c.model, cat.`name` from courses cr
join addresses a on cr.from_address_id = a.id
join clients cl on cl.id = cr.client_id
join cars c on cr.car_id = c.id
join categories cat on c.category_id = cat.id
order by cr.id;



# problem 10 - Find all courses by client’s phone number

USE `stc`;
DROP function IF EXISTS `udf_courses_by_client`;

DELIMITER $$
USE `stc`$$
CREATE FUNCTION `udf_courses_by_client` (phone_num VARCHAR (20))
RETURNS INTEGER
deterministic
BEGIN
RETURN (select count(*) from clients cl
    join courses cr on cl.id = cr.client_id
    where cl.phone_number = phone_num);
END$$

DELIMITER ;



# problem 11 - Full info for address

USE `stc`;
DROP procedure IF EXISTS `udp_courses_by_address`;

DELIMITER $$
USE `stc`$$
CREATE PROCEDURE `udp_courses_by_address`(address_name varchar(100))
BEGIN
	select a.`name`, cl.full_name, if(cr.bill <= 20, 'Low', if(cr.bill <= 30, 'Medium', 'High')),
	c.make, c.condition, cat.`name`
	from addresses a
	join courses cr on a.id = cr.from_address_id
	join clients cl on cr.client_id = cl.id
	join cars c on cr.car_id = c.id
	join categories cat on cat.id = c.category_id
	where a.`name` = address_name
	order by c.make, cl.full_name;
END$$

DELIMITER ;


CALL udp_courses_by_address('700 Monterey Avenue');