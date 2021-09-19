# problem 1 - Departments Info

select `department_id`, count(`department_id`) as 'Count'
from employees
group by `department_id`
order by `department_id`;



# problem 2 - Average Salary

select `department_id`, round(avg(`salary`) , 2) as 'Average Salary'
from employees
group by `department_id`
order by `department_id`;



# problem 3 - Minimum Salary

select `department_id`, round(min(`salary`),2) as 'Min Salary'
from employees
group by `department_id`
having `Min Salary` > 800
order by `department_id`;



# problem 4 - Appetizers Count

select count(*) as 'Count' from products as `p`
where `category_id` = 2 and `price` > 8;




# problem 5 - Menu Prices

select `category_id`,
	round(avg(`price`), 2) as 'Average Price',
	round(min(`price`), 2) as 'Cheapest Product',
	round(max(`price`), 2) as 'Most Expensive Product'
from products
group by `category_id`;