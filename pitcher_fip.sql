SELECT 
	K.years as years,
    K.first_name,
    K.last_name,
    HR.home_run,
    BB.walk,
    HBP.hit_by_pitch,
    K.strikeout,
    IP.inning,
    ((13*home_run)+(3*(walk+hit_by_pitch))-(2*strikeout))/inning+3.2 as FIP
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, P.first_name,P.last_name, count(a.event) as home_run
    FROM
        atbats AS a,
        player_names as P
    WHERE
        a.event = "Home Run" and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS HR,

    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, P.first_name,P.last_name, count(a.event) as walk
    FROM
        atbats AS a,
        player_names as P
    WHERE
        (a.event = "Walk" or a.event = "Intent Walk" )and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS BB,

    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, P.first_name,P.last_name, count(a.event) as hit_by_pitch
    FROM
        atbats AS a,
        player_names as P
    WHERE
        a.event = "Hit By Pitch" and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS HBP,
    
    (
        SELECT 
            SUBSTRING(a.ab_id, 1, 4) AS years, P.first_name,P.last_name, count(a.event) as strikeout
        FROM
            atbats AS a,
            player_names as P
        WHERE
            a.event = "Strikeout" and 
            P.id = a.pitcher_id
        group by years, P.first_name,P.last_name
	) AS K,
    (
        SELECT 
            SUBSTRING(atbats2.ab_id, 1, 4) AS years,
            player_names.first_name,
            player_names.last_name,
            count(o)/3 AS inning
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
    )as IP
WHERE
    
    HR.first_name = BB.first_name
    and BB.first_name = K.first_name
    and K.first_name = IP.first_name
    and IP.first_name = HBP.first_name
    and HR.last_name = BB.last_name
    and BB.last_name = K.last_name
    and K.last_name = IP.last_name
    and IP.last_name = HBP.last_name
    and HR.years = BB.years
    and BB.years = K.years
    and K.years = IP.years
    and IP.years = HBP.years
order by years,FIP