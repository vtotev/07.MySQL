# Part I – Queries for SoftUni Database

# problem 1 - Employees with Salary Above 35000

delimiter $$ 
create procedure `usp_get_employees_salary_above_35000`()
begin
	select first_name, last_name from employees
    where salary > 35000
    order by first_name, last_name, employee_id;
end;

delimiter ;



# problem 2 - Employees with Salary Above Number

delimiter $$

create procedure `usp_get_employees_salary_above` (slry decimal(10,4))
begin
	select first_name, last_name from employees
    where salary >= slry
    order by first_name, last_name, employee_id;
end;

delimiter ;



# problem 3 - Town Names Starting With

delimiter $$

create procedure `usp_get_towns_starting_with` (starting_str varchar(20))
begin
	select `name` from towns
    where `name` like concat(starting_str,'%')
    order by `name`;
end;

delimiter ;



# problem 4 - Employees from Town

delimiter $$

create procedure `usp_get_employees_from_town` (`t_name` varchar(50))
begin
	select first_name, last_name from employees e
    join addresses a on e.address_id = a.address_id
    join towns t on a.town_id = t.town_id
    where t.`name` = t_name
    order by first_name, last_name, employee_id;
end;

delimiter ;



# problem 5 - Salary Level Function

delimiter $$

create function `ufn_get_salary_level`(input_salary varchar(10))	
returns varchar(10)
begin
	declare result varchar(10);
	return case
    when input_salary < 30000 then 'Low'
    when input_salary >= 30000 and input_salary <= 50000 then 'Average'
    when input_salary > 50000 then 'High'
    end;
end;

delimiter ;



# problem 6 - Employees by Salary Level

delimiter $$

create procedure `usp_get_employees_by_salary_level`(salary_level varchar(10))
begin
	select first_name, last_name from employees
    where 
	case salary_level
    when 'low' then salary < 30000
    when 'average' then salary >= 30000 and salary <= 50000
    when 'high' then salary > 50000
    end
    order by first_name desc, last_name desc;
end;

delimiter ;



# problem 7 - Define Function

delimiter $$

create function ufn_is_word_comprised(letters VARCHAR(50), word varchar(50))
returns BIT
begin
return if(lower(word) REGEXP CONCAT('^[', lower(letters), ']+$'), true, false);
end;

delimiter ;




# PART II – Queries for Bank Database

# problem 8 - 

delimiter $$

create procedure `usp_get_holders_full_name`()
begin
	select concat_ws(' ', first_name, last_name) as `full_name` from account_holders
    order by full_name, id;
end;

delimiter ;



# problem 9 - People with Balance Higher Than

delimiter $$

create procedure `usp_get_holders_with_balance_higher_than`(bal decimal(20,4))
begin
	select full_balance.first_name, full_balance.last_name from 
	(select ah.id, ah.first_name, ah.last_name, sum(a.balance) as `sum` from account_holders as ah
	join accounts a on a.account_holder_id = ah.id
	group by ah.id) as full_balance
	where full_balance.`sum` > bal
	order by full_balance.id;
end;

delimiter ;



# problem 10 - Future Value Function

delimiter $$

create function `ufn_calculate_future_value`(sum decimal(20,4), interest double, years int)
returns decimal (20,4)
begin
	declare result decimal(20,4);
    set result := sum * pow((1 + interest), years);
    return result;
end;

delimiter ;



# problem 11 - Calculating Interest

delimiter $$

create function `ufn_calculate_future_value`(sum decimal(20,4), interest double, years int)
returns decimal (20,4)
begin
	declare result decimal(20,4);
    set result := sum * pow((1 + interest), years);
    return result;
end;

delimiter ;

delimiter $$

create procedure `usp_calculate_future_value_for_account`(id int, rate decimal(20,4))
begin
select total.id, total.first_name, total.last_name, total.current_balance, ufn_calculate_future_value(total.current_balance, rate, 5) as `total.balance_in_5_years`
	from (
	select a.id, ah.first_name, ah.last_name, a.balance as `current_balance` 
	from account_holders ah
	join accounts a on a.account_holder_id = ah.id
	) as total
    where total.id = id;
end;

delimiter ;



# problem 12 - Deposit Money

USE `soft_uni`;
DROP procedure IF EXISTS `usp_deposit_money`;

DELIMITER $$
USE `soft_uni`$$
CREATE PROCEDURE `usp_deposit_money` (account_id int, money_amount decimal(19,4))
BEGIN
	if (money_amount > 0) then 
		update accounts
		set balance = balance + money_amount
		where id = account_id;
    end if;
END$$

DELIMITER ;

call usp_deposit_money(1, 10);
select id, balance from accounts where id = 1;



# problem 13 - Withdraw Money

USE `soft_uni`;
DROP procedure IF EXISTS `usp_withdraw_money`;

DELIMITER $$
USE `soft_uni`$$
CREATE PROCEDURE `usp_withdraw_money` (account_id int, money_amount decimal(19,4))
BEGIN
	if money_amount >= 0 and money_amount <= (select balance from accounts where id = account_id)
    then
		update accounts
        set balance = balance - money_amount
        where id = account_id;
    end if;
END$$

DELIMITER ;



# problem 14 - Money Transfer

USE `soft_uni`;
DROP procedure IF EXISTS `soft_uni`.`usp_transfer_money`;
;

DELIMITER $$
USE `soft_uni`$$
CREATE PROCEDURE `usp_transfer_money`(from_account_id int, to_account_id int, amount decimal(19,4))
BEGIN
	declare successful bool;
    set successful = true;
    start transaction;
    
	if (from_account_id = to_account_id) then set successful = false; end if;
    if amount < 0 then set successful = false; end if;
    if (select count(*) from accounts where id in (from_account_id, to_account_id)) != 2 then
		set successful = false;
	end if;
    
    if (select balance from accounts where id = from_account_id) < amount then
		set successful = false;
    end if;
    
    update accounts
    set balance = balance - amount
    where id = from_account_id;
    
    update accounts
    set balance = balance + amount
    where id = to_account_id;

    if successful then commit;
    else rollback;
    end if;
END$$

DELIMITER ;

