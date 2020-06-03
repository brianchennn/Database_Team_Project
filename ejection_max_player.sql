/*球隊case 5*/
/*每年度ejection次數最多的球員*/
select max_cnt.year, P.first_name, P.last_name, max_cnt.cnt
from (
	select E_cnt.year, max(E_cnt.cnt) as cnt
	from (
		select temp.player_id, temp.year, count(temp.player_id) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.player_id
			from ejections as E) as temp
		group by temp.player_id, temp.year) as E_cnt,
		player_names as P
	where E_cnt.player_id = P.id
	group by E_cnt.year) as max_cnt,
	(
	select temp.player_id, temp.year, count(temp.player_id) as cnt
	from (
		select substring_index(E.date, "/", -1) as year, E.player_id
		from ejections as E) as temp
	group by temp.player_id, temp.year) as E_cnt,
	player_names as P
where max_cnt.year = E_cnt.year and max_cnt.cnt = E_cnt.cnt and P.id = E_cnt.player_id
order by max_cnt.year;
	
