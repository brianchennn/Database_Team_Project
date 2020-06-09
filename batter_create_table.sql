create table batter_create_table(
select batter_avg.year,batter_avg.id, batter_avg.first_name,batter_avg.last_name,batter_walk.PA as PA,batter_avg.atbat 
		as AB, batter_slg._1B as "1B", batter_slg._2B as "2B", batter_slg._3B as "3B", batter_slg._HR as "HR",batter_obp.OBP, batter_ops.OPS, batter_strikeout.strikeout 
		as K, batter_strikeout.strikeout_rate*9 as K9,
		batter_walk.BB as BB, batter_walk.BB_rate*9 as BB9
from batter_avg, batter_slg, batter_obp, batter_ops, batter_strikeout, batter_walk
where batter_avg.id = batter_slg.id and 
	  batter_slg.id = batter_obp.id and
	  batter_obp.id = batter_ops.id and
	  batter_ops.id = batter_strikeout.id and
	  batter_strikeout.id = batter_walk.id and
	  batter_avg.year = batter_slg.year and 
	  batter_slg.year = batter_obp.year and
	  batter_obp.year = batter_ops.year and
	  batter_ops.year = batter_strikeout.year and
	  batter_strikeout.year = batter_walk.year );
	  
