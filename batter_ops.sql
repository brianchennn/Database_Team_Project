create table batter_ops(select TTT1.Year,TTT1.id,TTT1.first_name,TTT1.last_name,(OBP+SLG) as OPS
from(
select Year,T1.id,first_name,last_name,sum(cnt_onbase),sum(cnt_atbat),sum(cnt_onbase)/sum(cnt_atbat) as OBP
from(
    select substring(ab_id,1,4) as Year,
			id,
            first_name,last_name,
            event,
            if(event="Single",count(*),
             if(event="Double",count(*),
             if(event="Triple",count(*),
             if(event="Home Run",count(*),
             if(event = "Walk",count(*),
             if(event="Hit By Pitch",1,
             if(event="Catcher Interference",count(*),
             if(event="Intent Walk",count(*),0)))))))) as cnt_onbase, 
            count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
    and event!="Catcher Interference"
    group by substring(ab_id,1,4) ,
             player_names.id ,
             first_name,
             last_name,event) as T1 
group by Year,T1.id,first_name, last_name
having sum(cnt_atbat) >= 50) as TTT1,
(
select Year,
       first_name,
       last_name,
       sum(T1.cnt_baserun),
       sum(T1.cnt_atbat),
       sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as SLG
from(
    select substring(ab_id,1,4) as Year,
           first_name,
           last_name,
           event,
           if(event="Single",count(*),
            if(event="Double",2*count(*),
            if(event="Triple",3*count(*),
            if(event="Home Run",4*count(*),0)))) as cnt_baserun, count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" 
        and event!="Sac Fly" 
        and event!="Sac Bunt" 
        and event != "Hit By Pitch" 
        and event!="Catcher Interference" 
        and event!="Batter Interference" 
        and event!="Intent Walk")
    group by substring(ab_id,1,4) ,
             first_name,
             last_name,event ) as T1 
group by Year,first_name,last_name
having sum(T1.cnt_atbat)>=50 ) as TTT2
where TTT1.Year=TTT2.Year
      and TTT1.first_name=TTT2.first_name 
      and TTT1.last_name=TTT2.last_name
group by TTT1.Year, TTT1.first_name, TTT1.last_name
order by TTT1.Year,OPS desc);
