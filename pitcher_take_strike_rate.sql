/*投手進階case 11*/
/*每個球種的奪好球率, 依每年各投手group by*/
/*奪好球率 ： swing_strike + call_strike + 非兩好球時的界外)/某球種總球數*/
/*column name ： year, first_name, last_name, pitch_type, ratio, total*/

/*temp table*/
drop table if exists temp1 ;
create table temp1(
	select substring(P.ab_id,1,4) as year, A.pitcher_id, P.pitch_type, count(*) as total
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id and P.pitch_type not like ""
	group by substring(P.ab_id,1,4), A.pitcher_id, P.pitch_type);
	
drop table if exists temp2 ;
create table temp2(
select substring(A.ab_id,1,4) as year, A.pitcher_id, P.pitch_type, count(*) as cnt
	from pitches as P, atbats as A
	where P.ab_id = A.ab_id
		and (P.code = "S" or P.code = "C" or (P.code = "F" and P.s_count != 2))
		and P.pitch_type not like ""
	group by substring(A.ab_id,1,4), A.pitcher_id, P.pitch_type);
	
/*main query*/
drop table if exists pitcher_take_strike_rate ;
create table pitcher_take_strike_rate(
select temp1.year, N.first_name, N.last_name, temp1.pitch_type, ifnull(temp2.cnt,0)/temp1.total as ratio, temp1.total
from player_names as N,
	(temp1 left join temp2
	on temp2.year = temp1.year
		and temp2.pitcher_id = temp1.pitcher_id
		and temp2.pitch_type = temp1.pitch_type)
where N.id = temp1.pitcher_id
order by temp1.year, N.first_name, N.last_name, temp1.pitch_type
);

/*drop the temp table*/
drop table temp1;
drop table temp2;
