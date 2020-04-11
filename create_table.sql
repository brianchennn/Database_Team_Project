create table champs(
    champion_name varchar(15) not null,
    champion_id int default 0 NOT NULL,
    primary key (champion_id)
);
load data local infile './champs.csv'
into table champs
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table match_info(
    match_id int default 0 NOT NULL,
    duration int,
    version varchar(15),
    primary key (match_id)
);

load data local infile './matches.csv'
into table match_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


create table participant(
    player_id int NOT NULL,
    match_id int NOT NULL,
    player tinyint ,
    champion_id int NOT NULL,
    ss1 varchar(15),
    ss2 varchar(15),
    position varchar(13) NOT NULL
    primary key (player_id),
    foreign key (match_id) references match_info(match_id)
);
load data local infile './participants.csv'
into table participant
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table teamban(
    match_id int NOT NULL,
    team char(1) NOT NULL,
    champion_id int NOT NULL,
    banturn tinyint NOT NULL,
    primary key (match_id, banturn)
)
create table stat(
    player_id int NOT NULL,
    win boolean,
    item1 smallint,
    item2 smallint,
    item3 smallint,
    item4 smallint,
    item5 smallint,
    item6 smallint,
    kills tinyint,
    deaths tinyint,
    assists tinyint,
    longesttimespentliving smallint,
    doublekills tinyint,
    triplekills tinyint,
    quadrakills tinyint,
    pentakills tinyint,
    primary key(player_id)
);








load data local infile './teambans.csv'
into table teamban
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './stats.csv'
into table stat
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


