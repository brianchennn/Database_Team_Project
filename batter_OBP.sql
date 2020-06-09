/*select T1.Year,T1.id,T1.id,sum(T2.cnt),count(T1.cnt),sum(T2.cnt)/sum(T1.cnt) as OPS
from(
    select substring(ab_id,1,4) as Year,id,id,event,count(*) as cnt
    from player_names,atbats 
    where player_names.id = atbats.batter_id and event!="Catcher Interference" and event!="Batter Interference" and id like "%Xa%"
    group by Year ,id,id,event) as T1,
    (
    select substring(ab_id,1,4) as Year,id,id,event,count(*) as cnt
    from player_names,atbats 
    where player_names.id = atbats.batter_id and id like "%Xa%" and (event="Single" or event="Double" or event="Triple" or event="Home Run" or event="Walk" or event="Hit By Pitch") 
    group by Year ,id,id,event) as T2
where T1.year=T2.year and T1.id=T2.id and T1.id=T2.id
group by T1.Year,T1.id,T1.id



select T1.Year,T1.id,T1.id,sum(T1.isbase)
from(
    select substring(ab_id,1,4) as Year,id,id,event,if(event="Single",1,if(event="Double",count(*),if(event="Triple",count(*),if(event="Home Run",count(*),if(event like "%Walk",count(*),if(event="Hit By Pitch",count(*),0)))))) as is_onbase
    from player_names,atbats 
    where player_names.id = atbats.batter_id and event!="Catcher Interference" and event!="Batter Interference" and id like "%Xa%"
    group by Year ,id,id,event) as T1
group by T1.Year,T1.id,T1.id
*/


create table batter_OBP(select Year,T1.id,first_name,last_name,sum(cnt_onbase),sum(cnt_atbat),sum(cnt_onbase)/sum(cnt_atbat) as OBP


from(
    select substring(ab_id,1,4)as Year,id,id,id,event,if(event="Single",count(*),if(event="Double",count(*),if(event="Triple",count(*),if(event="Home Run",count(*),if(event = "Walk",count(*),if(event="Hit By Pitch",1,if(event="Catcher Interference",count(*),if(event="Intent Walk",count(*),0)))))))) as cnt_onbase, count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
    and event!="Catcher Interference"
    group by substring(ab_id,1,4) ,id,id,event) as T1 
group by Year,id,id
having sum(cnt_atbat) >= 50
order by  Year asc,OBP desc);
