use soft_uni;

# problem 1 - Employee Address

select e.employee_id, e.job_title, e.address_id, a.address_text
from employees as e
join addresses as a
on e.address_id = a.address_id
order by e.address_id
limit 5;



# problem 2 - Addresses with Towns

select e.first_name, e.last_name, t.`name`, a.address_text
from employees as e
join addresses as a on e.address_id = a.address_id
join towns as t on t.town_id = a.town_id
order by first_name, last_name
limit 5;



# problem 3 - Sales Employee

select e.employee_id, e.first_name, e.last_name, d.`name`  as 'department_name'
from employees as e
join departments as d
on e.department_id = d.department_id
where d.`name` = 'Sales'
order by e.employee_id desc;



# problem 4 -  Employee Departments

select e.employee_id, e.first_name, e.salary, d.`name` as 'department_name'
from employees as e
join departments as d
on e.department_id = d.department_id
where e.salary > 15000
order by d.department_id desc
limit 5;



# problem 5 - Employees Without Project

select e.employee_id, e.first_name from employees as e
left join employees_projects as ep on e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;



# problem 6 - Employees Hired After

select e.first_name, e.last_name, e.hire_date, d.`name` from employees as e
join departments as d
on e.department_id = d.department_id
where e.hire_date > '1999-01-01' and d.`name` in ('Sales', 'Finance')
order by hire_date;



# problem 7 - Employees with Project

select e.employee_id, e.first_name, p.`name` from employees as e
join employees_projects as empj on e.employee_id = empj.employee_id
join projects as p on p.project_id = empj.project_id
where date(p.start_date) > '2002-08-13' and isnull(p.end_date)
order by e.first_name, p.`name`
limit 5;



# problem 8 - Employee 24

select e.employee_id, e.first_name, if(year(p.start_date) >= 2005, null, p.`name`) from employees as e
join employees_projects as empj on e.employee_id = empj.employee_id
left join projects as p on p.project_id = empj.project_id
where e.employee_id = 24
order by p.`name`;



# problem 9 - Employee Manager

select e.employee_id, e.first_name, e.manager_id, m.first_name from employees as e
join employees as m on e.manager_id = m.employee_id
where e.manager_id in (3,7)
order by e.first_name;



# problem 10 - Employee Summary

select e.employee_id, concat_ws(' ', e.first_name, e.last_name) as 'employee_name',
			concat_ws(' ', m.first_name, m.last_name) as 'manager_name', d.`name` from employees as e
join employees as m on e.manager_Id = m.employee_id
join departments as d on e.department_id = d.department_id
order by e.employee_id
limit 5;



# problem 11 - Min Average Salary

select min(min_avg_salary) from (
	select avg(salary) as min_avg_salary from employees
    group by department_id
) as min_salaries;



use geography;

# problem 12 - Highest Peaks in Bulgaria

select mc.country_code, m.mountain_range, p.peak_name, p.elevation from mountains_countries as mc
join mountains as m on m.id = mc.mountain_id
join peaks as p on p.mountain_id = mc.mountain_id
where mc.country_code = 'bg' and p.elevation > 2835
order by elevation desc;



# problem 13 - Count Mountain Ranges

select mc.country_code, count(m.mountain_range) as 'mountain_range' from mountains_countries as mc
join mountains as m on m.id = mc.mountain_id
group by mc.country_code
having mc.country_code in ('US', 'RU', 'BG')
order by `mountain_range` desc;



# problem 14 - Countries with Rivers

select c.country_name, r.river_name from rivers as r
join countries_rivers as cr on r.id = cr.river_id
right join countries as c on c.country_code = cr.country_code
where c.continent_code = 'AF'
order by c.country_name
limit 5;



# problem 15 - Continents and Currencies

select continent_code, currency_code, count(country_name) as 'currency_ussage'
from countries as c
group by continent_code, currency_code
having currency_ussage = (
	select count(country_code) as `coun`
	from countries as c1
	where c1.continent_code = c.continent_code
	group by currency_code
	order by coun desc
	limit 1 ) and currency_ussage > 1
order by continent_code, currency_code;



# problem 16 - Countries without any Mountains

select count(*) from countries as c
left join mountains_countries as mc on mc.country_code = c.country_code
where mc.mountain_id is null;



# problem 17 - Highest Peak and Longest River by Country

select c.country_name, max(p.elevation) as 'highest_peak_elevation' , 
	max(r.length) as 'longest_river_length' from countries as c
left join mountains_countries as mc on c.country_code = mc.country_code
left join peaks as p on mc.mountain_id = p.mountain_Id
left join countries_rivers as rc on c.country_code = rc.country_code
left join rivers as r on rc.river_id = r.Id
group by c.country_name
order by `highest_peak_elevation` desc, `longest_river_length` desc
limit 5;