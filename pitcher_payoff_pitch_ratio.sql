/*投手進階 case2*/
/*每年度, 2好球後各投手的球種使用比例, 次數及當下的好壞球數*/
drop table if exists payoff_pitch_ratio;
CREATE TABLE payoff_pitch_ratio select pitch_type_cnt.year, N.id, N.first_name, N.last_name, pitch_type_cnt.BS as ball_strike, pitch_type_cnt.pitch_type, pitch_type_cnt.cnt/total.cnt as ratio
from(
	select substring(A.ab_id,1,4) as year, A.pitcher_id, ab_cnt.BS, sum(ab_cnt.cnt) as cnt
	from(
		select P.ab_id, CONCAT_WS('_', P.b_count, P.s_count) as BS, count(*) as cnt
		from pitches as P
		where P.pitch_type not like ""
			and P.s_count = 2
		group by P.ab_id, CONCAT_WS('_', P.b_count, P.s_count)) as ab_cnt,
		atbats as A
	where A.ab_id = ab_cnt.ab_id
	group by substring(A.ab_id,1,4), A.pitcher_id, ab_cnt.BS) as total,
	(
		select substring(A.ab_id,1,4) as year, A.pitcher_id as pitcher_id, ab_type_cnt.pitch_type as pitch_type, ab_type_cnt.BS, sum(ab_type_cnt.cnt) as cnt
		from(
			select P.ab_id, P.pitch_type, CONCAT_WS('_', P.b_count, P.s_count) as BS, count(*) as cnt
			from pitches as P
			where P.pitch_type not like ""
				and P.s_count = 2
			group by P.ab_id, P.pitch_type, CONCAT_WS('_', P.b_count, P.s_count)) as ab_type_cnt,
			atbats as A
		where A.ab_id = ab_type_cnt.ab_id
		group by substring(A.ab_id,1,4), A.pitcher_id, ab_type_cnt.pitch_type, ab_type_cnt.BS) as pitch_type_cnt,
	player_names as N
where pitch_type_cnt.year = total.year
	and pitch_type_cnt.pitcher_id = total.pitcher_id
	and pitch_type_cnt.pitcher_id = N.id
	and pitch_type_cnt.BS = total.BS
order by total.year, N.id, total.BS, pitch_type_cnt.pitch_type;
