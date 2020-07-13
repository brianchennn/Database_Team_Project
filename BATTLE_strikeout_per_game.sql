drop table if exists BATTLE_strikeout_per_game;
CREATE TABLE BATTLE_strikeout_per_game(
SELECT S.years ,S.id,S.batter_id,g_id,sum(strikeout) as "K"
FROM
    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id,A.batter_id, A.g_id, if(event="Strikeout",1,0) as strikeout
    FROM atbats as A, player_names as PL
    WHERE  A.pitcher_id=PL.id
    ) as S
group by years,id,batter_id,g_id
order by years, S.id
);
ALTER TABLE BATTLE_strikeout_per_game
ADD PRIMARY KEY(g_id,id,batter_id);