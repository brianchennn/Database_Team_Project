create table batter_create_table(select batter_avg.year,batter_avg.id, batter_avg.first_name,batter_avg.last_name,batter_walk.PA as PA,batter_avg.atbat as AB,batter_avg.hit as H, batter_homerun.cnt as HR, batter_obp.OBP, batter_ops.OPS, batter_strikeout.strikeout as K, batter_strikeout.strikeout_rate*9 as K9,
		batter_walk.BB as BB, batter_walk.BB_rate*9 as BB9
from batter_avg, batter_homerun, batter_obp, batter_ops, batter_strikeout, batter_walk
where batter_avg.id = batter_homerun.id and
	  batter_homerun.id = batter_obp.id and
	  batter_obp.id = batter_ops.id and
	  batter_ops.id = batter_strikeout.id and
	  batter_strikeout.id = batter_walk.id );
	  
