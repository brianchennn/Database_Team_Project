create table pitcher_hit_avg
(SELECT 
	FO.years as years,
    player_names.id,
    player_names.first_name,
    player_names.last_name,
    hits,
    home_run,
    atbat_or_other,
    (hits + home_run)/atbat_or_other as AVG
FROM
    player_names,
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as hits
    FROM
        atbats AS a
    WHERE
        a.event = "Single" or a.event = "Double" or a.event = "Triple"
	group by years, a.pitcher_id
	) AS H,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as home_run
    FROM
        atbats AS a
    WHERE
        a.event = "Home Run"
	group by years, a.pitcher_id
	) AS HR,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as atbat_or_other
    FROM
        atbats AS a
    WHERE
        (a.event != "Walk" 
            and a.event!="Sac Fly" 
            and a.event!="Sac Bunt" 
            and a.event != "Hit By Pitch" 
            and a.event!="Catcher Interference" 
            and a.event!="Intent Walk")
	group by years, a.pitcher_id
	) AS FO
WHERE
    player_names.id = H.pitcher_id
        AND player_names.id = HR.pitcher_id and HR.years = H.years
        AND player_names.id = FO.pitcher_id and FO.years = H.years
        and atbat_or_other >= 50
order by FO.years, AVG asc
);