# problem 1 - Create Tables

CREATE TABLE `employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`)
);



# problem 2 - Insert Data in Tables

INSERT INTO `employees`
VALUES 
(1, 'Pesho', 'Peshov'),
(2, 'Gosho', 'Goshov'),
(3, 'Ivan', 'Ivanov');



# problem 3 - Alter Table

ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(20);




# problem 4 - Adding Constraints

ALTER TABLE `products`
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (`category_id`)  REFERENCES `categories`(`id`);



# problem 5 - Modifying Columns

ALTER TABLE `employees` 
CHANGE COLUMN `middle_name` `middle_name` VARCHAR(100);
