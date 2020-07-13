/*先找出使用率超過5%的有誰*/
DROP TABLE if EXISTS pitcher_SI_use_more_than_5;
CREATE table pitcher_SI_use_more_than_5(
    SELECT
    SUBSTRING(a.ab_id, 1, 4) as years,
    a.pitcher_id

    FROM
    (
        SELECT p.ab_id, 
               (case when p.pitch_type = "SI" then 1
               else 0 end) as Use_count
        from pitches as p
    ) as P,
    atbats as a

    WHERE
    P.ab_id = a.ab_id
    GROUP BY years, a.pitcher_id
    HAVING avg(Use_count) > 0.05
);

/*再分析該球種*/
DROP TABLE if EXISTS pitcher_SI;
CREATE TABLE pitcher_SI(
    SELECT
    P.years,
    P.pitcher_id,
    pn.first_name,
    pn.last_name,
    P.pitch_type,
    ROUND(avg(P.start_speed),1) as SI_v0_avg,
    ROUND(avg(P.delta_speed),1) as SI_v_delta_avg,
    ROUND(avg(P.delta_y),1) as SI_y_delta_avg,
    ROUND(avg(P.spin_rate),1) as SI_spin_rate_avg

    FROM
    (
        SELECT
        SUBSTRING(a.ab_id, 1, 4) as years,
        a.pitcher_id,
        p.pitch_type,
        p.start_speed,
        p.spin_rate,
        (p.start_speed - p.end_speed) as delta_speed,
        (p.y - p.y0)as delta_y

        FROM
        atbats as a, pitches as p
        WHERE
        p.ab_id = a.ab_id and p.pitch_type = "SI"
    )as P,
    pitcher_SI_use_more_than_5 as temp,
    player_names as pn

    WHERE
    P.years = temp.years and P.pitcher_id = temp.pitcher_id and temp.pitcher_id = pn.id

    GROUP BY P.years, pn.first_name, pn.last_name, P.pitch_type
);
alter table pitcher_SI add primary key(years,pitcher_id);