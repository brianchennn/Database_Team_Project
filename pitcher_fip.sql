
drop table if exists pitcher_fip_constant;
create table pitcher_fip_constant(
    years varchar(4),
    fip_const float,
    primary key(years)
);
insert into pitcher_fip_constant
(years,fip_const)
VALUES
(2015,3.134),
(2016,3.147),
(2017,3.158),
(2018,3.161);

drop table if exists pitcher_fip;
create table pitcher_fip(
SELECT 
	K.years as years,
    K.id,
    K.first_name,
    K.last_name,
    HR.home_run,
    BB.walk,
    HBP.hit_by_pitch,
    K.strikeout,
    IP.IP,
    FIP_CONST.fip_const,
    ROUND(((13*home_run)+(3*(walk+hit_by_pitch))-(2*strikeout))/IP+fip_const,3) as FIP
FROM
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, P.id,P.first_name,P.last_name, count(a.event) as home_run
    FROM
        atbats AS a,
        player_names as P
    WHERE
        a.event = "Home Run" and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS HR,

    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years,P.id ,P.first_name,P.last_name, count(a.event) as walk
    FROM
        atbats AS a,
        player_names as P
    WHERE
        (a.event = "Walk" or a.event = "Intent Walk" )and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS BB,

    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, P.id, P.first_name,P.last_name, count(a.event) as hit_by_pitch
    FROM
        atbats AS a,
        player_names as P
    WHERE
        a.event = "Hit By Pitch" and 
        P.id = a.pitcher_id
	group by years, P.first_name,P.last_name
	) AS HBP,
    
    (
        SELECT 
            SUBSTRING(a.ab_id, 1, 4) AS years, P.id, P.first_name,P.last_name, count(a.event) as strikeout
        FROM
            atbats AS a,
            player_names as P
        WHERE
            a.event = "Strikeout" and 
            P.id = a.pitcher_id
        group by years, P.id, P.first_name,P.last_name
	) AS K,
    (
        SELECT PYI.years, PYI.id, PYI.first_name, PYI.last_name, PYI.IP
        FROM pitcher_year_inning as PYI
    )as IP,
    pitcher_fip_constant as FIP_CONST

WHERE
    HR.id = BB.id
    and BB.id = K.id
    and K.id = IP.id
    and IP.id = HBP.id
    and HR.id = BB.id
    /*
    HR.first_name = BB.first_name
    and BB.first_name = K.first_name
    and K.first_name = IP.first_name
    and IP.first_name = HBP.first_name
    and HR.last_name = BB.last_name
    and BB.last_name = K.last_name
    and K.last_name = IP.last_name
    and IP.last_name = HBP.last_name*/
    and FIP_CONST.years = HR.years
    and HR.years = BB.years
    and BB.years = K.years
    and K.years = IP.years
    and IP.years = HBP.years
order by years,FIP);
alter table pitcher_fip add primary key(years,id);

