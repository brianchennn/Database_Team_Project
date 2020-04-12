create table travel_alert(
    area varchar(60),
    security_level varchar(20) not null,
    instruction varchar(20) not null,
    primary key (area)
);

create table inbord(
    id_card char(10),
    province varchar(50),
    country varchar(30) not null,
    inbord_date datetime,
    primary key (id_card)
);

load data local infile './TravelAlert.csv'
into table travel_alert
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './fake_data.csv'
into table inbord
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;