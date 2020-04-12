create table patient(
    id int,
    age int,
    sex varchar(10),
    city varchar(50),
    province varchar(50),
    country varchar(30),
    latitude float,
    longitude float,
    date_confirmation date,
    lives_in_Wuhan varchar(80),
    travel_history_dates date,
    travel_history_location varchar(80),
    primary key (id)
);

load data local infile './new_patient_data.csv'
into table patient
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


create table region_acc(
    province varchar(50),
    country varchar(30),
    data_date date,
    confirmed_num int,
    deaths_num int,
    recovered_num int,
    primary key (province, country, data_date)
);

load data local infile './new_accumulate_data.csv'
into table region_acc
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;