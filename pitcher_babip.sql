drop table if exists pitcher_babip;
create table pitcher_babip(
SELECT 
	  GO.years as years,
    player_names.id,
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
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as hits
    FROM
        atbats AS a
    WHERE
        a.event = "Single" or a.event = "Double" or a.event = "Triple" or a.event = "Home Run"
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
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as flyout
    FROM
        atbats AS a
    WHERE
        a.event = "Flyout"
	group by years, a.pitcher_id
	) AS FO,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.pitcher_id, count(a.event) as groundout
    FROM
        atbats AS a
    WHERE
        a.event = "Groundout"
	group by years, a.pitcher_id
	) AS GO
WHERE
    player_names.id = H.pitcher_id
        AND player_names.id = GO.pitcher_id and H.years = GO.years
        AND player_names.id = HR.pitcher_id and HR.years = H.years
        AND player_names.id = FO.pitcher_id and FO.years = H.years
        and flyout + groundout + hits - home_run >= 50
order by years asc, BABIP asc
);