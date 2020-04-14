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
select if(new_t.win=0,'lose','win') as win_lose, count(new_t.match_id) as cnt
from(
    select P.match_id, S.win, AVG(S.longesttimespentliving)
    from participant P,stat S
    where P.player_id = S.player_id
    group by P.match_id
    having 20 <= AVG(S.longesttimespentliving) 
) as new_t
group by new_t.win 
/*question 6*/

select  new_t.cnt,new_t.position,new_t.champion_id,C.champion_name
from (
    select count(Du.match_id) as cnt,P.position,P.champion_id
    from (
            select M.match_id
            from match_info as M
            where M.duration between 2400 and 3000
         )  as Du,participant as P
    where Du.match_id=P.match_id
    group by  P.champion_id
    order by cnt desc
) as new_t ,champ as C
where C.champion_id = new_t.champion_id
group by new_t.position

/*question 7*/
select new_t.position, C.champion_name, new_t.kda
from(
    select P.position,P.champion_id,(sum(S.kills)+sum(S.assists))/sum(S.deaths) as kda
    from participant as P, stat as S
    where P.player_id = S.player_id
    group by P.champion_id
    order by kda
)as new_t,champ as C
group by new_t.position