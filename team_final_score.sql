/*球隊case8*/
/*所有對戰的比分*/
/*column name ： g_id, year, home_team, away_team, home_final_score, away_final_score*/

drop table if exists team_final_score ;
create table team_final_score(
select G.g_id,G.date , substring(G.g_id,1,4) as year, G.home_team, G.away_team, G.home_final_score, G.away_final_score
from games as G
);

