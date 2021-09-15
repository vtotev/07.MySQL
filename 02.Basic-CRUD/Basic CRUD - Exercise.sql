# Problem 1 - Find All Information About Departments

select * from departments
order by department_id;



# Problem 2 - Find all Department Names

select `name` from departments
order by department_id;



# Problem 3 - Find Salary of Each Employee

select `first_name`, `last_name`, `salary` from employees
order by employee_id;



# Problem 4 - Find Full Name of Each Employee

select `first_name`, `middle_name`, `last_name` from employees
order by employee_id;



# Problem 5 - Find Email Address of Each Employee

select Concat(`first_name`, '.', `last_name`, '@softuni.bg') as `full_email_address` from employees



# Problem 6 - Find All Different Employee’s Salaries

select distinct `salary` from employees
order by `employee_id`;



# Problem 7 - Find all Information About Employees

select * from employees
where job_title = 'Sales Representative'
order by employee_id;



# Problem 8 - Find Names of All Employees by Salary in Range

select `first_name`, `last_name`, `job_title` from employees
where `salary` >= 20000 and `salary` <= 30000
order by `employee_id` asc;



# Problem 9 - Find Names of All Employees

select concat_ws(' ', `first_name`, `middle_name`, `last_name`) as `Full Name` from employees
where salary = 25000 or salary = 14000 or salary = 12500 or salary = 23600;



# Problem 10 - Find All Employees Without Manager

select `first_name`, `last_name` from employees
where manager_id is null;



# Problem 11 - Find All Employees with Salary More Than

select `first_name`, `last_name`, salary from employees
where salary > 50000
order by salary desc;



# Problem 12 - Find 5 Best Paid Employees

select first_name, last_name from employees
order by salary desc
limit 5;



# Problem 13 - Find All Employees Except Marketing

select first_name, last_name from employees
where department_id != 4;




# Problem 14 - Sort Employees Table

select * from employees
order by salary desc, first_name, last_name desc, middle_name;



# Problem 15 - Create View Employees with Salaries

create view v_employees_salaries as
select first_name, last_name, salary from employees;

select * from v_employees_salaries;



# Problem 16 - Create View Employees with Job Titles

create view v_employees_job_titles as
select concat_ws(" ", first_name, middle_name, last_name) as full_name, job_title
from employees;

select * from v_employees_job_titles;



# Problem 17 - Distinct Job Titles

select distinct job_title from employees
order by job_title;



# Problem 18 - Find First 10 Started Projects

select * from projects
order by start_date, `name`
limit 10;



# Problem 19 - Last 7 Hired Employees

select first_name, last_name, hire_date from employees
order by hire_date desc
limit 7;



# Problem 20 - Increase Salaries

update employees
set salary = salary * 1.12
where department_id in (1, 2, 4, 11);

select salary from employees;



# Problem 21 - All Mountain Peaks

select peak_name from peaks
order by peak_name;



# Problem 22 - Biggest Countries by Population

select country_name, population from countries
where continent_code = 'EU'
order by population desc, country_name
limit 30;



# Problem 23 - Countries and Currency (Euro / Not Euro)

select `country_name`, `country_code`,
if (`currency_code` = 'EUR', 'Euro', 'Not Euro') as 'currency'
from `countries`
order by country_name;



# Problem 24 - All Diablo Characters

select `name` from characters
order by `name`;