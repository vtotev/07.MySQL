# problem 1 - Mountains and Peaks

CREATE TABLE `mountains` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `peaks` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `mountain_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_peak_mountain_idx` (`mountain_id` ASC) VISIBLE,
  CONSTRAINT `fk_peak_mountain`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountains` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



# problem 2 - Trip Organization

select `v`.`driver_id`, `v`.`vehicle_type`, concat_ws(' ', `c`.`first_name`, `c`.`last_name`) as 'driver_namr'
from vehicles as `v`
join campers as `c`
on `v`.`driver_id` = `c`.`id`;



# problem 3 - SoftUni Hiking

select `r`.`starting_point`, `r`.`end_point`, `r`.`leader_id`, concat_ws(' ', `c`.`first_name`, `c`.`last_name`)
from `routes` as `r`
join `campers` as `c`
on `r`.`leader_id` = `c`.`id`;



# problem 4 - Delete Mountains

CREATE TABLE `mountains`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL);

CREATE TABLE `peaks`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL,
`mountain_id` INT,
CONSTRAINT `fk_mountain_id`
FOREIGN KEY(`mountain_id`)
REFERENCES `mountains`(`id`)
ON DELETE CASCADE);