SELECT 
    player_names.first_name,
    player_names.last_name,
    COUNT(*) AS total_strikeout
FROM
    (SELECT 
        a.ab_id, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Strikeout'
	) AS Strikeout,
    player_names
WHERE
    player_names.id = Strikeout.pitcher_id
GROUP BY player_names.first_name , player_names.last_name;