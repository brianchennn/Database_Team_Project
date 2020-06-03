SELECT 
    player_names.first_name,
    player_names.last_name,
    walk,
    hits,
    total_innings,
    (walk + hits)/total_innings as WHIP
    
FROM
    player_names,
    (SELECT 
		a.pitcher_id, count(a.event) as walk
    FROM
        atbats AS a
    WHERE
        a.event = 'Walk'
	group by a.pitcher_id
	) AS Walk,
    
    (SELECT 
        a.pitcher_id, count(a.event) as hits
    FROM
        atbats AS a
    WHERE
        a.event = "Single" or a.event = "Double" or a.event = "Triple"
	group by a.pitcher_id
	) AS H,
    
    (SELECT 
        atbats2.pitcher_id,
		COUNT(*) AS total_innings
	FROM
		(SELECT 
			a.g_id, a.ab_id, a.pitcher_id
		FROM
			atbats AS a
		WHERE
			o = 3
		) AS atbats2,
		games
	WHERE
		atbats2.g_id = games.g_id
	GROUP BY pitcher_id
    ) as inning
    
WHERE
    player_names.id = H.pitcher_id
        AND player_names.id = Walk.pitcher_id
        AND player_names.id = inning.pitcher_id;