select T2.first_name,T2.last_name , sum(T2.S1), sum(T3.S1)
from
(select T1.first_name,T1.last_name, T1.event,sum(T1.cnt) as S1
from(select first_name,last_name,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id
group by atbats.batter_id,event) as T1
where T1.event = "Single" or T1.event = "Double" or T1.event = "Triple" or T1.event = "Home Run" group by T1.first_name,T1.last_name,T1.event) as T2,
(select T1.first_name,T1.last_name, T1.event,sum(T1.cnt) as S1
from(select first_name,last_name,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id
group by atbats.batter_id,event) as T1
where T1.event != "Walk" and T1.event != "Sac Fly" and T1.event != "Sac Bunt" and T1.event != "Hit By Pitch" group by T1.first_name,T1.last_name,T1.event) as T3
where T2.first_name = T3.first_name and T2.last_name = T3.last_name and T2.event = T3.event
group by T2.first_name,T2.last_name 
-- order by sum(T2.S1)/sum(T3.S1)