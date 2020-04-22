create table atbats(
    ab_id varchar(10) not null,
    batter_id varchar(6) NOT NULL,
    event varchar(30),
    g_id varchar(9) not null,
    inning int not null,
    o int not null,
    p_score int not null,
    p_throws varchar(1) not null,
    pitcher_id varchar(6) not null,
    stand varchar(1) not null,
    top boolean not null,
    primary key (ab_id)
);
load data local infile './atbats.csv'
into table atbats
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

create table ejections(
    date  date NOT NULL,
    BS varchar(1),
    des varchar(300),
    event_num int,
    CORRECT varchar(1),
    team carchar(3),
    is_home_team boolean,
    primary key (match_id)
);
load data local infile './ejections.csv'
into table ejections
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;


create table games(
    
);
load data local infile './games.csv'
into table participant
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

create table pitches(
    match_id int NOT NULL,
    team char(1) NOT NULL,
    champion_id int NOT NULL,
    banturn tinyint NOT NULL,
    primary key (match_id, banturn)
);

load data local infile './pitches.csv'
into table teamban
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

create table player_names(
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
    legendarykills tinyint,
    goldearned mediumint,
    firstblood boolean,
    primary key(player_id)
);
load data local infile './player_names.csv'
into table stat
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;


