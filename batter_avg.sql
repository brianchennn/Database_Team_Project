/*select T2.id,T2.id , sum(T2.S1), sum(T3.S1)
from
(select T1.id,T1.id, T1.event,sum(T1.cnt) as S1
from(select id,id,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id
group by atbats.batter_id,event) as T1
where T1.event = "Single" or T1.event = "Double" or T1.event = "Triple" or T1.event = "Home Run" group by T1.id,T1.id,T1.event) as T2,
(select T1.id,T1.id, T1.event,sum(T1.cnt) as S1
from(select id,id,event,count(*) as cnt from player_names,atbats where player_names.id = atbats.batter_id
group by atbats.batter_id,event) as T1
where T1.event != "Walk" and T1.event != "Sac Fly" and T1.event != "Sac Bunt" and T1.event != "Hit By Pitch" group by T1.id,T1.id,T1.event) as T3
where T2.id = T3.id and T2.id = T3.id and T2.event = T3.event
group by T2.id,T2.id 
-- order by sum(T2.S1)/sum(T3.S1)
*/
drop table if exists batter_avg
CREATE TABLE batter_avg (select Year,T1.id,first_name,last_name,sum(T1.cnt_baserun) as hit,sum(T1.cnt_atbat) as atbat,sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as AVG

from(
    select substring(ab_id,1,4) as Year,first_name,last_name,id,event,
            if(event="Single",count(*),
            if(event="Double",count(*),
            if(event="Triple",count(*),
            if(event="Home Run",count(*),0)))) as cnt_baserun, 
            count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" 
            and event!="Sac Fly" and event!="Sac Bunt" 
            and event != "Hit By Pitch" 
            and event!="Catcher Interference" 
            and event!="Intent Walk")
    group by substring(ab_id,1,4) ,id,id,event ) as T1 
group by Year,id,id
having sum(T1.cnt_atbat)>=50
order by  Year asc,AVG desc);

ALTER TABLE batter_avg ADD PRIMARY KEY(year,id);