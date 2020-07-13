drop table if exists pitcher_create_table_per_year;
create table pitcher_create_table_per_year(
select  PCT.years,
        PCT.id,
        PCT.first_name,
        PCT.last_name,
        sum(PFIP.IP) as IP,
        sum(Pitch_per_Game) as pitch_num,
        sum(Single) as Single,
        sum(DDouble) as DDouble,
        sum(Triple) as Triple,
        sum(HR) as HR,
        sum(K) as K,
        sum(BB) as BB,
        sum(HBP) as HBP,
        sum(DP) as Ground_into_DP,
        sum(ground_fly_ratio) as ground_fly_ratio,
        PFIP.FIP,
        PB.BABIP,
        PW.WHIP
from pitcher_create_table as PCT, 
     pitcher_fip as PFIP, 
     pitcher_babip as PB,
     pitcher_whip as PW
where   PCT.years=PFIP.years
    and PFIP.years=PB.years
    and PB.years=PW.years
    and PCT.id=PFIP.id
    and PFIP.id=PB.id
    and PB.id=PW.id
group by PCT.years, PCT.id);