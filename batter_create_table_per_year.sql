drop table if exists batter_create_table_per_year;
create table batter_create_table_per_year(
select  batter_avg.year as years,
		batter_avg.id, 
		batter_avg.first_name,
		batter_avg.last_name,
		BPA.PA as PA,
		batter_avg.atbat as AB, 
		BHPG.Single as Single, 
		BHPG.DDouble as "Double", 
		BHPG.Triple as Triple, 
		BHPG.HR as HR , 
		BSPG.K as K, 
		BWPG.BB as BB,
		BIPG.IBB as IBB,
		BDP.DP as DP,
		batter_avg.AVG,
		batter_OBP.OBP,
		batter_slg.SLG, 
		batter_ops.OPS,
		batter_babip.BABIP
from batter_avg, batter_slg, 
	 batter_OBP, batter_ops, 
	 batter_hit as BHPG,
	 batter_walk as BWPG,
	 batter_IBB as BIPG,
	 batter_strikeout as BSPG,
	 batter_babip,
	 batter_PA as BPA,
	 batter_DP as BDP
where batter_avg.id = batter_slg.id and 
	  batter_slg.id = batter_OBP.id and
	  batter_OBP.id = batter_ops.id and
	  batter_ops.id = BHPG.id and
	  BHPG.id = BWPG.id and
	  BWPG.id = BIPG.id and 
	  BIPG.id = BSPG.id and
	  BSPG.id = batter_babip.id and 
	  batter_babip.id = BPA.id and 
	  BPA.id = BDP.id and 
	  batter_avg.year = batter_slg.year and 
	  batter_slg.year = batter_OBP.year and
	  batter_OBP.year = batter_ops.year and
	  batter_ops.year = BHPG.years and
	  BHPG.years = BWPG.years and
	  BWPG.years = BIPG.years and 
	  BIPG.years = BSPG.years and
	  BSPG.years = batter_babip.years and 
	  batter_babip.years = BPA.years and 
	  BPA.years = BDP.years 
	);
alter table batter_create_table_per_year add primary key(years,id);


