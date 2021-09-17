# problem 1 - Find Names of All Employees by First Name

select first_name, last_name from employees
where first_name like 'sa%'
order by employee_id;



# problem 2 - Find Names of All Employees by Last Name

select first_name, last_name from employees
where last_name like '%ei%'
order by employee_id;



# problem 3 - Find First Names of All Employess

select first_name from employees
where department_id in (3, 10) and year(hire_date) between 1995 and 2005
order by employee_id;



# problem 4 - Find All Employees Except Engineers

select first_name, last_name from employees
where job_title not like '%engineer%'
order by employee_id;



# problem 5 - Find Towns with Name Length

select `name` from towns
where length(`name`) between 5 and 6
order by `name`;



# problem 6 - Find Towns Starting With

select town_id, `name` from towns
where substring(`name`, 1, 1) in ('M', 'K', 'B', 'E')
order by `name`;



# problem 7 - Find Towns Not Starting With

select town_id, `name` from towns
where not substring(`name`, 1, 1) in ('R', 'B', 'D')
order by `name`;



# problem 8 - Create View Employees Hired After

create view v_employees_hired_after_2000 as
select first_name, last_name from employees
where year(hire_date) > 2000;

select * from v_employees_hired_after_2000;



# problem 9 - Length of Last Name

select first_name, last_name from employees
where length(last_name) = 5;



# problem 10 - Countries Holding 'A'

select country_name, iso_code from countries
where country_name like '%a%a%a%'
order by iso_code;



# problem 11 - Mix of Peak and River Names

select peak_name, river_name, lower(concat(peak_name, substr(river_name, 2, length(river_name)))) as mix from peaks, rivers
where right(peak_name, 1) = left(river_name, 1)
order by mix;



# problem 12 - Games From 2011 and 2012 Year

SELECT `name` AS `Name`, date_format(`start`, '%Y-%m-%d') AS `Start Date` FROM games
WHERE year(`start`) BETWEEN 2011 AND 2012
ORDER by `start`, `name`
LIMIT 50;



# problem 13 - User Email Providers

select user_name, substr(email, locate('@', email)+1) as `Email provider` from users
order by `Email provider`, user_name;



# problem 14 - Get Users with IP Address Like Pattern

select user_name, ip_address from users
where ip_address like '___.1%.%.___'
order by user_name;



# problem 15 - Show All Games with Duration

select `name` as 'game', 
case 
	when hour(`start`) >= 0 and hour(`start`) < 12 then 'Morning'
	when hour(`start`) >= 12 and hour(`start`) < 18 then 'Afternoon'
	when hour(`start`) >= 18 and hour(`start`) < 24 then 'Evening'
end as 'Part of the Day',
case 
	when `duration` <= 3 then 'Extra Short'
    when `duration` > 3 and `duration` <= 6 then 'Short'
    when `duration` > 6 and `duration` <= 10 then 'Long'
    else 'Extra Long'
end as 'Duration'
from games;



# problem 16 - Orders Table

select `product_name`, `order_date`,
adddate(`order_date`, interval 3 day) as 'pay_due',
adddate(`order_date`, interval 1 month) as 'deliver_due'
from orders;