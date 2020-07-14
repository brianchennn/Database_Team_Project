/*投手進階 case5*/
/*所有的三振中、各球種使用比例*/

/*temp table*/
drop table if exists _type_cnt;
create table _type_cnt(
	select substring(P.ab_id,1,4) as year, A.pitcher_id, P.pitch_type, CONCAT_WS('_', P.b_count, P.s_count) as BS, count(P.pitch_type) as cnt
	from(
		select P.ab_id, A.pitcher_id, max(P.pitch_num) as n
		from atbats as A, pitches as P
		where (A.event = "Strikeout" or A.event = "Strikeout - DP")
			and A.ab_id = P.ab_id
		group by P.ab_id) as pitch_num,
		pitches as P,
		atbats as A
	where P.ab_id = pitch_num.ab_id
		and P.pitch_num = pitch_num.n
		and A.ab_id = P.ab_id
	group by substring(P.ab_id,1,4), A.pitcher_id, P.pitch_type, CONCAT_WS('_', P.b_count, P.s_count));
	
/*main query*/
drop table if exists pitcher_strkiout_ratio_for_every_pitch;

create table pitcher_strkiout_ratio_for_every_pitch( 
select T.year, N.id, N.first_name, N.last_name, T.BS as ball_strike, T.pitch_type, T.cnt/total.cnt as ratio
from _type_cnt as T,
	(
	select T.year, T.pitcher_id, T.BS, sum(T.cnt) as cnt
	from _type_cnt as T
	group by T.year, T.pitcher_id, T.BS) as total,
	player_names as N
where T.pitcher_id = total.pitcher_id
	and T.year = total.year
	and T.pitcher_id = N.id
	and T.BS = total.BS
order by T.year, N.id, T.BS, T.pitch_type
);
/*drop the temp table*/
drop table _type_cnt;