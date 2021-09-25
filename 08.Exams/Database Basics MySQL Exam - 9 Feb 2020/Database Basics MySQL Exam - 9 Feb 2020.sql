# problem 1 - Table Design

create database if not exists exam;

use exam;

create table skills_data (
	id int not null primary key auto_increment,
    dribbling int not null default 0,
    pace int not null default 0,
    passing int not null default 0,
    shooting int not null default 0,
    speed int not null default 0,
    strength int not null default 0
);

create table countries (
	id int not null primary key auto_increment,
    `name` varchar(45) not null
);

create table towns (
	id int not null primary key auto_increment,
    `name` varchar(45) not null,
    country_id int not null,
    constraint fk_country_id foreign key (country_id) references countries(id)
);

create table stadiums (
	id int not null primary key auto_increment,
    `name` varchar (45) not null,
    capacity int not null,
    town_id int not null,
    constraint fk_town_id foreign key (town_id) references towns(id)
);

create table teams (
	id int not null primary key auto_increment,
    `name` varchar(45) not null,
    established date not null,
    fan_base bigint not null default 0,
    stadium_id int not null,
    constraint fk_stadium_id foreign key (stadium_id) references stadiums(id)
);

create table players (
	id int primary key not null auto_increment,
    first_name varchar(10) not null,
    last_name varchar(20) not null,
    age int not null default 0,
    position char not null,
    salary decimal(10,2) not null default 0,
    hire_date datetime,
    skills_data_id int not null,
    team_id int,
    constraint fk_skills_data foreign key (skills_data_id) references skills_data(id),
    constraint fk_team_id foreign key (team_id) references teams(id)
);


create table coaches (
	id int primary key not null auto_increment,
    first_name varchar(10) not null,
    last_name varchar(20) not null,
    salary decimal(10,2) not null default 0,
    coach_level int not null default 0
);

create table players_coaches (
	player_id int not null,
	coach_id int not null,
    constraint primary key (player_id, coach_id),
    constraint fk_player_id foreign key (player_id) references players(id),
    constraint fk_coach_id foreign key (coach_id) references coaches(id)
);



# problem 2 - Insert

insert into coaches (first_name, last_name, salary, coach_level)
select first_name, last_name, salary*2, length(first_name) from players
where age >= 45;


# problem 3 - Update

update coaches
set coach_level = coach_level + 1
where left (first_name, 1) = 'A' 
and id in (select coach_id from players_coaches);



# problem 4 - Delete

delete from players
where age >= 45;



# problem 5 - Players

select first_name, age, salary from players
order by salary desc;



# problem 6 - Young offense players without contract

select p.id, concat_ws(' ', p.first_name, p.last_name) as `full_name`, p.age, p.position, p.hire_date from players p
join skills_data sd on p.skills_data_id = sd.id
where position = 'A' and hire_date is null and sd.strength > 50
order by salary, age;



# problem 7 - Detail info for all teams

select t.`name` as `team_name`, t.established, t.fan_base, 
(select count(*) from players p where p.team_id = t.id) as 'players_count' from teams t
order by `players_count` desc, fan_base desc;



# problem 8 - The fastest player by towns


select max(sd.speed) as `max_speed`, t.`name` from players p
join skills_data sd on sd.id = p.skills_data_id
right join teams tm on p.team_id = tm.id
join stadiums st on tm.stadium_id = st.id
join towns t on t.id = st.town_id
where tm.`name` != 'Devify'
group by t.`name`
order by `max_speed` desc, t.`name`;



# problem 9 - Total salaries and players by country

select c.`name`, count(p.id) as `total_count_of_players`, sum(p.salary) as `total_sum_of_salaries`
from players p
join teams t on t.id = p.team_id
join stadiums s on s.id = t.stadium_id
join towns tn on tn.id = s.town_id
right join countries c on c.id = tn.country_id
group by c.`name`
order by `total_count_of_players` desc, `name`



# problem 10 - Find all players that play on stadium

delimiter $$

create function `udf_stadium_players_count` (stadium_name VARCHAR(30)) 
returns int
begin
	return select count(*) from players p
	join teams t on t.id = p.team_id
	join stadiums st on st.id = t.stadium_id
	where st.`name` = stadium_name;
end;

delimiter ;

SELECT udf_stadium_players_count ('Jaxworks') as `count`; 

SELECT udf_stadium_players_count ('Linklinks') as `count`; 



# problem 11 - Find good playmaker by teams

delimiter $$

CREATE PROCEDURE `udp_find_playmaker` (min_dribble_points int, team_name varchar(45))
BEGIN
	select concat_ws(' ', p.first_name, p.last_name), p.age, p.salary, sd.dribbling, sd.speed, tm.`name` from players p
	join skills_data sd on sd.id = p.skills_data_id
	join teams tm on tm.id = p.team_id
	where sd.dribbling > min_dribble_points and `speed` > (select avg(speed) from skills_data) and tm.`name` = team_name
	order by `speed`desc
	limit 1;
END

delimiter ;

CALL udp_find_playmaker (20, ‘Skyble’);