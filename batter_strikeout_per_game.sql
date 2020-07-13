drop table if exists batter_strikeout_per_game;
CREATE TABLE batter_strikeout_per_game(
SELECT S.years ,S.id, S.first_name,S.last_name,g_id,sum(strikeout) as K
FROM
    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(event="Strikeout",1,0) as strikeout
    FROM atbats as A, player_names as PL
    WHERE  A.batter_id=PL.id
    ) as S
group by years,id,g_id
order by years, S.id
);

ALTER table batter_strikeout_per_game add primary key(g_id,id);