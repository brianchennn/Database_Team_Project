CREATE TABLE ejections(
    years CHAR(4) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name INT NOT NULL,
    max_start_speed float NOT NULL,
    max_start_speed float NOT NULL,
    PRIMARY KEY (des)                                      
    /*FOREIGN KEY (ab_id) REFERENCES atbats (ab_id),          
    //FOREIGN KEY (g_id) REFERENCES games (g_id),            
    //FOREIGN KEY (player_id) REFERENCES player_names (id)    */
);                                                         
LOAD DATA LOCAL INFILE './ejections.csv'
INTO TABLE ejections
FIELDS TERMINATED by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;