select player_names.first_name,player_names.last_name,atbats.p_score
from atbats, games,player_names
where player_names.id = atbats.batter_id


select distinct atbats.ab_id,games.away_team,games.home_team
from atbats, games,player_names
where atbats.g_id = games.g_id limit 1000;