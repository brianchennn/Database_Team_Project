create table pitcher_total_pitch_number
(SELECT 
    SUBSTRING(PC.ab_id, 1, 4) AS years,
    player_names.id,
    player_names.first_name,
    player_names.last_name,
    COUNT(*) AS total_PC
FROM
    (SELECT 
        atbats2.ab_id, atbats2.pitcher_id
    FROM
        (SELECT 
        a.g_id, a.ab_id, a.pitcher_id
		FROM
			atbats AS a
		) AS atbats2,
        (SELECT 
			p.ab_id
		FROM
			pitches AS p
		) AS pitches2
		WHERE
			atbats2.ab_id = pitches2.ab_id
	) AS PC,
    player_names
WHERE
    player_names.id = PC.pitcher_id
GROUP BY years , player_names.id ,player_names.first_name , player_names.last_name
);