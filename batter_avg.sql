/*select T2.first_name,T2.last_name , sum(T2.S1), sum(T3.S1)
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
*/
select Year,first_name,last_name,sum(T1.cnt_baserun),sum(T1.cnt_atbat),sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as SLG
from(
    select substring(ab_id,1,4) as Year,first_name,last_name,event,if(event="Single",count(*),if(event="Double",count(*),if(event="Triple",count(*),if(event="Home Run",count(*),0)))) as cnt_baserun, count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" and event!="Sac Fly" and event!="Sac Bunt" and event != "Hit By Pitch" and event!="Catcher Interference" and event="Intent Walk")
    group by substring(ab_id,1,4) ,first_name,last_name,event ) as T1 
group by Year,first_name,last_name
having sum(T1.cnt_atbat)>=50
order by  Year asc,SLG desc
