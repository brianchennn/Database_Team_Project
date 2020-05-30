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

select T_single.year_single as Year,T_single.first_name,T_single.last_name,(sum(T_single.cnt_single)+sum(T_double.cnt_double)+sum(T_triple.cnt_triple)+sum(T_homerun.cnt_homerun))/sum(T_atbat.cnt_atbat) as SLG
from
(select substring(ab_id,1,4)as year_single,first_name,last_name,event,count(*) as cnt_single
from player_names,atbats 
where player_names.id = atbats.batter_id and (event = "Single")
group by substring(ab_id,1,4) ,first_name,last_name,event) as T_Single,
(select substring(ab_id,1,4) as year_double,first_name,last_name,event,2*count(*) as cnt_double
from player_names,atbats 
where player_names.id = atbats.batter_id and (event = "Double")
group by substring(ab_id,1,4),first_name,last_name,event) as T_double,
(select substring(ab_id,1,4) as year_triple,first_name,last_name,event,3*count(*) as cnt_triple
from player_names,atbats 
where player_names.id = atbats.batter_id and (event = "Triple")
group by substring(ab_id,1,4),first_name,last_name,event) as T_triple,
(select substring(ab_id,1,4) as year_homerun,first_name,last_name,event,4*count(*) as cnt_homerun
from player_names,atbats 
where player_names.id = atbats.batter_id and (event = "Home Run")
group by substring(ab_id,1,4),first_name,last_name,event) as T_homerun,
(select substring(ab_id,1,4) as year_atbat,first_name,last_name,count(*) as cnt_atbat
from player_names,atbats 
where player_names.id = atbats.batter_id and event != "Walk" and event != "Sac Fly" and event != "Sac Bunt" and event != "Hit By Pitch"
group by substring(ab_id,1,4),first_name,last_name) as T_atbat
where T_single.first_name = T_double.first_name and T_triple.first_name = T_double.first_name and T_triple.first_name = T_homerun.first_name 
        and T_single.last_name = T_double.last_name and T_triple.last_name = T_double.last_name and T_triple.last_name = T_homerun.last_name
        and T_single.year_single = T_double.year_double and T_triple.year_triple = T_double.year_double and T_triple.year_triple = T_homerun.year_homerun
group by T_single.year_single,T_single.first_name,T_single.last_name
*/

select Year,first_name,last_name,sum(cnt_baserun)/sum(cnt_atbat) as SLG
from(
    select substring(ab_id,1,4)as Year,first_name,last_name,event,if(event="Single",count(*),if(event="double",2*count(*),if(event="triple",3*count(*),if(event="Home Run",4*count(*),0)))) as cnt_baserun, count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" and event != "Sac Fly" and event != "Sac Bunt" and event != "Hit By Pitch")
    group by substring(ab_id,1,4) ,first_name,last_name,event) as T1
where cnt_atbat >= 50  
group by Year,first_name,last_name
order by  Year asc,SLG desc