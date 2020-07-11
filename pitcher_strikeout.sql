drop table if exists pitcher_strikeout;
create table pitcher_strikeout(
SELECT 
    Strikeout.years,
    player_names.first_name,
    player_names.last_name,
    pitcher_inning.total_inning,
    COUNT(*) AS total_strikeout,
    count(*)/(total_inning*9) as K9
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) as years, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Strikeout'
	) AS Strikeout,
    player_names,
    pitcher_inning
WHERE
    Strikeout.years = pitcher_inning.years and player_names.id = Strikeout.pitcher_id and Strikeout.pitcher_id = pitcher_inning.id
GROUP BY Strikeout.years, player_names.first_name , player_names.last_name, pitcher_inning.total_inning
);