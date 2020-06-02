
/*球隊case 2*/
/*查詢某球隊每一年的首局得分率, 首局總得分數*/
/*以nya為模板*/
select score.year, count(*) as total_game, count(if(score.p_score > 0, score.p_score, null))/count(*) as scoring_rate, sum(score.p_score) as total_score
from(
	select A.p_score, A.g_id, home.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		where G.home_team like "nya%")as home,
		atbats as A
	where home.g_id = A.g_id
		and A.inning = 2
		and A.top like "TRUE%"
	group by A.p_score, A.g_id
	union
	select A.p_score, A.g_id, away.year
	from(
		select G.g_id, substring_index(G.date, "-", 1) as year
		from games as G
		where G.away_team like "nya%")as away,
		atbats as A
	where away.g_id = A.g_id
		and A.inning = 1
		and A.top like "FALSE%"
	group by A.p_score, A.g_id) as score
group by score.year;

/*球隊case 3*/
/*查詢某球隊每場比賽的對手, 主隊或客隊, 比分*/
/*以nya為模板*/
select list.g_id, list.home_or_away, list.opponent, list.score, list.opponent_score
from (
	select ("home") as home_or_away, G.away_team as opponent, G.home_final_score as score, G.away_final_score as opponent_score, G.g_id as g_id
	from games as G
	where G.home_team like "nya%"
	union
	select ("away") as home_or_away, G.home_team as opponent, G.away_final_score as score, G.home_final_score as opponent_score, G.g_id as g_id
	from games as G
	where G.away_team like "nya%") as list
order by list.g_id;

/*球隊case4*/
/*所有年度, 所有聯盟分區的戰績*/
select list.year, list.team,
	(case list.team when "bal" then "AL" when "bos" then "AL" when "nya" then "AL" when "tba" then "AL" when "tor" then "AL"
		when "cha" then "AL" when "cle" then "AL" when "det" then "AL" when "kca" then "AL" when "min" then "AL"
		when "hou" then "AL" when "ana" then "AL" when "oak" then "AL" when "sea" then "AL" when "tex" then "AL" 
		when "atl" then "NL" when "mia" then "NL" when "nyn" then "NL" when "phi" then "NL" when "was" then "NL"
		when "chn" then "NL" when "cin" then "NL" when "mil" then "NL" when "pit" then "NL" when "sln" then "NL"
		when "ari" then "NL" when "col" then "NL" when "lan" then "NL" when "sdn" then "NL" when "sfn" then "NL" END) as League,
	(case list.team when "bal" then "East" when "bos" then "East" when "nya" then "East" when "tba" then "East" when "tor" then "East"
		when "cha" then "Central" when "cle" then "Central" when "det" then "Central" when "kca" then "Central" when "min" then "Central"
		when "hou" then "west" when "ana" then "west" when "oak" then "west" when "sea" then "west" when "tex" then "west" 
		when "atl" then "East" when "mia" then "East" when "nyn" then "East" when "phi" then "East" when "was" then "East"
		when "chn" then "Central" when "cin" then "Central" when "mil" then "Central" when "pit" then "Central" when "sln" then "Central"
		when "ari" then "west" when "col" then "west" when "lan" then "west" when "sdn" then "west" when "sfn" then "west" END) as Division,
	sum(list.win_lose) as win, count(list.win_lose) as total, sum(list.win_lose)/count(list.win_lose) as win_rate
