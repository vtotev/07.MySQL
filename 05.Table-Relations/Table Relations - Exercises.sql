# problem 1 - One-To-One Relationship

CREATE TABLE `passports` (
  `passport_id` INT NOT NULL,
  `passport_number` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`passport_id`));

CREATE TABLE `people` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `passport_id` INT NOT NULL UNIQUE,
  PRIMARY KEY (`person_id`),
  INDEX `fk_passport_idx` (`passport_id` ASC) VISIBLE,
  CONSTRAINT `fk_passport`
    FOREIGN KEY (`passport_id`)
    REFERENCES `passports` (`passport_id`));

INSERT INTO `passports` (`passport_id`, `passport_number`) 
VALUES 
('101', 'N34FG21B'),
('102', 'K65LO4R7'),
('103', 'ZE657QP2');

INSERT INTO `people` (`first_name`, `salary`, `passport_id`)
VALUES 
('Roberto', '43300.00', '102'),
('Tom', '56100.00', '103'),
('Yana', '60200.00', '101');



# problem 2 - One-To-Many Relationship

create table `manufacturers` (
	`manufacturer_id` int auto_increment primary key,
    `name` varchar(50) not null,
    `established_on` date not null
);

create table `models` (
	`model_id` int primary key not null auto_increment,
    `name` varchar(50) not null,
    `manufacturer_id` int not null,
    CONSTRAINT fk_manufacturers_models FOREIGN KEY (manufacturer_id)
	REFERENCES manufacturers(manufacturer_id)
)AUTO_INCREMENT=101;

INSERT INTO manufacturers (name, established_on)
	VALUES ('BMW', '1916-03-01'),
		('Tesla', '2003-01-01'),
		('Lada', '1966-05-01');

INSERT INTO models (name, manufacturer_id)
    VALUES('X1', 1),
		('i6', 1),
		('Model S', 2),
		('Model X', 2),
		('Model 3', 2),
		('Nova', 3);
        
        
        
# problem 3 - Many-To-Many Relationship

create table `students` (
	`student_id` int UNSIGNED not null auto_increment,
    `name` varchar(60) not null,
   CONSTRAINT pk_students PRIMARY KEY (student_id));

create table `exams` (
	`exam_id` int UNSIGNED not null auto_increment,
    `name` varchar(60) not null,
    CONSTRAINT pk_exams PRIMARY KEY (exam_id)
) auto_increment = 101;

create table `students_exams` (
	`student_id` int unsigned,
	`exam_id` int unsigned
);

ALTER TABLE students_exams
	ADD CONSTRAINT pk_students_exams PRIMARY KEY (student_id , exam_id),
	ADD CONSTRAINT fk_students_exams_students FOREIGN KEY (student_id)
        REFERENCES students (student_id),
	ADD CONSTRAINT fk_students_exams_exams FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id);
        
insert into students (`name`) 
values ('Mila'),
	('Toni'),
	('Ron');
    
insert into exams (`name`)
values 
	('Spring MVC'),
	('Neo4j'),
	('Oracle 11g');
    
insert into `students_exams`
values 
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103);



# problem 4 - Self-Referencing

create table `teachers` (
	`teacher_id` int not null auto_increment,
    `name` varchar(60) not null,
    `manager_id` int,
    constraint pk_teacher PRIMARY KEY (`teacher_id`)
) auto_increment = 101;

insert into `teachers` (`name`, `manager_id`)
values
	('John', null),
	('Maya', 106),
	('Silvia', 106),
	('Ted', 105),
	('Mark', 101),
	('Greta', 101);
    
alter table `teachers`
add constraint fk_manager_teacher foreign key  (`manager_id`)
references `teachers`(`teacher_id`);



# problem 5 - Online Store Database

CREATE DATABASE online_store;

USE online_store;

create table `item_types` (
	`item_type_id` int primary key auto_increment not null,
    `name` varchar(50) not null
);

create table `cities` (
	`city_id` int primary key not null auto_increment,
    `name` varchar(50) not null
);

create table `items` (
	`item_id` int not null primary key auto_increment,
    `name` varchar(50) not null,
    `item_type_id` int not null,
    constraint fk_item_type foreign key (`item_type_id`) references `item_types`(`item_type_id`)
);

create table `customers` (
	`customer_id` int primary key not null auto_increment,
    `name` varchar(50) not null,
    `birthday` date,
    `city_id` int not null
);

create table `orders` (
	`order_id` int primary key not null auto_increment,
    `customer_id` int not null
);

create table `order_items` (
	`order_id` int not null,
    `item_id` int not null,
	constraint primary key (order_id, item_id)
);

alter table `customers`
add constraint fk_city_id foreign key (`city_id`) references `cities`(`city_id`);

alter table `orders`
add constraint fk_customer_id foreign key (`customer_id`) references `customers`(`customer_id`);


alter table `order_items`
add constraint fk_order_id foreign key (`order_id`) references `orders`(`order_id`),
add constraint fk_item_id foreign key (`item_id`) references `items`(`item_id`);



# problem 6 - University Database

create database if not exists `university`;
use `university`;

create table `subjects` (
	`subject_id` int primary key not null auto_increment,
    `subject_name` varchar(50) not null
);

create table `majors` (
	`major_id` int primary key not null auto_increment,
    `name` varchar(50) not null
);

create table `payments` (
	`payment_id` int primary key not null auto_increment,
    `payment_date` date,
    `payment_amount` decimal(8,2),
    `student_id` int not null
);

create table `students` (
	`student_id` int primary key not null auto_increment,
    `student_number` varchar(12) not null,
    `student_name` varchar (50) not null,
    `major_id` int not null,
    constraint fk_major_id foreign key (major_id) references `majors`(`major_id`)
);

alter table payments
add constraint fk_student_id foreign key (student_id) references `students`(`student_id`);

create table `agenda` (
	`student_id` int,
	`subject_id` int,
    constraint primary key (student_id, subject_id),
    constraint fk_stud_id foreign key (`student_id`) references `students`(`student_id`),
    constraint fk_subj_id foreign key (`subject_id`) references `subjects`(`subject_id`)
);



# problem 9 - Peaks in Rila

use geography;

select m.`mountain_range`, p.`peak_name`, p.`elevation` from peaks as p
join `mountains` as m
on m.`id` = p.`mountain_id`
where m.`mountain_range` = 'Rila'
order by elevation desc;