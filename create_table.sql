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
lines terminated by '\n'
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
lines terminated by '\n'
ignore 1 lines;


create table games(
    
);
load data local infile './games.csv'
into table participant
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table pitches(
    px float,
    pz float,
    start_speed float,
    end_speed float,
    spin_rate float,
    spin_dir float,
    ax float,
    ay float,
    az float,
    sz_bot float,
    sz_top float,
    type_confidence float,
    vx0 float,
    vy0 float,
    vz0 float,
    x float,
    x0 float,
    y float,
    y0 float,
    z0 float,
    pfx_x float,
    pfx_z float,
    nasty tinyint,
    zone tinyint,
    code varchar(2),
    type varchar(2),
    pitch_type varchar(2),
    event_num int,
    b_score tinyint,
    ab_id varchar(10) NOt NULL,
    b_count tinyint,
    s_count tinyint,
    outs tinyint,
    pitch_num tinyint NOT NULL,
    on_1b boolean,
    on_2b boolean,
    on_3b boolean,
    primary key (ab_id, pitch_num)
);

load data local infile './pitches.csv'
into table pitches
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table player_names(
    id varchar(6) NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    primary key(id)
);

load data local infile './player_names.csv'
into table player_names
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


