/*球隊case 2*/
/*列出所有球隊每一年的首局得分率, 首局總得分數*/
drop table if exists team_first_inning_run_ratio;
CREATE TABLE team_first_inning_run_ratio (select score.year, score.team, count(*) as total_game, count(if(score.p_score > 0, score.p_score, null))/count(*) as scoring_rate, sum(score.p_score) as total_score
from(
	select A.p_score, A.g_id, home.team, home.year
	from(
		select G.g_id, G.home_team as team, substring_index(G.date, "-", 1) as year
		from games as G)as home,
		atbats as A
	where home.g_id = A.g_id
		and A.inning = 2
		and A.top like "TRUE%"
	group by A.p_score, A.g_id, home.team
	union
	select A.p_score, A.g_id, away.team, away.year
	from(
		select G.g_id, G.away_team as team, substring_index(G.date, "-", 1) as year
		from games as G)as away,
		atbats as A
	where away.g_id = A.g_id
		and A.inning = 1
		and A.top like "FALSE%"
	group by A.p_score, A.g_id, away.team) as score
group by score.year, score.team
);
alter table team_first_inning_run_ratio add primary key(year,team);

