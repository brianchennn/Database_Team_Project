CREATE TABLE atbats(
    ab_id CHAR(12) NOT NULL, 
    batter_id CHAR(8) NOT NULL,
    event VARCHAR(20) NOT NULL, 
    g_id CHAR(11) NOT NULL,
    inning TINYINT NOT NULL,
    o TINYINT NOT NULL,
    p_score TINYINT NOT NULL,
    p_throws VARCHAR(1) NOT NULL,
    pitcher_id CHAR(8) NOT NULL,
    stand CHAR(1) NOT NULL,
    top CHAR(7) NOT NULL,
    PRIMARY KEY (ab_id)
);

LOAD DATA LOCAL INFILE './atbats.csv'
INTO TABLE atbats
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE ejections(
    ab_id CHAR(12) NOT NULL,
    des VARCHAR(100) NOT NULL,
    event_num INT NOT NULL,
    g_id CHAR(11) NOT NULL,
    player_id CHAR(8) NOT NULL,
    date CHAR(10) NOT NULL,
    BS CHAR(3),
    CORRECT CHAR(4) DEFAULT NULL,
    team CHAR(5) NOT NULL,
    is_home_team CHAR(7) NOT NULL,
    PRIMARY KEY (des),
    /*FOREIGN KEY (ab_id) REFERENCES atbats,
    FOREIGN KEY (g_id) REFERENCES games,
    FOREIGN KEY (player_id) REFERENCES player_names*/
);

LOAD DATA LOCAL INFILE './ejections.csv'
INTO TABLE ejections
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


CREATE TABLE games (
    attendance INT,
    away_final_score TINYINT,
    away_team CHAR(5),
    date DATE,
    elapsed_time SMALLINT,
    g_id CHAR(11),
    home_final_score TINYINT,
    home_team CHAR(5),
    start_time VARCHAR(10),
    umpire_1B VARCHAR(40),
    umpire_2B VARCHAR(40),
    umpire_3B VARCHAR(40),
    umpire_HP VARCHAR(40),
    venue_name VARCHAR(40),
    weather VARCHAR(40),
    wind VARCHAR(40),
    delay SMALLINT,
    PRIMARY KEY (g_id)
);
LOAD DATA LOCAL INFILE './games.csv'
INTO TABLE games
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE pitches(
    px FLOAT,
    pz FLOAT,
    start_speed FLOAT,
    end_speed FLOAT,
    spin_rate FLOAT,
    spin_dir FLOAT,
    break_angle FLOAT,
    break_length FLOAT,
    break_y FLOAT,
    ax FLOAT,
    ay FLOAT,
    az FLOAT,
    sz_bot FLOAT,
    sz_top FLOAT,
    type_confidence FLOAT,
    vx0 FLOAT,
    vy0 FLOAT,
    vz0 FLOAT,
    x FLOAT,
    x0 FLOAT,
    y FLOAT,
    y0 FLOAT,
    z0 FLOAT,
    pfx_x FLOAT,
    pfx_z FLOAT,
    nasty tinyINT,
    zone tinyINT,
    code VARCHAR(2) ,
    type VARCHAR(2),
    pitch_type VARCHAR(2),
    event_num INT,
    b_score tinyINT,
    ab_id VARCHAR(10) NOT NULL,
    b_count tinyINT,
    s_count tinyINT,
    outs tinyINT,
    pitch_num tinyINT NOT NULL,
    on_1b FLOAT,
    on_2b FLOAT,
    on_3b FLOAT ,
    primary key (ab_id, pitch_num)
);

LOAD DATA LOCAL INFILE './pitches.csv'
INTO TABLE pitches
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE player_names(
    id VARCHAR(6) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    primary key(id)
);

LOAD DATA LOCAL INFILE './player_names.csv'
INTO TABLE player_names
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


