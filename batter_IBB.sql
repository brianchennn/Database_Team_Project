create table batter_I(
select Year,id,first_name,last_name,sum(T1.cnt_baserun) as BB,sum(T1.cnt_atbat) as PA,sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as BB_rate
from(
    select substring(ab_id,1,4) as Year,id,first_name,last_name,event,
            if(event="Intent Walk",count(*),0) as cnt_baserun, 
            count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        
        
    group by substring(ab_id,1,4) ,first_name,last_name,event ) as T1 
group by Year,first_name,last_name
having sum(T1.cnt_atbat)>=100
order by  Year asc,BB_rate desc);
