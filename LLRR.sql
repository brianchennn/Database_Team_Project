/*球隊case 1*/
/*列出左投或右投對左打或右打的打擊率*/
CREATE TABLE LLRR select cnt_baserun.year,
	(case cnt_baserun.pitcher_batter when "LL" then "Left_Left" when "LR" then "Left_Right" when "RL" then "Right_Left" when "RR" then "Right_Right" END) as pitcher_batter_stand
	, sum(cnt_baserun.cnt) as cnt_baserun, sum(cnt_atbat.cnt) as cnt_atbat,sum(cnt_baserun.cnt)/sum(cnt_atbat.cnt) as AVG
from (
	select substring(A.ab_id,1,4) as year, A.batter_id, CONCAT_WS('',A.p_throws , A.stand) as pitcher_batter, count(*) as cnt
	from atbats as A
	where (A.event = "Single"
		or A.event = "Double"
		or A.event = "Triple"
		or A.event = "Home Run%")
	group by substring(A.ab_id,1,4), A.batter_id, CONCAT_WS('',A.p_throws , A.stand)) as cnt_baserun,
	(
	select substring(A.ab_id,1,4) as year, A.batter_id, CONCAT_WS('',A.p_throws , A.stand) as pitcher_batter, count(*) as cnt
	from atbats as A
	where (A.event != "Walk" 
		and A.event != "Sac Fly" 
		and A.event != "Sac Bunt" 
		and A.event != "Hit By Pitch" 
		and A.event != "Catcher Interference" 
		and A.event != "Intent Walk")
	group by substring(A.ab_id,1,4), A.batter_id, CONCAT_WS('',A.p_throws , A.stand)
	having cnt >= 50) as cnt_atbat,
	(
	select substring(A.ab_id,1,4) as year, A.batter_id, count(*) as cnt
	from atbats as A
	where (A.event != "Walk" 
		and A.event != "Sac Fly" 
		and A.event != "Sac Bunt" 
		and A.event != "Hit By Pitch" 
		and A.event != "Catcher Interference" 
		and A.event != "Intent Walk")
	group by substring(A.ab_id,1,4), A.batter_id
	having cnt >= 50) as cnt_player
where cnt_baserun.year = cnt_atbat.year
	and cnt_baserun.batter_id = cnt_atbat.batter_id
	and cnt_baserun.batter_id = cnt_player.batter_id
	and cnt_baserun.pitcher_batter = cnt_atbat.pitcher_batter
group by cnt_baserun.year, cnt_baserun.pitcher_batter
order by year, field(pitcher_batter_stand, "Left_Left", "Left_Right", "Right_Right", "Right_Left");
	
