/*球隊case 7*/
/*單場比賽驅逐出場次數大於等於三的比賽資訊*/
/*column name ： date, g_id, home_team, away_team, ejection_cnt*/

drop table if exists ejection_game ;
create table ejection_game(
select G.date, E.g_id, G.home_team, G.away_team, count(*) as ejection_cnt
from ejections as E, games as G
where E.g_id = G.g_id
group by E.g_id
having count(*) >= 3);
