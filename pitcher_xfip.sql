drop table if exists pitcher_xfip;
create table pitcher_xfip(
select A.years,B.id,PL.first_name,PL.last_name,
    ROUND( ((13*(Fly * HR_F))+(3*(BB+HBP))-(2*K))/IP + fip_const , 3) as xFIP 
from pitcher_league_HR_FB_rate as A, pitcher_create_table_per_year as B, pitcher_fip_constant as C, player_names as PL, 
     pitcher_ground_fly_ratio_per_year as D
where  B.years=C.years and 
        A.years = B.years and
        B.years = D.years and
        B.id = PL.id AND
        D.id = PL.id
);

        