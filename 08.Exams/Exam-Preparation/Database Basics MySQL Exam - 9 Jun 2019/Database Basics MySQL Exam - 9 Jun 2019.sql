# problem 2 - Insert

insert into cards (card_number, card_status, bank_account_id)
select reverse(full_name), 'Active', id from clients
where id >= 191 and id <= 200;



# problem 3 - Update

create table temp as select employee_id, count(*) as 'count' from employees_clients ec
join employees e on e.id = ec.employee_id
group by ec.employee_id
order by `count`, employee_id
limit 1;

update clients c
join employees_clients ec on ec.client_id = c.id
set employee_id = (select t.employee_id from temp t)
where ec.client_id = ec.employee_id;

drop table temp;


# вариант 2

UPDATE employees_clients AS ec
SET ec.employee_id = 
(
	SELECT ecc.employee_id FROM (SELECT * FROM employees_clients) AS ecc
	GROUP BY employee_id
	ORDER BY COUNT(ecc.client_id), ecc.employee_id
	LIMIT 1
)
WHERE ec.employee_id = ec.client_id;


# problem 4 - Delete

DELETE FROM employees
WHERE id NOT IN(SELECT employee_id FROM employees_clients);



# problem 5 - Clients

select id, full_name from clients
order by id;



# problem 6 - Newbies

select e.id, concat_ws(' ', e.first_name, e.last_name), concat('$', e.salary), e.started_on from employees e
where salary >= 100000 and year(started_on) >= 2018
order by salary desc, id;



# problem 7 - Cards against Humanity

select c.id, concat(c.card_number, ' : ', cl.full_name) from cards c
join bank_accounts ba on c.bank_account_id = ba.id
join clients cl on cl.id = ba.client_id
order by c.id desc;



# problem 8 - Top 5 Employees

select concat_ws(' ', e.first_name, e.last_name) as 'name', e.started_on, 
(select count(*) from employees_clients ec
where ec.employee_id = e.id
group by ec.employee_id
) as 'count_of_clients' 
from employees e
order by `count_of_clients` desc, e.id
limit 5;



# problem 9 Branch cards

select b.`name`, 
(select count(*) from cards c
join employees e on e.branch_id = b.id
join employees_clients ec on ec.employee_id = e.id
join clients cl on cl.id = ec.client_id
join bank_accounts bc on bc.client_id = cl.id
join cards crd on crd.bank_account_id = bc.id
where e.branch_id = b.id
group by b.id
) as 'count' from branches b