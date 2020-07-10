create table batter_strikeout(
select Year,T1.id,first_name,last_name,sum(T1.cnt_baserun) as strikeout,sum(T1.cnt_atbat) as atbat,sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as strikeout_rate
from(
    select substring(ab_id,1,4) as Year,id,first_name,last_name,event,
            if(event="Strikeout",count(*),0) as cnt_baserun, 
            count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" 
            and event!="Sac Fly" and event!="Sac Bunt" 
            and event != "Hit By Pitch" 
            and event!="Catcher Interference" 
            and event!="Intent Walk")
    group by substring(ab_id,1,4) ,first_name,last_name,event ) as T1 
group by Year,id,first_name,last_name
having sum(T1.cnt_atbat)>=100
order by  Year asc,strikeout_rate desc);
