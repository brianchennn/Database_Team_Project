SELECT 
    SUBSTRING(Walk.ab_id, 1, 4) AS years,
    player_names.first_name,
    player_names.last_name,
    COUNT(*) AS total_walk
FROM
    (SELECT 
        a.ab_id, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Walk'
	) AS Walk,
    player_names
WHERE
    player_names.id = Walk.pitcher_id
GROUP BY years , player_names.first_name , player_names.last_name;