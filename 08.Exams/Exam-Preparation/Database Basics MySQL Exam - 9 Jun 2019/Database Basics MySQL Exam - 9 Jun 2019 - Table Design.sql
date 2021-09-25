drop database if exists ruk_database;
create database ruk_database;
use ruk_database;

create table branches (
	id int(11) primary key auto_increment,
    `name` varchar(30) not null unique
);

create table employees (
	id int(11) primary key auto_increment,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    salary decimal(10,2) not null,
    started_on date not null,
    branch_id int(11) not null,
    constraint fk_branch_id foreign key (branch_id) references branches(id)
);

create table clients(
	id int(11) primary key auto_increment,
    full_name varchar(50) not null,
    age int(11) not null
);

create table bank_accounts (
	id int(11) primary key auto_increment,
    account_number varchar(10) not null,
    balance decimal(10,2) not null,
    client_id int(11) not null unique,
    constraint fk_client_id foreign key (client_id) references clients(id)
);

create table cards (
	id int(11) primary key auto_increment,
    card_number varchar(19) not null,
    card_status varchar(7) not null,
    bank_account_id int(11) not null,
    constraint fk_bank_acc_id foreign key (bank_account_id) references bank_accounts(id)
);

create table employees_clients (
	employee_id int(11),
	client_id int(11),
    constraint fk_empl_empl foreign key (employee_id) references employees(id),
    constraint fk_client_clients foreign key (client_id) references clients(id)
);