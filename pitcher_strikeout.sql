/*drop table if exists pitcher_strikeout;
create table pitcher_strikeout(
SELECT 
    Strikeout.years,
    player_names.first_name,
    player_names.last_name,
    Strikeout.g_id,
    pitcher_inning.IP,
    COUNT(*) AS total_strikeout,
    count(*)/IP*9 as K9
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) as years, a.g_id,a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Strikeout'
	) AS Strikeout,
    player_names,
    pitcher_inning
WHERE
    Strikeout.years = pitcher_inning.years and player_names.id = Strikeout.pitcher_id and Strikeout.pitcher_id = pitcher_inning.id
GROUP BY Strikeout.years, player_names.first_name , player_names.last_name,Strikeout.g_id, pitcher_inning.IP
order by player_names.first_name , player_names.last_name,Strikeout.g_id asc
);
*/
drop table if exists pitcher_strikeout;
CREATE TABLE pitcher_strikeout(
SELECT S.years ,S.id, S.first_name,S.last_name,g_id,sum(strikeout) as K
FROM
    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(event like "Strikeout%",1,0) as strikeout
    FROM atbats as A, player_names as PL
    WHERE  A.pitcher_id=PL.id
    ) as S
group by years,id,g_id
order by years, S.id
);
ALTER TABLE pitcher_strikeout
ADD PRIMARY KEY(g_id,id);