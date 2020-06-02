/*球隊case 1*/
/*左投剋左打 右投剋右打*/
select cnt_baserun.year,cnt_baserun.dir as direction, cnt_baserun.cnt as cnt_baserun, cnt_atbat.cnt as cnt_atbat,(cnt_baserun.cnt)/(cnt_atbat.cnt) as SLG
from (
	select substring(A.ab_id,1,4) as year, A.p_throws as dir, count(*) as cnt
	from atbats as A
	where (A.event = "Single"
		or A.event = "Double"
		or A.event = "Triple"
		or A.event = "Home Run%")
	and A.p_throws = A.stand
	group by substring(A.ab_id,1,4), A.p_throws) as cnt_baserun,
	(
	select substring(A.ab_id,1,4) as year, A.p_throws as dir, count(*) as cnt
	from atbats as A
	where A.p_throws = A.stand
		and A.event != "Walk" 
		and A.event != "Sac Fly" 
		and A.event != "Sac Bunt" 
		and A.event != "Hit By Pitch" 
		and A.event != "Catcher Interference" 
		and A.event != "Intent Walk"
	group by substring(A.ab_id,1,4), A.p_throws) as cnt_atbat
where cnt_baserun.year = cnt_atbat.year
	and cnt_baserun.dir = cnt_atbat.dir;
	
