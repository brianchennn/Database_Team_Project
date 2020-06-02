SELECT 
    player_names.first_name,
    player_names.last_name,
    hits,
    home_run,
    flyout,
    groundout,
    (hits - home_run)/(flyout + groundout + hits - home_run) as BABIP
FROM
    player_names,
    (SELECT 
        a.pitcher_id, count(a.event) as hits
    FROM
        atbats AS a
    WHERE
        a.event = "Single" or a.event = "Double" or a.event = "Triple"
	group by a.pitcher_id
	) AS H,
    
    (SELECT 
        a.pitcher_id, count(a.event) as home_run
    FROM
        atbats AS a
    WHERE
        a.event = "Home Run"
	group by a.pitcher_id
	) AS HR,
    
    (SELECT 
        a.pitcher_id, count(a.event) as flyout
    FROM
        atbats AS a
    WHERE
        a.event = "Flyout"
	group by a.pitcher_id
	) AS FO,
    
    (SELECT 
        a.pitcher_id, count(a.event) as groundout
    FROM
        atbats AS a
    WHERE
        a.event = "Groundout"
	group by a.pitcher_id
	) AS GO
WHERE
    player_names.id = GO.pitcher_id
        AND player_names.id = H.pitcher_id
        AND player_names.id = HR.pitcher_id
        AND player_names.id = FO.pitcher_id;