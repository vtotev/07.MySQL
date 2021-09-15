# problem 1 - Select Employee Information

SELECT id, first_name, last_name, job_title FROM employees
ORDER BY id;



# problem 2 - Select Employees with Filter

SELECT id, CONCAT (first_name, " ", last_name) as `full_name`, job_title, salary FROM employees
WHERE salary > 1000
ORDER BY id;



# problem 3 - Update Salary and Select

UPDATE employees
set salary = salary + 100
WHERE job_title = 'Manager';

SELECT salary FROM employees



# problem 4 - Top Paid Employee

create view `employees_view` as 
SELECT * from employees
order by salary desc
limit 1;

select * from employees_view;



# problem 5 - Select Employees by Multiple Filters

select * from employees
where department_id = 4 and salary >= 1000
order by id;



# problem 6 - Delete from Table

delete from employees
where department_id = 1 or department_id = 2;

select * from employees;