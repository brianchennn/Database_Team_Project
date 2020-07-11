/*紀錄每年每場投手的用球數、局數、平均每個出局的用球數*/
create table temp(
    SELECT SUBSTRING(A.ab_id, 1, 4) AS years, A.g_id as g_id, P.ab_id, A.pitcher_id,P.pitch_num
    FROM pitches as P, atbats as A
    WHERE P.ab_id=A.ab_id
);
drop table if exists pitch_num_per_game; 
create table pitch_num_per_game(
SELECT T1.years, T1.first_name, T1.last_name, T1.g_id, Pitch_per_Game , p_IP.IP, Pitch_per_Game/IP/3 as pitch_per_out
FROM(
    SELECT T.years, PL.first_name, PL.last_name,T.pitcher_id, T.g_id, count(pitch_num) as Pitch_per_Game
    FROM temp as T,  player_names as PL
    WHERE T.pitcher_id = PL.id
    GROUP BY years, PL.first_name, PL.last_name, T.g_id
    ) as T1, pitcher_inning as p_IP
WHERE T1.g_id = p_IP.g_id and T1.pitcher_id = p_IP.id
ORDER BY T1.years, Pitch_per_Game desc
);
drop table if exists temp;