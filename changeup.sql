DROP TABLE if EXISTS changeup;
CREATE TABLE changeup(
    SELECT
    P.years,
    pn.first_name,
    pn.last_name,
    P.pitch_type,
    avg(P.start_speed) as ch_v0_avg,
    avg(P.delta_speed) as ch_v_delta_avg,
    avg(P.delta_y) as ch_y_delta_avg,
    avg(P.spin_rate) as ch_spin_rate_avg

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
        p.ab_id = a.ab_id and p.pitch_type = "CH"
    )as P,
    changeup_use_more_than_10 as cumt5,
    player_names as pn

    WHERE
    P.years = cumt5.years and P.pitcher_id = cumt5.pitcher_id and cumt5.pitcher_id = pn.id

    GROUP BY P.years, pn.first_name, pn.last_name, P.pitch_type
);