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

/*question 5 尚未解出來*/
select S.win 
from participant as P, stat as S
group by P.match_id
having 20 <= AVG(select longesttimespentliving from S where S.player_id == P.player_id)
limit 5;

/*question 6*/
select new_t.champion_id,new_t2.maxx
from(
    select new_t.position,max(cnt) as maxx
    from (
        select P.position,P.champion_id,count(Du.match_id) as cnt
        from (select M.match_id
            from match_info as M
            where M.duration between 2400 and 3000) as Du,participant as P
        where Du.match_id=P.match_id
        group by  P.champion_id
    ) as new_t
    group by new_t.position
) as new_t2
where new_t.

select *
from participant as P
limit 1;