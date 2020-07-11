drop table if exists pitcher_inning; 
create table pitcher_inning(
SELECT years,
       g_id,
       pl.id, 
       pl.first_name, 
       pl.last_name, 
       ROUND(sum(out_diff)/3,3) as IP
FROM(
    SELECT SUBSTRING(a.ab_id, 1, 4) as years, IF(@pre_out!=3 and @pre_g_id=g_id, a.o-@pre_out , a.o) as out_diff, 
        @pre_out:=a.o, 
        @pre_pitcher_id:=a.pitcher_id, 
        @pre_g_id:=a.g_id, 
        a.g_id, 
        a.ab_id, a.pitcher_id, a.o
    FROM    atbats AS a,(SELECT @pre_out := 0, @pre_pitcher_id="", @pre_g_id="") as ini) as T,
            player_names as pl
WHERE pl.id=T.pitcher_id
GROUP BY years,g_id,pitcher_id );
        

