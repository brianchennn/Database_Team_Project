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

/*question 5 用到stat的win,longesttimespentliving*/
select new_t.win as win_lose , count(new_t.match_id) as cnt
from 
(   
    select P.match_id ,P.player_id, S.win, AVG(S.longesttimespentliving)
    from participant as P, stat as S
    where P.player_id = S.player_id
    group by P.match_id
    having AVG(S.longesttimespentliving) >= 20
) as new_t
group by new_t.win
limit 10;

/*question 6*/
select new_t.position, max(new.cnt)
from (select P.position, P.champion_id,count(Du.match_id) as cnt
    from (select M.duration ,M.match_id
           from match_info as M
           where M.duration>=2400 and M.duration<=3000) as Du, participant as P
    where Du.match_id = P.match_id
    group by P.champion_id
    limit 100;) as new_t
group by new_t.position
