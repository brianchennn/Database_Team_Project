/*投手進階case 11*/
/*每個球種的奪好球率, 依每年各投手group by*/
/*奪好球率 ： swing_strike + call_strike + 非兩好球時的界外)/某球種總球數*/
/*column name ： year, first_name, last_name, pitch_type, ratio, total*/
/*若好球次數為零因count不到所以要用別種寫法, 但通常都只有1,2次所以我直接忽略(偷懶)*/
select total_cnt.year, N.first_name, N.last_name, total_cnt.pitch_type, type_cnt.cnt/total_cnt.cnt as ratio, total_cnt.cnt as total
from (
	select substring(A.ab_id,1,4) as year, A.pitcher_id, P.pitch_type, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
		and (P.code = "S" or P.code = "C" or (P.code = "F" and P.s_count != 2))
		and P.pitch_type not like ""
	group by substring(A.ab_id,1,4), A.pitcher_id, P.pitch_type) as type_cnt,
	(select substring(A.ab_id,1,4) as year, A.pitcher_id, P.pitch_type, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
		and P.pitch_type not like ""
	group by substring(A.ab_id,1,4), A.pitcher_id, P.pitch_type) as total_cnt,
	player_names as N
where N.id = type_cnt.pitcher_id
	and total_cnt.year = type_cnt.year
	and total_cnt.pitcher_id = type_cnt.pitcher_id
	and total_cnt.pitch_type = type_cnt.pitch_type;
