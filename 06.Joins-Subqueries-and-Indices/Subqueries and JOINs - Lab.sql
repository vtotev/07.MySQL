# problem 1 - Managers

select `e`.`employee_id`, concat_ws(' ', e.`first_name`, e.`last_name`), `d`.`department_id`, `d`.`name`
from employees as `e`
right join departments as `d`
on `d`.`manager_id` = `e`.`employee_id`
order by `e`.`employee_id`
limit 5;



# problem 2 - Towns and Addresses

select `t`.`town_id`, `t`.`name` as 'town_name', `a`.`address_text`
from towns as `t`
join addresses as `a`
on `t`.`town_id` = `a`.`town_id`
where `t`.`town_id` in (9,15,32)
order by `town_id`, `address_id`;



# problem 3 - Employees Without Managers

select e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
from employees as `e`
where manager_id is null;



# problem 4 - High Salary
select count(*) from employees
where salary > (select avg(salary) from employees);