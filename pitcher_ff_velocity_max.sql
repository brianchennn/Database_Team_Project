/*每年的直球極速*/
drop table if exists ff_velocity_max_years; 
create table ff_velocity_max_years
(select
	SUBSTRING(atbat.ab_id, 1, 4) AS years,
  player_names.id,
	player_names.first_name,
    player_names.last_name,
    round(max(start_speed), 4) as max_ff_velocity
from
	player_names,
	(select a.ab_id, a.pitcher_id
    from atbats as a
    ) as atbat,
    
    (select ab_id, start_speed
    from pitches 
    where pitch_type = "FF"
    ) as FF

where player_names.id = atbat.pitcher_id and atbat.ab_id = FF.ab_id
group by years, player_names.id, player_names.first_name , player_names.last_name
);