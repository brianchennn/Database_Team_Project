drop table if exists batter_walk_per_game;
CREATE TABLE batter_walk_per_game(
SELECT S.years, S.id, S.first_name,S.last_name,S.g_id,S.walk as "BB", HBP.hbp as "HBP"
FROM
    (SELECT SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id, sum(SS.walk) as walk
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event like "%Walk",1,0) as walk
        FROM atbats as A, player_names as PL
        WHERE  A.batter_id=PL.id
        ) as SS
    GROUP BY SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id) as S,
    (SELECT HBPHBP.years, HBPHBP.id, HBPHBP.first_name, HBPHBP.last_name, HBPHBP.g_id, sum(HBPHBP.hbp) as hbp
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event = "Hit By Pitch",1,0) as hbp
        FROM atbats as A, player_names as PL
        WHERE  A.batter_id=PL.id
        ) as HBPHBP
    GROUP BY HBPHBP.years, HBPHBP.id, HBPHBP.first_name, HBPHBP.last_name, HBPHBP.g_id) as HBP
where S.id=HBP.id and S.years=HBP.years and S.g_id=HBP.g_id
order by years, S.id
);
ALTER TABLE batter_walk_per_game
ADD PRIMARY KEY(g_id,id);