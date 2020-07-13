drop table if exists _all_pitch_type;
create table _all_pitch_type(
	select P.pitch_type
	from pitches as P
	where P.pitch_type != "" and P.pitch_type != "AB" and P.pitch_type != "FA"
	group by P.pitch_type);

drop table if exists _all_pitcher;
create table _all_pitcher(
	select A.pitcher_id, A.g_id
	from atbats as A
	group by A.g_id, A.pitcher_id);
	
drop table if exists _all_pitcher_pitch_type;
create table _all_pitcher_pitch_type(
	select T2.pitcher_id, T1.pitch_type, T2.g_id
	from _all_pitch_type as T1, _all_pitcher as T2);
alter table _all_pitcher_pitch_type add primary key(g_id,pitcher_id,pitch_type);

drop table if exists _all_pitches;	
create table _all_pitches(
	select A.pitcher_id, A.g_id, P.pitch_type,
	round(avg(P.start_speed),1) as v0_avg, round(avg(P.start_speed - P.end_speed),1) as v_delta_avg, 
	round(avg(P.y - P.y0),1) as y_delta_avg, round(avg(P.spin_rate),1) as spin_rate_avg
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
	group by A.g_id, A.pitcher_id, P.pitch_type);
alter table _all_pitches add primary key(g_id,pitcher_id,pitch_type);

drop table if exists _join;
create table _join(
	select T1.pitcher_id, T1.g_id, T1.pitch_type, T2.v0_avg, T2.v_delta_avg, T2.y_delta_avg, T2.spin_rate_avg
	from _all_pitcher_pitch_type as T1 left join _all_pitches as T2
	on(T1.pitcher_id = T2.pitcher_id and T1.pitch_type = T2.pitch_type and T1.g_id = T2.g_id));

drop table if exists pitch_type_create_table_per_game;
create table pitch_type_create_table_per_game(
	select substring(T.g_id,1,4) as years, T.pitcher_id as id, N.first_name, N.last_name, T.g_id, T.pitch_type, T.v0_avg, T.v_delta_avg, T.y_delta_avg, T.spin_rate_avg
	from _join as T, player_names as N
	where T.pitcher_id = N.id
	order by T.g_id, T.pitcher_id, T.pitch_type);
alter table pitch_type_create_table_per_game add primary key(g_id,id);
	
drop table _all_pitch_type;
drop table _all_pitcher;
drop table _all_pitcher_pitch_type;
drop table _all_pitches;
drop table _join;