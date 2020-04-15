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
group by new_t.win;
/*question 6 */
select T1.position,C.champion_name
from(
    select t1.position,max(t1.cnt) as max_cnt
    from(select P.position,P.champion_id,count(*) cnt
        from participant as P, match_info as M
        where M.duration between 2400 and 3000 and P.match_id=M.match_id
        group by P.champion_id desc 
        order by cnt
    )as t1
    group by t1.position
)as T1,
(
    select P.position,P.champion_id,count(*) cnt
    from participant as P, match_info as M
    where M.duration between 2400 and 3000 and P.match_id=M.match_id
    group by P.champion_id desc 
    order by cnt
)as T2,
champ as C
where T1.position=T2.position and T1.max_cnt=T2.cnt and C.champion_id=T2.champion_id and T1.position != "DUO"
order by T1.position;
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
order by new2_t.position asc;


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
/*question 9     Teemo:17, Lee_Sin:64*/

select substring_index(M.version,'.',2)as version,sum(new_t.win) as win_cnt,count(win)-sum(win) as lose_cnt, sum(new_t.win)/count(win) as win_ratio
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
group by substring_index(M.version,'.',2);
    

/*question 10 Renekton:58*/
select T.self_name as self_champ_name, sum(T.self_win)/count(T.self_win) as win_ratio, 
(sum(T.self_kills)+sum(T.self_assists))/sum(T.self_deaths) as self_kda, avg(T.self_goldearned) as self_avg_gold,T.enemy_name as enemy_champ_name, 
(sum(T.enemy_kills)+sum(T.enemy_assists))/sum(T.enemy_deaths) as enemy_kda, avg(T.enemy_goldearned) as enemy_avg_gold, count(*) as battle_record

from (
select t1.match_id ,t1.champion_name as self_name,t1.win as self_win, t1.kills as self_kills,t1.assists as self_assists,
 t1.deaths as self_deaths, t1.goldearned as self_goldearned ,t2.champion_name as enemy_name,t2.kills as enemy_kills,t2.assists as enemy_assists,
 t2.deaths as enemy_deaths,t2.goldearned as enemy_goldearned
from(
    select PP.player_id,PP.match_id,PP.champion_id,C.champion_name,S.win,S.kills,S.assists,S.deaths,S.goldearned
    from(
        select P.match_id,P.champion_id
        from participant as P 
        where  P.position = 'TOP' and P.champion_id=58
    )as t1,participant as PP, champ as C,stat as S
    where PP.match_id = t1.match_id and PP.position='TOP' and PP.champion_id= C.champion_id and S.player_id=PP.player_id and PP.champion_id != 58
) as t1,
(
    select PP.player_id,PP.match_id,PP.champion_id,C.champion_name,S.win,S.kills,S.assists,S.deaths,S.goldearned
    from(
        select P.match_id,P.champion_id
        from participant as P 
        where  P.position = 'TOP' and P.champion_id=58
    )as t1,participant as PP, champ as C,stat as S
    where PP.match_id = t1.match_id and PP.position='TOP' and PP.champion_id= C.champion_id and S.player_id=PP.player_id and PP.champion_id = 58
) as t2
where t1.match_id = t2.match_id
) as T
group by T.self_name
having count(*) > 100
order by win_ratio DESC
limit 5;

/*question 11*/


select  sum(S.win)/count(S.win) as win_rate
from stat as S,participant as P
where S.player_id=P.player_id and P.ss1='Flash' and P.ss2='Ignite'and P.position='TOP';
select  sum(S.win)/count(S.win) as win_rate
from stat as S,participant as P
where S.player_id=P.player_id and P.ss1='Flash' and P.ss2='Teleport' and P.position='TOP';