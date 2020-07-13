drop table if exists batter_create_table_per_year;
create table batter_create_table_per_year(
select batter_avg.year,batter_avg.id, batter_avg.first_name,batter_avg.last_name,batter_walk.PA as PA,batter_avg.atbat, batter_avg.atbat 
		as AB, batter_slg._H as "H", batter_slg._1B as "1B", batter_slg._2B as "2B", batter_slg._3B as "3B", batter_slg._HR as "HR" , batter_strikeout.strikeout 
		as K, 
		batter_walk.BB as BB,
		batter_IBB.IBB as IBB,
		batter_avg.AVG,batter_OBP.OBP,batter_slg.SLG, batter_ops.OPS,batter_babip.BABIP
from batter_avg, batter_slg, batter_OBP, batter_ops, batter_strikeout, batter_walk, 
	 batter_babip, batter_IBB
where batter_avg.id = batter_slg.id and 
	  batter_slg.id = batter_OBP.id and
	  batter_OBP.id = batter_ops.id and
	  batter_ops.id = batter_strikeout.id and
	  batter_strikeout.id = batter_walk.id and
	  batter_walk.id = batter_babip.id and
	  batter_babip.id = batter_IBB.id and
	  batter_avg.year = batter_slg.year and 
	  batter_slg.year = batter_OBP.year and
	  batter_OBP.year = batter_ops.year and
	  batter_ops.year = batter_strikeout.year and
	  batter_strikeout.year = batter_walk.year  and
	  batter_walk.year = batter_babip.years  and
	  batter_babip.years = batter_IBB.years 
	  
	  
	);

