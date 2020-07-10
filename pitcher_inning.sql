create table pitcher_inning
(
SELECT 
    SUBSTRING(atbats2.ab_id, 1, 4) AS years,
    player_names.id,
    player_names.first_name,
    player_names.last_name,
    sum(Num_out)/3 AS total_inning
FROM
    player_names,
    (SELECT 
        a.g_id, a.ab_id, a.pitcher_id,
        (case when a.event = 'Triple Play' then 3
			  when a.event = 'Double Play' or 
				   a.event = 'Ground Into DP' or 
				   a.event = 'Strikout - DP' or 
				   a.event like 'Sac Fly DP' or 
				   a.event = 'Sacrifice Bunt DP' then 2
              when a.event = 'Groundout' or
                   a.event = 'Strikeout' or
                   a.event = 'Runner Out' or
                   a.event = 'Flyout' or
                   a.event = 'Forceout' or
                   a.event = 'Pop Out' or
                   a.event = 'Lineout' or
                   a.event = 'Bunt Groundout' or
                   a.event = 'Bunt Pop Out' or
                   a.event = 'Sac Bunt' or
                   a.event = 'Sac Fly' or
                   a.event = 'Fielders Choice Out' or
                   a.event = 'Chatcher Interference' or
                   a.event = 'Bunt Lineout' then 1
			  else 0 end) as Num_out
    FROM
        atbats AS a
	where o != 0
	) AS atbats2
WHERE
    player_names.id = atbats2.pitcher_id
GROUP BY years , player_names.id, player_names.first_name , player_names.last_name
);