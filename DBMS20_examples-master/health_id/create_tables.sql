create table user(
    ID char(10),
    PID char(10) not null,
    primary key (ID),
    index (PID)
);

create table inbound(
    PID char(10),
    IATA_code varchar(10) not null,
    flight_no varchar(10),
    date date,
    primary key (PID, flight_no, date),
    index (PID, IATA_code)
);

create table airport(
    IATA_code varchar(10),
    city varchar(50) not null,
    country varchar(30) not null,
    primary key (IATA_code),
    index (IATA_code)
);

load data local infile './user.csv'
into table user
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './inbound.csv'
into table inbound
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './airports.csv'
into table airport
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
