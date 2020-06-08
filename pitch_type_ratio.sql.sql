/*投手進階 case1*/
/*每年度, 各投手的球種使用比例及次數*/
select pitch_type_cnt.year, N.id, N.first_name, N.last_name, pitch_type_cnt.pitch_type, pitch_type_cnt.cnt/total.cnt as ratio
from(
	select substring(A.ab_id,1,4) as year, A.pitcher_id, sum(ab_cnt.cnt) as cnt
	from(
		select P.ab_id, count(*) as cnt
		from pitches as P
		where P.pitch_type not like ""
		group by P.ab_id) as ab_cnt,
		atbats as A
	where A.ab_id = ab_cnt.ab_id
	group by substring(A.ab_id,1,4), A.pitcher_id) as total,
	(
		select substring(A.ab_id,1,4) as year, A.pitcher_id as pitcher_id, ab_type_cnt.pitch_type as pitch_type, sum(ab_type_cnt.cnt) as cnt
		from(
			select P.ab_id, P.pitch_type, count(*) as cnt
			from pitches as P
			where P.pitch_type not like ""
			group by P.ab_id, P.pitch_type) as ab_type_cnt,
			atbats as A
		where A.ab_id = ab_type_cnt.ab_id
		group by substring(A.ab_id,1,4), A.pitcher_id, ab_type_cnt.pitch_type) as pitch_type_cnt,
	player_names as N
where pitch_type_cnt.year = total.year
	and pitch_type_cnt.pitcher_id = total.pitcher_id
	and pitch_type_cnt.pitcher_id = N.id;

