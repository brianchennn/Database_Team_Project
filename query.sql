/* question 1*/
select  count(distinct C.champion_name) cnt from champ C;

/*question 2*/
select count(ver) as cnt
from (select distinct substring_index(version,'.',2) as ver from match_info ) as tmp;

/*question 3*/
select C.champion_name as c_n,count(P.match_id) as cnt
from champ as C, participant as P
where C.champion_id = P.champion_id 
group by P.champion_id 
order by cnt desc
limit 3;

/*question 4*/
select M.match_id ,sec_to_time(M.duration) as CN
from match_info as M 
order by CN desc
limit 5;

SELECT CONVERT(int, 25.65);