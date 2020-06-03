SELECT 
    player_names.first_name,
    player_names.last_name,
    hits,
    home_run,
    atbat_or_other,
    (hits + home_run)/atbat_or_other as AVG
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
        a.pitcher_id, count(a.event) as atbat_or_other
    FROM
        atbats AS a
    WHERE
            a.event != "Walk" 
            and a.event!="Sac Fly" 
            and a.event!="Sac Bunt" 
            and a.event != "Hit By Pitch" 
            and a.event!="Catcher Interference" 
            and a.event!="Intent Walk"
	group by a.pitcher_id
	) AS FO
    
    
WHERE
         player_names.id = H.pitcher_id
        AND player_names.id = HR.pitcher_id
        AND player_names.id = FO.pitcher_id
order by AVG asc;
