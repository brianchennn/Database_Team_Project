/* "***" 的地方替換成要搜尋的球員或球隊 */

/*球隊case 2*/
select score.year, count(*) as total_game, count(if(score.p_score > 0, score.p_score, null))/count(*) as scoring_rate, sum(score.p_score) as total_score
from(
	select A.p_score, A.g_id, home.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		where G.home_team like "bos")as home, atbats as A
	where home.g_id = A.g_id
		and A.inning = 2
		and A.top like "TRUE%"
	group by A.p_score, A.g_id
	union
	select A.p_score, A.g_id, away.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		where G.away_team like "bos")as away, atbats as A
	where away.g_id = A.g_id
		and A.inning = 1
		and A.top like "FALSE%"
	group by A.p_score, A.g_id) as score
group by score.year;

/*球隊case 3*/
select ("home") as home_or_away, G.away_team as opponent, G.home_final_score as score, G.away_final_score as opponent_score
from games as G
where G.home_team like "nya"
union
select ("away") as home_or_away, G.home_team as opponent, G.away_final_score as score, G.home_final_score as opponent_score
from games as G
where G.away_team like "nya";

/*球隊case 5 球隊*/
select max_cnt.year, T.team, max_cnt.cnt
from (
	select T.year, max(T.cnt) as cnt
	from (
		select temp.team, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.team from ejections as E) as temp
			group by temp.team, temp.year) as T
		group by T.year
		) as max_cnt,(
		select temp.team, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.team from ejections as E) as temp
		group by temp.team, temp.year) as T
where max_cnt.year = T.year and max_cnt.cnt = T.cnt;

/*球隊case 5 球員*/
select max_cnt.year, P.first_name, P.last_name, max_cnt.cnt
from (
	select T.year, max(T.cnt) as cnt
	from (
		select temp.player_id, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.player_id from ejections as E) as temp
			group by temp.player_id, temp.year) as T
		group by T.year) as max_cnt,(
	select temp.player_id, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.player_id from ejections as E) as temp
		group by temp.player_id, temp.year) as T,
		player_names as P
where max_cnt.year = T.year and max_cnt.cnt = T.cnt and P.id = T.player_id;

/*球隊case 6 球隊*/
select *
from ejections as E
where E.team like "nya"

/*球隊case 6 球員*/
select E.*
from ejections as E, player_names as P
where P.first_name like "***%"
	and P.last_name like "***%"
	and P.id = E.player_id