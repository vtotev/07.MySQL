# problem 1 - Count Employees by Town

DELIMITER $$
CREATE FUNCTION `ufn_count_employees_by_town` (town_name varchar(45))
RETURNS INTEGER
BEGIN
	declare count_empl int;
    set count_empl := (
		select count(*) from employees e
        join addresses a on a.address_id = e.address_id
        join towns t on t.town_id = a.town_id
        where t.`name` = town_name);
RETURN count_empl;
END;

DELIMITER ;

# problem 2 - Employees Promotion

DELIMITER $$
CREATE PROCEDURE `usp_raise_salaries` (department_name varchar(50))
BEGIN
	update employees e
	join departments d on e.department_id = d.department_id
	set salary = salary * 1.05
	where d.`name` = department_name;
END;

DELIMITER ;



# problem 3 - Employees Promotion By ID

DELIMITER $$

CREATE PROCEDURE `usp_raise_salary_by_id` (id INT)
BEGIN
	update employees
    set salary = salary * 1.05
    where employee_id = id;
END;

DELIMITER ;



# problem 4 - Triggered

create table deleted_employees (
	employee_id int primary key auto_increment,
    first_name varchar(20),
    last_name varchar(20),
    middle_name varchar(20),
    job_title varchar(50),
    department_id int,
    salary double
);

delimiter $$

create trigger tr_deleted_employees
after delete
on employees
for each row
begin
	insert into deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
    values (old.first_name, old.last_name, old.middle_name, old.job_title, old.department_id, old.salary);
end;

delimiter ;