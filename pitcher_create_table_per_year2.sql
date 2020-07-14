drop table if exists temp1;
create table temp1(
SELECT 
       PH.*,
       /*pitch_num_per_game.IP,
       pitch_num_per_game.Pitch_per_Game,*/
       PS.K,
       PW.BB,
       PW.HBP,
       /*PDP.DP,*/
       PGFR.Ground,PGFR.Fly,
       PGFR.ground_fly_ratio as ground_fly_ratio
FROM pitcher_hit_per_year as PH, 
    pitcher_strikeout_per_year as PS, 
    pitcher_walk_per_year as PW, 
    pitcher_ground_fly_ratio_per_year as PGFR
    /*pitch_num_per_game,
    pitcher_DP as PDP,
    pitcher_fip as PFIP, 
    pitcher_babip as PB,
    pitcher_whip as PWHIP*/
WHERE   
    PS.years=PW.years
    and PW.years=PH.years
    and PH.years=PGFR.years
    /*and PGFR.years=pitch_num_per_game.years*/
    /*and pitch_num_per_game.years=PDP.years
    and PDP.years=PFIP.years
    and PFIP.years=PB.years
    and PB.years=PWHIP.years*/
    and PS.id=PH.id
    and PH.id=PW.id
    and PW.id=PGFR.id
    /*and PGFR.id=pitch_num_per_game.id
    and pitch_num_per_game.id=PDP.id
    and PDP.id=PFIP.id
    and PFIP.id=PB.id
    and PB.id=PWHIP.id*/

);
alter table temp1 add primary key(years,id);

drop table if exists temp2;
create table temp2(
SELECT 
       /*PH.*,*/
       PNPY.years,
       PNPY.id,
       PNPY.IP,
       PNPY.pitch_per_year,
       /*PS.K,
       PW.BB,
       PW.HBP,*/
       PDP.DP
       /*PGFR.Ground,PGFR.Fly,
       PGFR.ground_fly_ratio as ground_fly_ratio*/
FROM /*pitcher_hit_per_year as PH, 
    pitcher_strikeout_per_year as PS, 
    pitcher_walk_per_year as PW, 
    pitcher_ground_fly_ratio_per_year as PGFR*/
    pitch_num_per_year as  PNPY,
    pitcher_DP_per_year as PDP/*,
    pitcher_fip as PFIP, 
    pitcher_babip as PB,
    pitcher_whip as PWHIP*/
WHERE   
    /*PS.years=PW.years
    and PW.years=PH.years
    and PH.years=PGFR.years
    and PGFR.years=pitch_num_per_game.years*/
    PNPY.years=PDP.years
    /*and PDP.years=PFIP.years
    and PFIP.years=PB.years
    and PB.years=PWHIP.years*/
    /*and PS.id=PH.id
    and PH.id=PW.id
    and PW.id=PGFR.id
    and PGFR.id=pitch_num_per_game.id*/
    and PNPY.id=PDP.id
    /*and PDP.id=PFIP.id
    and PFIP.id=PB.id
    and PB.id=PWHIP.id*/

);
alter table temp2 add primary key(years,id);

drop table if exists temp3;
create table temp3(
SELECT 
       /*PH.*,*/
       PFIP.years,
       PFIP.id,
       /*PNPY.IP,
       PNPY.Pitch_per_Game,*/
       /*PS.K,
       PW.BB,
       PW.HBP,*/
       /*PDP.DP*/
       /*PGFR.Ground,PGFR.Fly,
       PGFR.ground_fly_ratio as ground_fly_ratio*/
       PFIP.FIP,
       PB.BABIP, 
       PWHIP.WHIP

FROM /*pitcher_hit_per_year as PH, 
    pitcher_strikeout_per_year as PS, 
    pitcher_walk_per_year as PW, 
    pitcher_ground_fly_ratio_per_year as PGFR*/
    /*pitch_num_per_year as  PNPY,
    pitcher_DP_per_year as PDP,*/
    pitcher_fip as PFIP, 
    pitcher_babip as PB,
    pitcher_whip as PWHIP
WHERE   
    /*PS.years=PW.years
    and PW.years=PH.years
    and PH.years=PGFR.years
    and PGFR.years=pitch_num_per_game.years*/
    /*PNPY.years=PDP.years*/
    
     PFIP.years=PB.years
    and PB.years=PWHIP.years
    /*and PS.id=PH.id
    and PH.id=PW.id
    and PW.id=PGFR.id
    and PGFR.id=pitch_num_per_game.id*/
    /*and PNPY.id=PDP.id*/
    /*and PDP.id=PFIP.id*/
    and PFIP.id=PB.id
    and PB.id=PWHIP.id

);
alter table temp3 add primary key(years,id);


drop table if exists pitcher_create_table_per_year2; 
create table pitcher_create_table_per_year2(
select temp1.years,
       temp1.id,
       temp1.first_name,
       temp1.last_name,
       pitch_per_year,
       IP,
       Single,
       DDouble,
       Triple,
       HR,
       round((Single+DDouble+Triple+HR)/IP*9,2) as H9,
       K,
       round(K/IP*9,2) as K9,
       BB,
       round(BB/IP*9,2) as BB9,
       IBB,
       HBP,
       DP,
       Ground,
       Fly,
       ground_fly_ratio,
       FIP,
       BABIP,
       WHIP


from temp1,temp2,temp3,pitcher_IBB_per_year as PIPY
where temp1.id  = temp2.id
    and temp2.id = temp3.id
    and temp3.id = PIPY.id
    and  temp1.years = temp2.years
    and temp2.years = temp3.years
    and temp3.years = PIPY.years
);
alter table pitcher_create_table_per_year2 add primary key(years,id);

drop table temp1;
drop table temp2;
drop table temp3;
