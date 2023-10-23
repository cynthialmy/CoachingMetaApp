drop table if exists user_relationship;
drop table if exists clients;
drop table if exists coaches;
drop table if exists client_match;
drop table if exists planTasks;
drop table if exists workout;

create table user_relationship (
    uid varchar(255),
    userRole Integer,
    primary key (uid)
) engine = innodb;

insert into user_relationship values('client1', 1);

create table clients (
	client_id varchar(255),
    client_name varchar(255),
	birthday varchar(255),
    gender varchar(255),
	height varchar(255),
    weight varchar(255),
	exercise_preference Integer,   
    primary key (client_id)
) engine = innodb;

insert into clients values('client1', "Guanming Chen", "06291996", "male", "1.80", "80", 1);
insert into clients values('client2', "Guanming Chen", "06291996", "male", "1.80", "80", 1);

create table coaches (
    coach_id varchar(255),
    coach_name varchar(255),
	birthday varchar(255),
    gender varchar(255),
	height varchar(255),
    weight varchar(255),
	coaching_experience Integer,
    specialization varchar(255),
    primary key (coach_id)
) engine = innodb;

insert into coaches values('coach1', 'Mengyuan Li', "06291996", 'famale', "1.70", "50", 10, 'running');

create table client_match (
    client_id varchar(255),
	coach_id varchar(255),
    primary key (client_id, coach_id)
) engine = innodb;

insert into client_match values('client1', 'coach1');
insert into client_match values('client2', 'coach1');

create table planTasks (
    task_id varchar(255),
    task_name varchar(255),
    update_date varchar(255),
    client_id varchar(255),
    isDone Integer,
    description varchar(255),
    primary key (task_id, update_date)
) engine = innodb;

insert into planTasks values('t1', 'task1', '03062023', 'client1', 1, 'running 30min');
insert into planTasks values('t2', 'task2', '03062023', 'client1', 1, 'running 30min');
insert into planTasks values('t3', 'task1', '03072023', 'client1', 1, 'running 30min');
insert into planTasks values('t4', 'task3', '03072023', 'client1', 1, 'running 30min');

create table workout (
    client_id varchar(255),
    update_date varchar(255),
    duration Integer,
    oxygen_saturation double,
	heart_rate Integer,
	calories Integer,
    notes varchar(255),
    primary key (client_id, update_date)
) engine = innodb;

insert into workout values('client1', '20230306', 30, 99.91, 110, 500, 'workout1');

select * from planTasks where client_id = 'client1' and update_date = '20230307';

select * from planTasks where update_date = (select update_date from planTasks where client_id = 'client1' order by update_date desc limit 1);



select * from clients where client_id in (select client_id from client_match where coach_id = 'coach1');

select update_date from planTasks where client_id = 'client1' group by update_date;

select * from client_match where client_id = 'client1';

update client_match set coach_id = 'coach2' where client_id = 'client1'