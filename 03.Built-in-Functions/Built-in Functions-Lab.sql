# problem 1 - Find Book Titles

select title from books
where title like 'The%'
order by id;



# problem 2 - Replace Titles

select replace(title, 'The', '***') as 'title' from books
where title like 'The%'
order by id;



# problem 3 - Sum Cost of All Books

select round(sum(cost), 2) as sum
from books;



# problem 4 - Days Lived

select concat_ws(" ", first_name, last_name) as 'Full Name', timestampdiff(day, born, died)  as 'Days Lived'
#if(died, 'NULL', timestampdiff(" ", died, born)) as 'Days Lived'
from authors;



# problem 5 - Harry Potter Books

select title from books
where title like '%potter%'
order by id;