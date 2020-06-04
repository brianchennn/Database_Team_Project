create table pitcher_total_inning_years(
SELECT 
    SUBSTRING(atbats2.ab_id, 1, 4) AS years,
    player_names.first_name,
    player_names.last_name,
    count(o)/3 AS total_innings
FROM
    player_names,
    (SELECT 
        a.g_id, a.ab_id, a.pitcher_id, a.o
    FROM
        atbats AS a
	where o != 0
	) AS atbats2,
    games
WHERE
    player_names.id = atbats2.pitcher_id
        AND atbats2.g_id = games.g_id
GROUP BY years , player_names.first_name , player_names.last_name
order by total_innings asc
);