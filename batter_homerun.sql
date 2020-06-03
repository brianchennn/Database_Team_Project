select substring(atbats.ab_id,1,4) as Year,first_name,last_name,event,count(*) as cnt 
from player_names,atbats 
where player_names.id = atbats.batter_id and atbats.event="Home Run" 
group by Year,first_name,last_name
order by Year asc,cnt desc, first_name desc,last_name desc