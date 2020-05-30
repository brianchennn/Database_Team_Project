select TT1.first_name,TT1.last_name,sum(TT1.SS1)/sum(TT2.SS1) as avg
from
(select T2.first_name,T2.last_name,sum(S1) as SS1
from (select T1.first_name,T1.last_name, T1.event,sum(T1.cnt) as S1
from(select atbats.ab_id ,first_name,last_name,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id and atbats.ab_id like "2015%" 
group by atbats.batter_id,event) as T1
where T1.event = "Single" or T1.event = "Double" or T1.event = "Triple" or T1.event = "Home Run" group by T1.first_name,T1.last_name,T1.event) as T2
group by T2.first_name,T2.last_name) as TT1,

(select T3.first_name,T3.last_name,sum(S1) as SS1
from(select T1.first_name,T1.last_name, T1.event,sum(T1.cnt) as S1
from(select first_name,last_name,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id and atbats.ab_id like "2015%"
group by atbats.batter_id,event) as T1
where T1.event != "Walk" and T1.event != "Sac Fly" and T1.event != "Sac Bunt" and T1.event != "Hit By Pitch" group by T1.first_name,T1.last_name,T1.event) as T3
group by T3.first_name,T3.last_name) as TT2
where TT1.first_name =TT2.first_name and TT1.last_name=TT2.last_name and TT2.SS1>50
group by TT1.first_name,TT1.last_name
order by avg desc