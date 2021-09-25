# problem 2 - Insert

insert into products_stores (product_id, store_id)
select id, 1 from products p
left join products_stores ps on ps.product_id = p.id
where ps.store_id is null;



# problem 3 - Update


update employees e
left join stores s on s.id = e.store_id
set manager_id = 3, salary = salary - 500
where year(hire_date) > 2003 and e.store_id not in (5,14)

# не е така...
SET FOREIGN_KEY_CHECKS=0;
update employees e
left join stores s on s.id = e.store_id
set manager_id = 3 and salary = salary - 500
where year(hire_date) > 2003 and e.store_id not in (5,14);



# problem 4 - Delete

delete from employees e
where e.id != e.manager_id and e.manager_id is not null and salary >= 6000;



# problem 5 - Employees

select first_name, middle_name, last_name, salary, hire_date from employees
order by hire_date desc;



# problem 6 - Products with old pictures

select p.`name`, p.price, p.best_before, concat(substr(p.`description`, 1, 10), '...') as 'short_description', pic.url
from products p
join pictures pic on pic.id = p.picture_id
where length(p.`description`) > 100 and year(pic.added_on) < 2019 and p.price > 20
order by p.price desc;



# problem 7 - Counts of products in stores

select s.`name`, count(p.id) as `count`, round(avg(p.price),2) as `avg` from products p
join products_stores ps on ps.product_id = p.id
right join stores s on s.id = ps.store_id
group by s.`name`
order by `count` desc, `avg` desc, s.id;



# problem 8 - Specific employee

select concat_ws(' ', e.first_name, e.last_name) as 'full_name', s.`name` as `store_name`, a.`name`, e.salary from employees e
join stores s on s.id = e.store_id
join addresses a on a.id = s.address_id
join towns t on t.id = a.town_id
where salary < 4000 and a.`name` like concat('%', 5, '%') and length(s.`name`) > 8 and e.last_name like '%n';



# problem 9 - Find all information of stores

select reverse(s.`name`), concat_ws('-', upper(t.`name`), a.`name`) as 'full_address', count(e.id) as 'employees_count' from stores s
join addresses a on a.id = s.address_id
join towns t on t.id = a.town_id
join employees e on e.store_id = s.id
group by s.`name`
order by `full_address`;



# problem 10 - Find name of top paid employee by store name

DELIMITER $$
CREATE FUNCTION `udf_top_paid_employee_by_store`(store_name VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
BEGIN
	RETURN (select concat_ws(' ', e.first_name, concat(e.middle_name, '.'), e.last_name, 
			'works in store for', TIMESTAMPDIFF(year, e.hire_date,  '2020-10-18'), 'years') as 'full_info'
    from employees e
    join stores s on s.id = e.store_id
    where s.`name` = store_name
    order by salary desc
    limit 1
    );
END$$
DELIMITER ;



# problem 11 - Update product price by address

DELIMITER $$
USE `softuni_stores_system`$$
CREATE PROCEDURE `udp_update_product_price` (address_name VARCHAR (50))
BEGIN
	update products p
	join products_stores ps on ps.product_id = p.id
	join stores s on s.id = ps.store_id
	join addresses a on a.id = s.address_id
	set price = if(a.`name` like '0%', price + 100, price+200)
	where a.`name` = address_name;
END$$

DELIMITER ;

