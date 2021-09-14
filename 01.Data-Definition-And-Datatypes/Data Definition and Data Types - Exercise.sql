# problem 1 - Create Tables

CREATE TABLE `minions` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`age` INT
);

CREATE TABLE `towns` (
`town_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);




# problem 2 - Alter Minions Table

ALTER TABLE `minions` 
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_minions_towns
  FOREIGN KEY (`town_id`)
  REFERENCES `towns`(`id`);




# problem 3 - Insert Records in Both Tables

INSERT INTO `towns`
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO `minions`
VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', null, 2);



# problem 4 - Truncate Table Minions

TRUNCATE `minions`;



# problem 5 - Drop All Tables

SET FOREIGN_KEY_CHECKS = 0;
drop table if exists `minions`;
drop table if exists `towns`;
SET FOREIGN_KEY_CHECKS = 1;




# problem 6 - Create Table People

CREATE TABLE `people` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `picture` BLOB NULL,
  `height` FLOAT NULL,
  `weight` FLOAT NULL,
  `gender` CHAR(1) NOT NULL,
  `birthdate` VARCHAR(45) NOT NULL,
  `biography` LONGTEXT NULL,
  PRIMARY KEY (`id`));

INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) VALUES ('Ivan', '1.7', '65', 'm', '24-06-1990');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) VALUES ('Peter', '1.85', '80', 'm', '14-08-2001');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) VALUES ('Gergana', '1.55', '47', 'f', '14-04-2003');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) VALUES ('Ekaterina', '1.65', '50', 'f', '08-05-1993');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) VALUES ('Mihaela', '1.68', '53', 'f', '25-03-1997');




# problem 7 - Create Table Users

CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(26) NOT NULL,
  `profile_picture` MEDIUMBLOB NULL,
  `last_login_time` DATETIME NULL,
  `is_deleted` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE);

INSERT INTO `users` (`username`, `password`, `is_deleted`) VALUES ('ivan_moody', 'password1', '0');
INSERT INTO `users` (`username`, `password`, `is_deleted`) VALUES ('jason_hook', 'jason2', '0');
INSERT INTO `users` (`username`, `password`, `is_deleted`) VALUES ('jeremy_spencer', 'jeremy3', '0');
INSERT INTO `users` (`username`, `password`, `is_deleted`) VALUES ('dukes_of_hazzard', 'dukes22', '1');
INSERT INTO `users` (`username`, `password`, `is_deleted`) VALUES ('longest-run', 'runner5', '1');



# problem 8 - Change Primary Key

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id,username);



# problem 9 - Set Default Value of a Field

ALTER TABLE `users` 
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME NULL DEFAULT NOW() ;



# problem 10 - Set Unique Field

alter table `users`
drop primary key,
ADD CONSTRAINT pk_users PRIMARY KEY(id),
ADD CONSTRAINT uq_username UNIQUE (username);



# problem 11 - Movies Database

create table directors (
id INT Primary key AUTO_INCREMENT,
director_name VARCHAR(50) NOT NULL,
notes TEXT
);

create table genres (
id INT Primary key AUTO_INCREMENT,
genre_name VARCHAR(50) NOT NULL,
notes TEXT
);

create table categories (
id INT Primary key AUTO_INCREMENT,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

create table movies (
id INT Primary key AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
director_id int not null,
copyright_year int not null,
length int not null,
genre_id int not null,
category_id int not null,
rating float not null,
notes TEXT
);

insert into directors (director_name) 
values ('Michael Bay'),
('Mel Gibsn'),
('George Lucas'),
('Quentin Tarantino'),
('Guy Ritchie');

insert into genres (genre_name)
values ('action'),
('drama'),
('comedy'),
('Mystery'),
('sci-fi');

insert into categories (category_name)
values ('all ages'),
('12 above'),
('16 above'),
('18+'),
('kids');

insert into movies (title, director_id, copyright_year, length, genre_id, category_id, rating)
values ('Avatar', 3, 2009, 162, 5, 2, 9),
	   ('Django Unchained', 4, 2012, 165, 1, 2, 9.3),
	   ('Armageddon', 1, 1998, 151, 2, 2, 9.5),
	   ('The Passion of the Christ', 2, 2004, 127, 2, 3, 8.9),
	   ('Sherlock Holmes: A Game of Shadows', 5, 2011, 129, 4, 3, 8.9);




# problem 12 - Car Rental Database

CREATE TABLE categories 
(
id INT PRIMARY KEY AUTO_INCREMENT, 
category VARCHAR(20) NOT NULL, 
daily_rate INT, 
weekly_rate INT, 
monthly_rate INT, 
weekend_rate INT
);

INSERT INTO categories (category)
VALUES
("Car"),("Minivan"),("Bus");

CREATE TABLE cars 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
plate_number VARCHAR(20) NOT NULL, 
make VARCHAR(20) NOT NULL,
model VARCHAR(20) NOT NULL,
car_year YEAR NOT NULL,
category_id INT NOT NULL,  
doors INT NOT NULL, 
picture BLOB, 
car_condition  VARCHAR(20) NOT NULL, 
available BOOL NOT NULL
);

INSERT INTO cars 
(plate_number,make,model,car_year,category_id,doors,car_condition,available)
VALUES
("Car","Car","Car",'2000',2,2,"Car",TRUE),
("Car","Car","Car",'2000',2,2,"Car",TRUE),
("Car","Car","Car",'2000',2,2,"Car",TRUE);

CREATE TABLE employees 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL,  
title VARCHAR(20) NOT NULL,  
notes TEXT
);

INSERT INTO employees 
(first_name,last_name,title)
VALUES
("Car","Car","Car"),
("Car","Car","Car"),
("Car","Car","Car");

CREATE TABLE customers 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
driver_licence_number VARCHAR(20) NOT NULL, 
full_name VARCHAR(20) NOT NULL, 
address VARCHAR(50) NOT NULL,  
city VARCHAR(20) NOT NULL, 
zip_code  INT NOT NULL,
notes TEXT
);

INSERT INTO customers 
(driver_licence_number,full_name,address,city,zip_code)
VALUES
("Car","Car","Car","Car",4000),
("Car","Car","Car","Car",4000),
("Car","Car","Car","Car",4000);

CREATE TABLE rental_orders 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
employee_id INT NOT NULL, 
customer_id INT NOT NULL, 
car_id INT NOT NULL, 
car_condition VARCHAR(20) NOT NULL, 
tank_level INT NOT NULL,  
kilometrage_start INT NOT NULL , 
kilometrage_end INT NOT NULL, 
total_kilometrage INT NOT NULL, 
start_date DATETIME NOT NULL, 
end_date DATETIME NOT NULL, 
total_days INT NOT NULL, 
rate_applied INT, 
tax_rate INT, 
order_status VARCHAR(20), 
notes TEXT
);

INSERT INTO rental_orders 
(employee_id,customer_id,car_id,car_condition,tank_level,kilometrage_start,
kilometrage_end,total_kilometrage,start_date,end_date,total_days)
VALUES
(1,1,1,"Car",1,1,1,1,'2020-01-01 11:30:00','2021-01-01 19:10:00',5),
(1,1,1,"Car",1,1,1,1,'2020-02-02 12:40:00','2021-02-02 20:20:00',5),
(1,1,1,"Car",1,1,1,1,'2020-03-03 13:50:00','2021-03-03 21:30:00',5);




# problem 13 - Basic Insert

insert into towns (name)
Values
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

insert into departments (name)
values 
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

insert into employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
values 
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);



# problem 14 - Basic Select All Fields

select * from towns;

select * from departments;

select * from employees;




# problem 15 - Basic Select All Fields and Order Them

select * from towns
order by name asc;

select * from departments
order by name asc;

select * from employees
order by salary desc;




# problem 16 - Basic Select Some Fields

select `name` from towns
order by `name` asc;

select `name` from departments
order by `name` asc;

select `first_name`, `last_name`, `job_title`, `salary` from employees
order by `salary` desc;




# problem 17 - Increase Employees Salary

update employees
set salary = salary * 1.1;

select salary from employees;



# problem 18 - Delete All Records

truncate occupancies;