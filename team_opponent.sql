/*球隊case 3*/
/*查詢某球隊每場比賽的對手, 主隊或客隊, 比分*/
/*以nya為模板*/
drop table if exists team_opponent;
create table opponent(
select list.g_id, list.home_or_away, list.opponent, list.score, list.opponent_score
from (
	select ("home") as home_or_away, G.away_team as opponent, G.home_final_score as score, G.away_final_score as opponent_score, G.g_id as g_id
	from games as G
	where G.home_team like "nya%"
	union
	select ("away") as home_or_away, G.home_team as opponent, G.away_final_score as score, G.home_final_score as opponent_score, G.g_id as g_id
	from games as G
	where G.away_team like "nya%") as list
order by list.g_id);

