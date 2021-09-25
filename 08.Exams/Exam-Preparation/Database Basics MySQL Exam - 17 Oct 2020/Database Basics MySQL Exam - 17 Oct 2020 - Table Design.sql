drop database softuni_stores_system;
create database softuni_stores_system;
use softuni_stores_system;

create table pictures (
	id int(11) primary key auto_increment,
    url varchar(100) not null,
    added_on datetime not null
);

create table categories (
	id int(11) primary key auto_increment,
    `name` varchar(40) not null unique
);

create table products (
	id int(11) primary key auto_increment,
    `name` varchar(40) not null unique,
    best_before date,
    price decimal(10,2) not null,
    `description` text,
    category_id int(11) not null,
    picture_id int(11) not null,
    constraint fk_category foreign key (category_id) references categories(id),
    constraint fk_picture foreign key (picture_id) references pictures(id)
);

create table towns (
	id int(11) primary key auto_increment,
    `name` varchar (20) not null unique
);

create table addresses (
	id int(11) primary key auto_increment,
    `name` varchar(50) not null unique,
    town_id int(11) not null,
    constraint fk_town_id foreign key (town_id) references towns(id)
);

create table stores (
	id int(11) primary key auto_increment,
    `name` varchar(20) not null unique,
    rating float not null,
    has_parking tinyint(1) default false,
    address_id int(11) not null,
    constraint fk_address_id foreign key (address_id) references addresses(id)
);

create table employees(
	id int(11) primary key auto_increment,
    first_name varchar(15) not null,
    middle_name char(1),
    last_name varchar(20) not null,
    salary decimal(19,2) not null default 0,
    hire_date date not null,
    manager_id int(11),
    store_id int(11) not null,
    constraint fk_store_id foreign key (store_id) references stores(id),
    constraint fk_empl_empl foreign key (manager_id) references employees(id)
);

create table products_stores(
	product_id int(11) not null,
	store_id int(11) not null,
    primary key(product_id, store_id),
    constraint fk_product foreign key (product_id) references products(id),
    constraint fk_store foreign key (store_id) references stores(id)
);