select *
from batter_avg, batter_homerun, batter_obp, batter_ops, batter_strikeout, 
	 batter_walk
where batter_avg.first_name = batter_homerun.first_name and
	  batter_homerun.first_name = batter_obp.first_name and
	  batter_obp.first_name = batter_ops.first_name and
	  batter_ops.first_name = batter_strikeout.first_name and
	  batter_strikeout.first_name = batter_walk.first_name and	
	  batter_avg.last_name = batter_homerun.last_name and
	  batter_homerun.last_name = batter_obp.last_name and
	  batter_obp.last_name = batter_ops.last_name and
	  batter_ops.last_name = batter_strikeout.last_name and
	  batter_strikeout.last_name = batter_walk.last_name ;
	  
