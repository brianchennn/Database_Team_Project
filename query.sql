/* question 1*/
select  count(distinct C.champion_name) cnt from champ C;

/*question 2*/
select count(ver) as cnt
from (select distinct substring_index(version,'.',2) as ver from match_info ) as tmp;

/*question 3*/
select C.champion_name as c_n,count(P.match_id) as cnt
from champ as C, (select PP.match_id,PP.champion_id from participant as PP where PP.position="JUNGLE") as P
where C.champion_id = P.champion_id
group by P.champion_id 
order by cnt desc
limit 3;

/*question 4*/
select M.match_id ,sec_to_time(M.duration) as time
from match_info as M 
order by time desc
limit 5;

/*question 5 */
select if(new_t.win=0,'lose','win') as win_lose, count(new_t.match_id) as cnt
from(
    select P.match_id, S.win, AVG(S.longesttimespentliving)
    from participant P,stat S
    where P.player_id = S.player_id
    group by P.match_id,S.win
    having 1200 <= AVG(S.longesttimespentliving) 
    order by P.match_id desc
) as new_t
group by new_t.win 
/*question 6 排序出錯*/

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
select new2_t.position, C.champion_name, new2_t.kda
from(
    select new_t.position,new_t.champion_id ,new_t.kda
    from(
        select P.position,P.champion_id,(sum(S.kills)+sum(S.assists))/sum(S.deaths) as kda
        from participant as P, stat as S
        where P.player_id = S.player_id
        group by P.champion_id
        order by kda desc
    )as new_t
    where new_t.position != 'DUO'
    group by new_t.position
)as new2_t, champ as C
where C.champion_id = new2_t.champion_id
order by new2_t.position asc


/*question 8*/
select C.champion_name
from champ as C
where C.champion_name not in(
        select distinct C.champion_name
        from (
            select T.champion_id
            from (select M.match_id,M.version from match_info as M where M.version like '7.7.%')    as MM, teamban as T
            where MM.match_id  = T.match_id
        )as new_t, champ as C
        where new_t.champion_id = C.champion_id)
order by C.champion_name asc;
/*question 9*//*Teemo:17, Lee_Sin:64*/

select substring_index(M.version,'.',2)as version,sum(new_t.win) as win_cnt,count(win)-sum(win) as lose_int, sum(new_t.win)/count(win)
from(
        select PP.player_id,PP.player,PP.match_id, PP.Team,S.win    
        from(
            select P.player_id,P.match_id,P.champion_id,P.player, if(P.player>=6,'R','B') as Team
            from participant as P 
            where P.champion_id=17 or P.champion_id=64

        ) as PP,stat as S
        where PP.player_id = S.player_id
        group by PP.match_id,PP.Team 
        HAVING  sum(PP.champion_id)=81
    )as new_t ,match_info as M
where M.match_id = new_t.match_id  
group by substring_index(M.version,'.',2)
    

/*question 10 Renekton:58*/
select PP.match_id,PP.champion_id
from(
    select P.match_id,P.champion_id
    from participant as P 
    where  P.position = 'TOP' and P.champion_id=58
    )as t1,participant as PP
where PP.match_id = t1.match_id and PP.position='TOP' 


 

