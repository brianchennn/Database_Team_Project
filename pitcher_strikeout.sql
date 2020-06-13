SELECT 
    SUBSTRING(Strikeout.ab_id, 1, 4) AS years,
    player_names.id,
    player_names.first_name,
    player_names.last_name,
    pitcher_total_inning.total_inning,
    COUNT(*) AS total_strikeout,
    count(*)/(total_inning*9) as K9
FROM
    (SELECT 
        a.ab_id, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Strikeout'
	) AS Strikeout,
    player_names,
    pitcher_total_inning
WHERE
    player_names.id = Strikeout.pitcher_id and Strikeout.pitcher_id = pitcher_total_inning.id
GROUP BY Strikeout.ab_id , player_names.id, player_names.first_name , player_names.last_name, pitcher_total_inning.total_inning;