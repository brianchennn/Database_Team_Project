/*球隊case 5*/
/*每年度ejection次數最多的隊伍*/
select max_cnt.year, E_cnt.team, max_cnt.cnt
from (
	select E_cnt.year, max(E_cnt.cnt) as cnt
	from (
		select temp.team, temp.year, count(*) as cnt
		from (
			select substring_index(E.date, "/", -1) as year, E.team
			from ejections as E) as temp
		group by temp.team, temp.year) as E_cnt
	group by E_cnt.year) as max_cnt,
	(
	select temp.team, temp.year, count(*) as cnt
	from (
		select substring_index(E.date, "/", -1) as year, E.team
		from ejections as E) as temp
	group by temp.team, temp.year) as E_cnt
where max_cnt.year = E_cnt.year and max_cnt.cnt = E_cnt.cnt
order by E_cnt.year;
	
