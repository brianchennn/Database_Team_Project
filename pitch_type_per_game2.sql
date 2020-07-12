drop table if exists pitch_type_per_game2;
create table pitch_type_per_game2(
select distinct PTPG.*,  
        if(A.top="True",G.away_team,concat(away_team,("*"))) as away_team, 
        if(A.top="True",concat(home_team,("*")),G.home_team) as home_team
from pitch_type_per_game as PTPG, games as G,atbats as A
where G.g_id=PTPG.g_id and A.g_id=G.g_id and A.pitcher_id=PTPG.id
order by PTPG.years,PTPG.id
);
