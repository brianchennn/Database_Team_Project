drop table if exists _all_pitch_type;
create table _all_pitch_type(
	select P.pitch_type
	from pitches as P
	where P.pitch_type != "" and P.pitch_type != "AB" and P.pitch_type != "FA"
	group by P.pitch_type);

drop table if exists _all_pitcher;
create table _all_pitcher(
	select substring(A.ab_id,1,4) as years, A.pitcher_id as id
	from atbats as A
	group by substring(A.ab_id,1,4), A.pitcher_id);

drop table if exists _all_pitcher_pitch_type;
create table _all_pitcher_pitch_type(
	select T2.years, T2.id, T1.pitch_type
	from _all_pitch_type as T1, _all_pitcher as T2);
alter table _all_pitcher_pitch_type add primary key(years,id,pitch_type);

drop table if exists _all_pitches;	
create table _all_pitches(
	select 	substring(P.ab_id,1,4) as years, 
			A.pitcher_id as id, 
			P.pitch_type,
			round(avg(P.start_speed),1) as v0_avg, 
			round(avg(P.start_speed - P.end_speed),1) as v_delta_avg, 
			round(avg(P.spin_rate),1) as spin_rate_avg,
			count(*) as use_count
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
	group by substring(P.ab_id,1,4), A.pitcher_id, P.pitch_type);
alter table _all_pitches add primary key(years,id,pitch_type);

drop table if exists _all_pitcher_pitch_type_strike_cnt;
create table _all_pitcher_pitch_type_strike_cnt(
	select substring(P.ab_id,1,4) as years, A.pitcher_id as id, P.pitch_type, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id and (P.code="S" or P.code="C" or P.code="T" or (P.code="F" and P.s_count!=2))
	group by substring(P.ab_id,1,4), A.pitcher_id, P.pitch_type);
alter table _all_pitcher_pitch_type_strike_cnt add primary key(years, id, pitch_type);
	
drop table if exists _all_pitcher_pitch_type_cnt;
create table _all_pitcher_pitch_type_cnt(
	select substring(P.ab_id,1,4) as years, A.pitcher_id as id, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
	group by substring(P.ab_id,1,4), A.pitcher_id);
alter table _all_pitcher_pitch_type_cnt add primary key(years,id);

drop table if exists _join;
create table _join(
	select 	T1.years, 
			T1.id as id, 
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
	on(T1.years = T2.years and T1.id = T2.id and T1.pitch_type = T2.pitch_type)
	left join _all_pitcher_pitch_type_strike_cnt as T3
	on(T1.years = T3.years and T1.id = T3.id and T1.pitch_type = T3.pitch_type)
	left join _all_pitcher_pitch_type_cnt as T4
	on(T1.years = T4.years and T1.id = T4.id));

drop table _all_pitch_type;
drop table _all_pitcher;
drop table _all_pitcher_pitch_type;
drop table _all_pitches;
drop table _all_pitcher_pitch_type_cnt;
drop table _all_pitcher_pitch_type_strike_cnt;

drop table if exists pitch_type_create_table_per_year;
create table pitch_type_create_table_per_year(
	select	T.years,
			T.id, 
			N.first_name, 
			N.last_name,
			T.pitch_type, 
			T.use_count, 
			T.use_ratio,
			T.strike_count,
			T.strike_ratio,
			T.v0_avg, 
			T.v_delta_avg, 
			T.spin_rate_avg
	from _join as T, player_names as N
	where T.id = N.id
	order by T.years, T.id, T.pitch_type);

drop table _join;

