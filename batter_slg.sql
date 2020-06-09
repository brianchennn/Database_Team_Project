/*create table batter_slg(
select Year,first_name,id,last_name,sum(T1.cnt_baserun),sum(T1.cnt_atbat),sum(T1.cnt_baserun)/sum(T1.cnt_atbat) as SLG
from(
    select substring(ab_id,1,4) as Year,id,first_name,last_name,event,if(event="Single",count(*),if(event="Double",2*count(*),if(event="Triple",3*count(*),if(event="Home Run",4*count(*),0)))) as cnt_baserun, count(*) as cnt_atbat
    from player_names,atbats 
    where player_names.id = atbats.batter_id 
        and (event != "Walk" and event!="Sac Fly" and event!="Sac Bunt" and event != "Hit By Pitch" and event!="Catcher Interference" and event!="Batter Interference" and event!="Intent Walk")
    group by substring(ab_id,1,4) ,first_name,last_name,event ) as T1 
group by Year,first_name,last_name
having sum(T1.cnt_atbat)>=50
order by  Year asc,SLG desc);
*/
create table batter_slg(
SELECT 
    
	_SG_.years as year,
    player_names.id,
    player_names.first_name,
    player_names.last_name,
    _SG_.single +_DB_.doubl + _TP_.triple + _HR_.homerun as H,
    _SG_.single as _1B,
    _DB_.doubl as _2B,
    _TP_.triple as _3B,
    _HR_.homerun as _HR,
    _AB_.atbat as _AB,
    (_SG_.single+_DB_.doubl*2+_TP_.triple*3+_HR_.homerun*4)/_AB_.atbat as SLG
FROM
    player_names,
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.batter_id, count(a.event) as single
    FROM
        atbats AS a
    WHERE
        a.event = "Single"
	group by years, a.batter_id
	)  as _SG_,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.batter_id, count(a.event) as doubl
    FROM
        atbats AS a
    WHERE
        a.event = "Double"
	group by years, a.batter_id
	) AS _DB_,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.batter_id, count(a.event) as triple
    FROM
        atbats AS a
    WHERE
        a.event = "Triple"
	group by years, a.batter_id
	) AS _TP_,
    
    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.batter_id, count(a.event) as homerun
    FROM
        atbats AS a
    WHERE
        a.event = "Home Run"
	group by years, a.batter_id
	) AS _HR_,

    (SELECT 
        SUBSTRING(a.ab_id, 1, 4) AS years, a.batter_id, count(a.event) as atbat
    FROM
        atbats AS a
    WHERE
        event != "Walk" and event!="Sac Fly" and event!="Sac Bunt" and event != "Hit By Pitch" and event!="Catcher Interference" and event!="Batter Interference" and event!="Intent Walk"
	group by years, a.batter_id
	) AS _AB_

WHERE
        player_names.id = _SG_.batter_id
        AND   _SG_.batter_id = _DB_.batter_id and _SG_.years = _DB_.years
        AND _DB_.batter_id = _TP_.batter_id and _DB_.years = _TP_.years
        AND _TP_.batter_id = _HR_.batter_id and _TP_.years = _HR_.years
        AND _HR_.batter_id = _AB_.batter_id and _HR_.years = _AB_.years
        and _AB_.atbat >= 50
order by year asc, slg desc
);