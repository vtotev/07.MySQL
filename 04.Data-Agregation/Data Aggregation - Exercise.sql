# problem 1 - Records’ Count

select count(*) from wizzard_deposits;



# problem 2 - Longest Magic Wand

select max(`magic_wand_size`) as 'longest_magic_wand' from wizzard_deposits;



# problem 3 - Longest Magic Wand per Deposit Groups

select deposit_group, max(`magic_wand_size`) as 'longest_magic_wand'
from wizzard_deposits
group by deposit_group
order by `longest_magic_wand`, deposit_group;



# problem 4 - Smallest Deposit Group per Magic Wand Size

select deposit_group from wizzard_deposits
group by deposit_group
order by avg(magic_wand_size)
limit 1;



# problem 5 - Deposits Sum

select `deposit_group`, sum(`deposit_amount`) as 'total_sum'
from wizzard_deposits
group by deposit_group
order by `total_sum`;



# problem 6 - Deposits Sum for Ollivander Family

select deposit_group, sum(deposit_amount) as 'total_sum' from wizzard_deposits
where `magic_wand_creator` like 'Ollivander family'
group by deposit_group
order by deposit_group;



# problem 7 - Deposits Filter

select deposit_group, sum(deposit_amount) as 'total_sum' from wizzard_deposits
where `magic_wand_creator` like 'Ollivander family'
group by deposit_group
having `total_sum` < 150000
order by `total_sum` desc;



# problem 8 - Deposit Charge

select `deposit_group`, `magic_wand_creator`, min(deposit_charge) as 'min_deposit_charge'
from wizzard_deposits
group by `deposit_group`, `magic_wand_creator`
order by `magic_wand_creator`, `deposit_group`;



# problem 9 - Age Groups

select 
	case
		when `age` >= 0 and `age` <= 10 then '[0-10]' 
		when `age` >= 11 and `age` <= 20 then '[11-20]' 
		when `age` >= 21 and `age` <= 30 then '[21-30]' 
		when `age` >= 31 and `age` <= 40 then '[31-40]' 
		when `age` >= 41 and `age` <= 50 then '[41-50]' 
		when `age` >= 51 and `age` <= 60 then '[51-60]' 
		when `age` >= 61 then '[61+]' 
        
        end as 'age_group',
	count(`age`) as 'wizzard_count'
from wizzard_deposits
group by `age_group`
order by `age_group`;



# problem 10 - First Letter

select substr(`first_name`, 1, 1) as 'first_letter'
from wizzard_deposits
where deposit_group = 'Troll Chest'
group by `first_letter`
order by `first_letter`;



# problem 11 - Average Interest

select `deposit_group`, `is_deposit_expired`, avg(`deposit_interest`) as 'average_interest'
from wizzard_deposits
where `deposit_start_date` > '1985-01-01'
group by `deposit_group`, `is_deposit_expired`
order by `deposit_group` desc, `is_deposit_expired`;



# problem 12 - Employees Minimum Salaries

select `department_id`, min(`salary`) as 'minimum_salary'
from employees
where `department_id` in (2,5,7) and `hire_date` > '2000-01-01'
group by `department_id`
order by `department_id`;



# problem 13 - Employees Average Salaries

create table `v_empl` as
select `department_id`, `salary` from employees
where `manager_id` != 42 and `salary` > 30000;

update `v_empl`
set `salary` = `salary` + 5000
where `department_id` = 1;

select `department_id`, avg(`salary`) as `avg_salary` from v_empl
group by `department_id`
order by `department_id`;



# problem 14 - Employees Maximum Salaries

select `department_id`, max(`salary`) as 'max_salary' from employees
group by `department_id`
having `max_salary` not between 30000 and 70000
order by `department_id`;



# problem 15 - Employees Count Salaries

select count(*) from employees
where `manager_id` is null;



# problem 16 - 3rd Highest Salary

select `e`.`department_id`, (
select distinct `salary` from employees
where `department_id` = `e`.`department_id`
order by `salary` desc
limit 2,1
) as 'third_highest_salary'
from employees as `e`
group by `department_id`
having `third_highest_salary` is not null
order by `department_id`;



# problem 17 - Salary Challenge

select `e1`.`first_name`, `e1`.`last_name`, `e1`.`department_id` 
from `employees` as `e1`
join 
(select `e2`.`department_id`, avg(`e2`.`salary`) as `dep_avg`
from `employees` as `e2`
group by `e2`.`department_id`) as `e3` on `e1`.`department_id` = `e3`.`department_id`
where `salary` > `e3`.`dep_avg`
order by `department_id`, `employee_id`
limit 10;



# problem 18 - Departments Total Salaries

select `department_id`, sum(`salary`) as 'total_salary'
from `employees`
group by `department_id`
order by `department_id`;