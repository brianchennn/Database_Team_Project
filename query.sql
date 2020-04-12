select  count(distinct C.champion_name) cnt from champ C;

select count(ver)
from (select distinct substring_index(version,'.',2) as ver from match_info ) as tmp;



select C.champion_name as c_n,count(P.match_id) as cnt
from champ as C, participant as P
where C.champion_id = P.champion_id 
group by P.champion_id 
order by cnt desc
limit 3;

