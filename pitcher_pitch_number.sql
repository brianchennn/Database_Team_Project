/*每年投手投球總數*/
drop table if exists pitcher_pitch_number;
create table pitcher_pitch_number(
    SELECT PNPG.years, PNPG.first_name,PNPG.last_name, sum(Pitch_per_Game) as pitch_num
    FROM pitch_num_per_game as PNPG
    GROUP BY PNPG.years, PNPG.first_name,PNPG.last_name
    order by years, pitch_num desc
);

/*
create table pitcher_pitch_number
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
);*/