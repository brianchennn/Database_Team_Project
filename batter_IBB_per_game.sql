drop table if exists batter_IBB_per_game;
CREATE TABLE batter_IBB_per_game(
SELECT S.years ,S.id, S.first_name,S.last_name,g_id,sum(strikeout) as IBB
FROM
    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(event="Intent Walk",1,0) as strikeout
    FROM atbats as A, player_names as PL
    WHERE  A.batter_id=PL.id
    ) as S
group by years,id,g_id
order by years, S.id
);

ALTER table batter_IBB_per_game add primary key(g_id,id);