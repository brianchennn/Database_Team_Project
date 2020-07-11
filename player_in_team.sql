/*select substring(atbats.ab_id,1,4),player_names.first_name,player_names.last_name,games.home_team,games.g_id
from atbats,games,player_names 
where (
    (player_names.id = atbats.batter_id and atbats.top = "False") or (player_names.id = atbats.pitcher_id and atbats.top = "True") ) 
    and games.g_id = atbats.g_id 
    and player_names.first_name like "Aroldis"
group by player_names.first_name,player_names.last_name,games.home_team
order by substring(atbats.ab_id,1,4) , player_names.first_name,player_names.last_name asc



select substring(atbats.ab_id,1,4),player_names.first_name,player_names.last_name,games.away_team,games.g_id
from atbats,games,player_names 
where ((player_names.id = atbats.batter_id and atbats.top = "True") or (player_names.id = atbats.pitcher_id and atbats.top = "False") ) and games.g_id = atbats.g_id and player_names.first_name like "Aroldis"
group by player_names.first_name,player_names.last_name,games.home_team
order by substring(atbats.ab_id,1,4) , player_names.first_name,player_names.last_name asc*/