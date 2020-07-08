create table pitcher_walk(
SELECT 
    Walk.years,
    player_names.first_name,
    player_names.last_name,
    pitcher_inning.total_inning,
    COUNT(*) AS total_walk,
    count(*)/(total_inning*9) as BB9
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) as years, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Walk' or a.event = 'Intent Walk' or a.event = 'Hit By Pitch'
	) AS Walk,
    player_names,
    pitcher_inning
WHERE
    Walk.years = pitcher_inning.years and player_names.id = Walk.pitcher_id and Walk.pitcher_id = pitcher_inning.id
GROUP BY Walk.years, player_names.first_name , player_names.last_name, pitcher_inning.total_inning
);