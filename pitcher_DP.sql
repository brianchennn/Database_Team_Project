/*每年每場投手製造滾地雙殺的次數*/
drop table if exists pitcher_DP;
CREATE TABLE pitcher_DP(
SELECT S.years, S.id, S.first_name,S.last_name,S.g_id,S.DP as "DP"
FROM
    (SELECT SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id, sum(SS.dp) as DP
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event like "Grounded Into DP",1,0) as dp
        FROM atbats as A, player_names as PL
        WHERE  A.pitcher_id=PL.id
        ) as SS
    GROUP BY SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id) as S
    
order by years, first_name, last_name, DP

primary key(S.g_id,S.id)
);