from (
	select G.home_team as team, if(G.home_final_score > G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G
	union
	select G.away_team as team, if(G.home_final_score < G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G) as list
group by list.year, list.team
order by list.year, League, field(Division, "East", "Central", "West"), win_rate desc;

/*球隊case4*/
/*所有年度, 單一聯盟分區的戰績*/
/*以AL東區為模板*/
select list.year, list.team, "AL" as League, "East" as Division, sum(list.win_lose) as win, count(list.win_lose) as total, sum(list.win_lose)/count(list.win_lose) as win_rate
from (
	select G.home_team as team, if(G.home_final_score > G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G
	where G.home_team like "bal%"
		or G.home_team like "bos"
		or G.home_team like "nya"
		or G.home_team like "tba"
		or G.home_team like "tor"
	union
	select G.away_team as team, if(G.home_final_score < G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G
	where G.away_team like "bal%"
		or G.away_team like "bos"
		or G.away_team like "nya"
		or G.away_team like "tba"
		or G.away_team like "tor") as list
group by list.year, list.team
order by list.year, League, field(Division, "East", "Central", "West"), win_rate desc;

/*球隊case4*/
/*單一年度, 所有聯盟分區的戰績*/
/*以2015年為模板*/
select list.year, list.team,
	(case list.team when "bal" then "AL" when "bos" then "AL" when "nya" then "AL" when "tba" then "AL" when "tor" then "AL"
		when "cha" then "AL" when "cle" then "AL" when "det" then "AL" when "kca" then "AL" when "min" then "AL"
		when "hou" then "AL" when "ana" then "AL" when "oak" then "AL" when "sea" then "AL" when "tex" then "AL" 
		when "atl" then "NL" when "mia" then "NL" when "nyn" then "NL" when "phi" then "NL" when "was" then "NL"
		when "chn" then "NL" when "cin" then "NL" when "mil" then "NL" when "pit" then "NL" when "sln" then "NL"
		when "ari" then "NL" when "col" then "NL" when "lan" then "NL" when "sdn" then "NL" when "sfn" then "NL" END) as League,
	(case list.team when "bal" then "East" when "bos" then "East" when "nya" then "East" when "tba" then "East" when "tor" then "East"
		when "cha" then "Central" when "cle" then "Central" when "det" then "Central" when "kca" then "Central" when "min" then "Central"
		when "hou" then "west" when "ana" then "west" when "oak" then "west" when "sea" then "west" when "tex" then "west" 
		when "atl" then "East" when "mia" then "East" when "nyn" then "East" when "phi" then "East" when "was" then "East"
		when "chn" then "Central" when "cin" then "Central" when "mil" then "Central" when "pit" then "Central" when "sln" then "Central"
		when "ari" then "west" when "col" then "west" when "lan" then "west" when "sdn" then "west" when "sfn" then "west" END) as Division,
	sum(list.win_lose) as win, count(list.win_lose) as total, sum(list.win_lose)/count(list.win_lose) as win_rate
from (
	select G.home_team as team, if(G.home_final_score > G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G
	where substring_index(G.date, "-", 1) like "2015"
	union
	select G.away_team as team, if(G.home_final_score < G.away_final_score, 1, 0) as win_lose, substring_index(G.date, "-", 1) as year, G.g_id
	from games as G
	where substring_index(G.date, "-", 1) like "2015") as list
group by list.year, list.team
order by list.year, League, field(Division, "East", "Central", "West"), win_rate desc;

/*球隊case 5*/
/*每年度ejection次數最多的隊伍*/
select max_cnt.year, T.team, max_cnt.cnt
from (
	select T.year, max(T.cnt) as cnt
	from (
		select temp.team, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.team
			from ejections as E) as temp
		group by temp.team, temp.year) as T
	group by T.year) as max_cnt,(
	select temp.team, temp.year, count(*) as cnt
	from (
		select substring_index(E.date, "/", -1) as year, E.team
		from ejections as E) as temp
	group by temp.team, temp.year) as T
where max_cnt.year = T.year and max_cnt.cnt = T.cnt
order by year;

/*球隊case 5*/
/*每年度ejection次數最多的球員*/
select max_cnt.year, P.first_name, P.last_name, max_cnt.cnt
from (
	select T.year, max(T.cnt) as cnt
	from (
		select temp.player_id, temp.year, count(temp.player_id) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.player_id
			from ejections as E) as temp
		group by temp.player_id, temp.year) as T
	group by T.year) as max_cnt, (
	select temp.player_id, temp.year, count(temp.player_id) as cnt
	from (
		select substring_index(E.date, "/", -1) as year, E.player_id
		from ejections as E) as temp
	group by temp.player_id, temp.year) as year_player_cnt,
	player_names as P
where max_cnt.year = year_player_cnt.year and max_cnt.cnt = year_player_cnt.cnt and P.id = year_player_cnt.player_id
order by max_cnt.year;

/*球隊case 6*/
/*查詢某隊伍所有ejection*/
/*以nya為模板*/
select *
from ejections as E
where E.team like "nya%";

/*球隊case 6*/
/*查詢某球員的所有ejection*/
/*以 Bryce Harper 為模板*/
select E.*
from ejections as E, player_names as P
where P.first_name like "Bryce%"
	and P.last_name like "Harper%"
	and P.id = E.player_id;
