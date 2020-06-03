/*球隊case 2*/
/*查詢某球隊每一年的首局得分率, 首局總得分數*/
/*以nya為模板*/
select score.year, count(*) as total_game, count(if(score.p_score > 0, score.p_score, null))/count(*) as scoring_rate, sum(score.p_score) as total_score
from(
	select G.home_team,A.p_score, A.g_id, home.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		)as home,
		atbats as A
	where home.g_id = A.g_id
		and A.inning = 2
		and A.top like "TRUE%"
	group by A.p_score, A.g_id
	union
	select G.away_team,A.p_score, A.g_id, away.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		)as away,
		atbats as A
	where away.g_id = A.g_id
		and A.inning = 1
		and A.top like "FALSE%"
	group by A.p_score, A.g_id) as score
group by score.year;
