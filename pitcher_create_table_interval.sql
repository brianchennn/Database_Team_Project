select      first_name,last_name,     
sum(Single) as Single,     
sum(DDouble) as DDouble,     
sum(Triple) as Triple,     
sum(HR) as HR,     
sum(IP) as IP,     
sum(Pitch_per_Game) as pitch_num,     
sum(K) as K,     
sum(BB) as BB,     
sum(HBP) as HBP,     
sum(DP) as DP,     
sum(Ground)/sum(Fly) as ground_fly_ratio,     
(sum(HR)*13 + 3*(sum(BB)+sum(HBP) - 2*sum(K))/sum(IP)) + 3.2 as FIP,     
(sum(Single)+sum(DDouble)+sum(Triple))/(sum(Fly) + sum(Ground) + sum(Single)+sum(DDouble)+sum(Triple) ) as BABIP,     
(sum(Single)+sum(DDouble)+sum(Triple)+sum(HR)+sum(BB))/Sum(IP) as WHIP from pitcher_create_table_per_game as A, 
pitcher_fip_constant 
where first_name="Masahiro" and last_name="Tanaka"      
    and A.Date between 20150405 and 20150415 group by id;