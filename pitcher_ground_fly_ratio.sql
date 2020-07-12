drop table if exists pitcher_ground_fly_ratio;
CREATE TABLE pitcher_ground_fly_ratio(
SELECT S.years ,S.first_name,S.last_name,S.g_id, S.S as "Ground", D.D as "Fly", ROUND(S/D,3) as "Ground/Fly"
FROM
    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as S
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event like "%Ground%",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.pitcher_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as S,
    

    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as D
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event like "%Fly%",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.pitcher_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as D

WHERE S.id=D.id
    and S.g_id=D.g_id
    
    
order by years, first_name, last_name, g_id
);