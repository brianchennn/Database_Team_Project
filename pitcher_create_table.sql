drop table if exists pitcher_create_table;
create table pitcher_create_table(
SELECT 
       PH.*,
       pitch_num_per_game.IP,
       pitch_num_per_game.Pitch_per_Game,
       PS.K,
       PW.BB,
       PW.HBP,
       PDP.DP,
       PGFR.Ground,PGFR.Fly,
       PGFR.Ground_per_Fly as "G/F"
FROM pitcher_hit as PH, pitcher_strikeout as PS, pitcher_walk as PW, pitcher_ground_fly_ratio as PGFR,
    pitch_num_per_game,pitcher_DP as PDP
WHERE   
    PS.g_id=PW.g_id
    and PW.g_id=PH.g_id
    and PH.g_id=PGFR.g_id
    and PGFR.g_id=pitch_num_per_game.g_id
    and pitch_num_per_game.g_id=PDP.g_id
    and PS.id=PH.id
    and PH.id=PW.id
    and PW.id=PGFR.id
    and PGFR.id=pitch_num_per_game.id
    and pitch_num_per_game.id=PDP.id
);
