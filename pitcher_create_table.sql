SELECT PH.*,PS.K, PW.BB
FROM pitcher_hit as PH, pitcher_strikeout as PS, pitcher_walk as PW, pitcher_ground_fly_ratio as PGFR
WHERE   
    PS.g_id=PW.g_id
    and PW.g_id=PH.g_id
    and PH.g_id=PGFR.g_id
    and PS.first_name=PH.first_name
    and PH.first_name=PW.first_name
    and PW.first_name=PGFR.first_name
    and PS.last_name=PH.last_name
    and PH.last_name=PW.last_name
    and PW.last_name=PGFR.last_name


