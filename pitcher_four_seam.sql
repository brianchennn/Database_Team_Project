/*投手進階 case4*/
/*每年度各球員四縫線快速球(FF)資訊*/
create table pitcher_four_seam(
select substring(A.ab_id,1,4) as year, N.id, N.first_name, N.last_name,
	round(avg(f_cnt.start_speed),2) as ff_v0_avg, round(max(f_cnt.start_speed),2) as MAX_speed,
	round(avg(f_cnt.spin_rate),0) as AVG_spin_rate, round(max(f_cnt.spin_rate),0) as MAX_spin_rate,
	round(avg(f_cnt.velocity_delta),2) as AVG_speed_diff, round(min(f_cnt.velocity_delta),2) as MIN_speed_diff
from(
	select P.ab_id, P.start_speed, P.spin_rate, (P.start_speed-P.end_speed) as velocity_delta
	from pitches as P
	where P.pitch_type = "FF") as f_cnt,
	atbats as A,
	player_names as N
where A.ab_id = f_cnt.ab_id
	and A.pitcher_id = N.id
group by substring(A.ab_id,1,4), A.pitcher_id 
);