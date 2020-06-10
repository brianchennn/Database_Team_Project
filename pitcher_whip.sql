create table whip_years
(SELECT 
	H.years as years,
    player_names.first_name,
    player_names.last_name,
    walk,
    hits,
    total_innings,
    (walk + hits)/total_innings as WHIP
    
FROM
    player_names,
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as walk
    FROM
        atbats AS a
    WHERE
        a.event = "Walk"
	group by years, a.pitcher_id
	) AS Walk,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as hits
    FROM
        atbats AS a
    WHERE
        a.event = "Single" or a.event = "Double" or a.event = "Triple" or a.event="Home Run"
	group by years, a.pitcher_id
	) AS H,
    
    (SELECT 
		SUBSTRING(atbats2.ab_id, 1, 4) AS years,
        atbats2.pitcher_id,
		COUNT(*)/3 AS total_innings
	FROM
		(SELECT 
			a.g_id, a.ab_id, a.pitcher_id
		FROM
			atbats AS a
		WHERE
			o != 0 
		) AS atbats2,
		games
	WHERE
		atbats2.g_id = games.g_id
	GROUP BY years , pitcher_id
    ) as inning
    
WHERE
    player_names.id = H.pitcher_id
        AND player_names.id = Walk.pitcher_id and H.years = Walk.years
        AND player_names.id = inning.pitcher_id and inning.years = H.years
        and total_innings >= 50
order by years, WHIP
);