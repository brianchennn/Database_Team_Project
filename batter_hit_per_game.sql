/*batter每場的安打*/
drop table if exists batter_hit_per_game;
CREATE TABLE batter_hit_per_game(
SELECT S.years ,S.id, S.first_name,S.last_name,S.g_id, S.S as Single, D.D as DDouble, T.T as Triple, H.H as HR
FROM
    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as S
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event="Single",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.batter_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as S,
    

    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as D
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event="Double",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.batter_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as D,

    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as T
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event="Triple",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.batter_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as T,

    (SELECT SS.years, SS.id,SS.first_name,SS.last_name, SS.g_id, SS.single,sum(single) as H
    FROM    
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event="Home Run",1,0) as single
        FROM atbats as A, player_names as PL
        WHERE A.batter_id=PL.id
        ) as SS
    GROUP BY years,first_name, last_name, g_id) as H
WHERE S.id=D.id
    and T.id=D.id
    and T.id=H.id
    and S.g_id=D.g_id
    and T.g_id=D.g_id
    and H.g_id=T.g_id
    
order by years, first_name, last_name,g_id
);
ALTER TABLE batter_hit_per_game
ADD PRIMARY KEY(g_id,id);