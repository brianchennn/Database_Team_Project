/*球隊case4*/
/*所有年度, 所有聯盟分區的戰績*/
CREATE TABLE region_status select list.year, list.team,
	(case list.team when "bal" then "AL" when "bos" then "AL" when "nya" then "AL" when "tba" then "AL" when "tor" then "AL"
		when "cha" then "AL" when "cle" then "AL" when "det" then "AL" when "kca" then "AL" when "min" then "AL"
		when "hou" then "AL" when "ana" then "AL" when "oak" then "AL" when "sea" then "AL" when "tex" then "AL" 
		when "atl" then "NL" when "mia" then "NL" when "nyn" then "NL" when "phi" then "NL" when "was" then "NL"
		when "chn" then "NL" when "cin" then "NL" when "mil" then "NL" when "pit" then "NL" when "sln" then "NL"
		when "ari" then "NL" when "col" then "NL" when "lan" then "NL" when "sdn" then "NL" when "sfn" then "NL" END) as League,
	(case list.team when "bal" then "East" when "bos" then "East" when "nya" then "East" when "tba" then "East" when "tor" then "East"
		when "cha" then "Central" when "cle" then "Central" when "det" then "Central" when "kca" then "Central" when "min" then "Central"
		when "hou" then "West" when "ana" then "West" when "oak" then "West" when "sea" then "West" when "tex" then "West" 
		when "atl" then "East" when "mia" then "East" when "nyn" then "East" when "phi" then "East" when "was" then "East"
		when "chn" then "Central" when "cin" then "Central" when "mil" then "Central" when "pit" then "Central" when "sln" then "Central"
		when "ari" then "West" when "col" then "West" when "lan" then "West" when "sdn" then "West" when "sfn" then "West" END) as Division,
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
/*
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
*/

/*球隊case4*/
/*單一年度, 所有聯盟分區的戰績*/
/*以2015年為模板*/
/*
select list.year, list.team,
	(case list.team when "bal" then "AL" when "bos" then "AL" when "nya" then "AL" when "tba" then "AL" when "tor" then "AL"
		when "cha" then "AL" when "cle" then "AL" when "det" then "AL" when "kca" then "AL" when "min" then "AL"
		when "hou" then "AL" when "ana" then "AL" when "oak" then "AL" when "sea" then "AL" when "tex" then "AL" 
		when "atl" then "NL" when "mia" then "NL" when "nyn" then "NL" when "phi" then "NL" when "was" then "NL"
		when "chn" then "NL" when "cin" then "NL" when "mil" then "NL" when "pit" then "NL" when "sln" then "NL"
		when "ari" then "NL" when "col" then "NL" when "lan" then "NL" when "sdn" then "NL" when "sfn" then "NL" END) as League,
	(case list.team when "bal" then "East" when "bos" then "East" when "nya" then "East" when "tba" then "East" when "tor" then "East"
		when "cha" then "Central" when "cle" then "Central" when "det" then "Central" when "kca" then "Central" when "min" then "Central"
		when "hou" then "West" when "ana" then "West" when "oak" then "West" when "sea" then "West" when "tex" then "West" 
		when "atl" then "East" when "mia" then "East" when "nyn" then "East" when "phi" then "East" when "was" then "East"
		when "chn" then "Central" when "cin" then "Central" when "mil" then "Central" when "pit" then "Central" when "sln" then "Central"
		when "ari" then "West" when "col" then "West" when "lan" then "West" when "sdn" then "West" when "sfn" then "West" END) as Division,
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
*/
	
