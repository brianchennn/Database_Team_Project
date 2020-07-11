/*drop table if pitcher_walk;
create table pitcher_walk(
SELECT 
    Walk.years,
    player_names.first_name,
    player_names.last_name,
    pitcher_inning.total_inning,
    COUNT(*) AS total_walk,
    count(*)/(total_inning*9) as BB9
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) as years, a.pitcher_id
    FROM
        atbats AS a
    WHERE
        a.event = 'Walk' or a.event = 'Intent Walk' or a.event = 'Hit By Pitch'
	) AS Walk,
    player_names,
    pitcher_inning
WHERE
    Walk.years = pitcher_inning.years and player_names.id = Walk.pitcher_id and Walk.pitcher_id = pitcher_inning.id
GROUP BY Walk.years, player_names.first_name , player_names.last_name, pitcher_inning.total_inning
);
*/
drop table if exists pitcher_walk;
CREATE TABLE pitcher_walk(
SELECT S.years ,S.first_name,S.last_name,S.g_id,S.walk as "BB", HBP.hbp as "HBP"
FROM
    (SELECT SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id, sum(SS.walk) as walk
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event like "%Walk",1,0) as walk
        FROM atbats as A, player_names as PL
        WHERE  A.pitcher_id=PL.id
        ) as SS
    GROUP BY SS.years, SS.id, SS.first_name, SS.last_name, SS.g_id) as S,
    (SELECT HBPHBP.years, HBPHBP.id, HBPHBP.first_name, HBPHBP.last_name, HBPHBP.g_id, sum(HBPHBP.hbp) as hbp
    FROM
        (SELECT SUBSTRING(A.ab_id, 1, 4) AS years, PL.id, PL.first_name, PL.last_name, A.g_id, if(A.event = "Hit By Pitch",1,0) as hbp
        FROM atbats as A, player_names as PL
        WHERE  A.pitcher_id=PL.id
        ) as HBPHBP
    GROUP BY HBPHBP.years, HBPHBP.id, HBPHBP.first_name, HBPHBP.last_name, HBPHBP.g_id) as HBP
where S.id=HBP.id and S.years=HBP.years and S.g_id=HBP.g_id
order by years, first_name, last_name
);