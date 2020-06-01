SELECT 
    player_names.first_name,
    player_names.last_name,
    COUNT(*) AS total_innings
FROM
    player_names,
    (SELECT 
        a.g_id, a.ab_id, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        o = 3
	) AS atbats2,
    games
WHERE
    player_names.id = atbats2.pitcher_id
        AND atbats2.g_id = games.g_id
GROUP BY player_names.first_name , player_names.last_name;