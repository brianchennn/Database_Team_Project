drop table if exists _all_pitch_type;
create table _all_pitch_type(
	select P.pitch_type
	from pitches as P
	where P.pitch_type != "" and P.pitch_type != "AB" and P.pitch_type != "FA"
	group by P.pitch_type);

drop table if exists _all_pitcher;
create table _all_pitcher(
	select A.pitcher_id as id, A.g_id
	from atbats as A
	group by A.g_id, A.pitcher_id);
	
drop table if exists _all_pitcher_pitch_type;
create table _all_pitcher_pitch_type(
	select T2.id, T1.pitch_type, T2.g_id
	from _all_pitch_type as T1, _all_pitcher as T2);
alter table _all_pitcher_pitch_type add primary key(g_id,id,pitch_type);

drop table if exists _all_pitches;
create table _all_pitches(
	select 	A.pitcher_id as id,
			A.g_id,
			P.pitch_type,
			round(avg(P.start_speed),1) as v0_avg,
			round(avg(P.start_speed - P.end_speed),1) as v_delta_avg,
			round(avg(P.spin_rate),1) as spin_rate_avg,
			count(*) as use_count
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
	group by A.g_id, A.pitcher_id, P.pitch_type);
alter table _all_pitches add primary key(g_id,id,pitch_type);

drop table if exists _all_pitcher_pitch_type_strike_cnt;
create table _all_pitcher_pitch_type_strike_cnt(
	select A.g_id, A.pitcher_id as id, P.pitch_type, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id and (P.code="S" or P.code="C" or P.code="T" or (P.code="F" and P.s_count!=2))
	group by A.g_id, A.pitcher_id, P.pitch_type);
alter table _all_pitcher_pitch_type_strike_cnt add primary key(g_id, id, pitch_type);

drop table if exists _all_pitcher_pitch_type_cnt;
create table _all_pitcher_pitch_type_cnt(
	select A.g_id, A.pitcher_id as id, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
	group by A.g_id, A.pitcher_id);
alter table _all_pitcher_pitch_type_cnt add primary key(g_id,id);

drop table if exists _join;
create table _join(
	select 	T1.id,
			T1.g_id,
			T1.pitch_type,
			T2.v0_avg,
			T2.v_delta_avg,
			T2.spin_rate_avg,
			ifnull(T2.use_count,0) as use_count,
			ifnull(T3.cnt,0) as strike_count,
			round(ifnull(T2.use_count,0)/ifnull(T4.cnt,1),2) as use_ratio,
			round(ifnull(T3.cnt,0)/ifnull(T2.use_count,1),2) as strike_ratio
	from _all_pitcher_pitch_type as T1
	left join _all_pitches as T2
	on(T1.id = T2.id and T1.pitch_type = T2.pitch_type and T1.g_id = T2.g_id)
	left join _all_pitcher_pitch_type_strike_cnt as T3
	on(T1.g_id = T3.g_id and T1.id = T3.id and T1.pitch_type = T3.pitch_type)
	left join _all_pitcher_pitch_type_cnt as T4
	on(T1.g_id = T4.g_id and T1.id = T4.id));

drop table _all_pitch_type;
drop table _all_pitcher;
drop table _all_pitcher_pitch_type;
drop table _all_pitches;
drop table _all_pitcher_pitch_type_strike_cnt;
drop table _all_pitcher_pitch_type_cnt;

drop table if exists pitch_type_create_table_per_game;
create table pitch_type_create_table_per_game(
	select 	substring(T.g_id,1,4) as years,
			T.id,
			N.first_name,
			N.last_name,
			T.g_id,
			T.pitch_type,
			T.use_count,
			T.use_ratio,
			T.strike_count,
			T.strike_ratio,
			T.v0_avg,
			T.v_delta_avg,
			T.spin_rate_avg,
			date_format(G.date,"%Y%m%d")
	from _join as T, player_names as N, games as G
	where T.id = N.id and T.g_id=G.g_id
	order by T.g_id, T.id, T.pitch_type);
/*alter table pitch_type_create_table_per_game add primary key(g_id,id);*/
	
drop table _join;