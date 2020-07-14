drop table if exists pitcher_IBB_per_game;
CREATE TABLE pitcher_IBB_per_game(
SELECT S.years, S.id, S.first_name,S.last_name,S.g_id,S.IBB as IBB
FROM
    (SELECT SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id, sum(SS.walk) as IBB
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event = "Intent Walk",1,0) as walk
        FROM atbats as A, player_names as PL
        WHERE  A.pitcher_id=PL.id
        ) as SS
    GROUP BY SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id) as S
    
);
ALTER TABLE pitcher_IBB_per_game
ADD PRIMARY KEY(g_id,id);