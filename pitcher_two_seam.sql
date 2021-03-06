/*投手進階 case4*/
/*每年度各球員二縫線快速球(FT)資訊*/
drop table if exists pitcher_two_seam; 
create table pitcher_two_seam(
select substring(A.ab_id,1,4) as year, N.id, N.first_name, N.last_name,
	round(avg(f_cnt.start_speed),1) as ff_v0_avg, round(max(f_cnt.start_speed),1) as ff_v0_max,
	round(avg(f_cnt.spin_rate),3) as ff_spin_rate_avg, round(max(f_cnt.spin_rate),3) as ff_spin_rate_max,
	round(avg(f_cnt.velocity_delta),1) as ff_v_delta_avg, round(min(f_cnt.velocity_delta),1) as ff_v_delta_min
from(
	select P.ab_id, P.start_speed, P.spin_rate, (P.start_speed-P.end_speed) as velocity_delta
	from pitches as P
	where P.pitch_type = "FT") as f_cnt,
	atbats as A,
	player_names as N
where A.ab_id = f_cnt.ab_id
	and A.pitcher_id = N.id
group by substring(A.ab_id,1,4), A.pitcher_id
);
