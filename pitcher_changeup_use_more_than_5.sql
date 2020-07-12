DROP TABLE if EXISTS pitcher_changeup_use_more_than_5;
CREATE table pitcher_changeup_use_more_than_5(
    SELECT
    SUBSTRING(a.ab_id, 1, 4) as years,
    a.pitcher_id

    FROM
    (
        SELECT p.ab_id, 
               (case when p.pitch_type = "CH" then 1
               else 0 end) as CH_count
        from pitches as p
    ) as P,
    atbats as a

    WHERE
    P.ab_id = a.ab_id
    GROUP BY years, a.pitcher_id
    HAVING avg(CH_count) > 0.1
);