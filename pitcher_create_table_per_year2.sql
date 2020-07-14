drop table if exists pitcher_create_table_per_year2;
create table pitcher_create_table_per_year2(
SELECT 
       PH.*,
       pitch_num_per_game.IP,
       pitch_num_per_game.Pitch_per_Game,
       PS.K,
       PW.BB,
       PW.HBP,
       PDP.DP,
       PGFR.Ground,PGFR.Fly,
       PGFR.ground_fly_ratio as ground_fly_ratio
FROM pitcher_hit_per_year as PH, pitcher_strikeout_per_year as PS, 
    pitcher_walk_per_year as PW, 
    pitcher_ground_fly_ratio_per_year as PGFR,
    pitch_num_per_game,pitcher_DP as PDP,
    pitcher_fip as PFIP, 
    pitcher_babip as PB,
    pitcher_whip as PWHIP
WHERE   
    PS.years=PW.years
    and PW.years=PH.years
    and PH.years=PGFR.years
    and PGFR.years=pitch_num_per_game.years
    and pitch_num_per_game.years=PDP.years
    and PDP.years=PFIP.years
    and PFIP.years=PB.years
    and PB.years=PWHIP.years
    and PS.id=PH.id
    and PH.id=PW.id
    and PW.id=PGFR.id
    and PGFR.id=pitch_num_per_game.id
    and pitch_num_per_game.id=PDP.id
    and PDP.id=PFIP.id
    and PFIP.id=PB.id
    and PB.id=PWHIP.id

);
alter table pitcher_create_table_per_year2 add primary key(years,id);