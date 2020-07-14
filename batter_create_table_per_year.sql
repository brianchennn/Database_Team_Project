drop table if exists t1;
create table t1(
select  batter_avg.year as years,
		batter_avg.id, 
		batter_avg.first_name,
		batter_avg.last_name,
		/*BPA.PA as PA,
		BAB.AB as AB, */
		BHPG.Single as Single, 
		BHPG.DDouble as DDouble, 
		BHPG.Triple as Triple, 
		BHPG.HR as HR , 
		BSPG.K as K, 
		BWPG.BB as BB,
		HBP,
		BIPG.IBB as IBB,
		/*BDP.DP as DP,
		(Single+DDouble+Triple+HR)/AB as AVG,*/
		batter_OBP.OBP,
		/*(Single+DDouble+Triple+HR+HBP+BB)/(AB+BB+HBP+SF) as OBP,
		(0.792*(BB-IBB) + 0.75*HBP + 0.9*Single + 0.92*ROE + 1.24*DDouble + 1.56*Triple + 1.95*HR)/PA as wOBA,*/
		batter_slg.SLG, 
		batter_ops.OPS
		/*batter_babip.BABIP,
		
		BSF.SF as SF*/
from batter_avg, batter_slg, 
	 batter_OBP, batter_ops, 
	 batter_hit as BHPG,
	 batter_walk as BWPG,
	 batter_IBB as BIPG,
	 batter_strikeout as BSPG
	 /*batter_babip,
	 batter_PA as BPA,
	 batter_AB as BAB,
	 batter_DP as BDP,
	 batter_SF as BSF,
	 batter_ROE as ROE*/
where batter_avg.id = batter_slg.id and 
	  batter_slg.id = batter_OBP.id and
	  batter_OBP.id = batter_ops.id and
	  batter_ops.id = BHPG.id and
	  BHPG.id = BWPG.id and
	  BWPG.id = BIPG.id and 
	  BIPG.id = BSPG.id and
	  /*BSPG.id = batter_babip.id and 
	  batter_babip.id = BPA.id and 
	  BPA.id = BDP.id and 
	  BDP.id = BSF.id and 
	  BSF.id = BAB.id and 
	  BAB.id = ROE.id and */
	  batter_avg.year = batter_slg.year and 
	  batter_slg.year = batter_OBP.year and
	  batter_OBP.year = batter_ops.year and
	  batter_ops.year = BHPG.years and
	  BHPG.years = BWPG.years and
	  BWPG.years = BIPG.years and 
	  BIPG.years = BSPG.years
	  /*BSPG.years = batter_babip.years and 
	  batter_babip.years = BPA.years and 
	  BPA.years = BDP.years and 
	  BDP.years = BSF.years and 
	  BSF.years = BAB.years and 
	  BAB.years = ROE.years */
	);
alter table t1 add primary key(years,id);

drop table if exists t2;
create table t2(
select  /*batter_avg.year as years,
		batter_avg.id, 
		batter_avg.first_name,
		batter_avg.last_name,*/
		BPA.years ,
		BPA.id,
		BPA.PA as PA,
		BAB.AB as AB, 
		/*BHPG.Single as Single, 
		BHPG.DDouble as DDouble, 
		BHPG.Triple as Triple, 
		BHPG.HR as HR , 
		BSPG.K as K, 
		BWPG.BB as BB,
		HBP,
		BIPG.IBB as IBB,*/
		BDP.DP as DP,
		/*(Single+DDouble+Triple+HR)/AB as AVG,
		batter_OBP.OBP,
		/*(Single+DDouble+Triple+HR+HBP+BB)/(AB+BB+HBP+SF) as OBP,
		(0.792*(BB-IBB) + 0.75*HBP + 0.9*Single + 0.92*ROE + 1.24*DDouble + 1.56*Triple + 1.95*HR)/PA as wOBA,*/
		/*batter_slg.SLG, 
		batter_ops.OPS*/
		batter_babip.BABIP,
		BSF.SF as SF,
		BROE.ROE as ROE
from /*batter_avg, batter_slg, 
	 batter_OBP, batter_ops, 
	 batter_hit as BHPG,
	 batter_walk as BWPG,
	 batter_IBB as BIPG,
	 batter_strikeout as BSPG*/
	 batter_babip,
	 batter_PA as BPA,
	 batter_AB as BAB,
	 batter_DP as BDP,
	 batter_SF as BSF,
	 batter_ROE as BROE
where /*batter_avg.id = batter_slg.id and 
	  batter_slg.id = batter_OBP.id and
	  batter_OBP.id = batter_ops.id and
	  batter_ops.id = BHPG.id and
	  BHPG.id = BWPG.id and
	  BWPG.id = BIPG.id and 
	  BIPG.id = BSPG.id and
	  BSPG.id = batter_babip.id and*/ 
	  batter_babip.id = BPA.id and 
	  BPA.id = BDP.id and 
	  BDP.id = BSF.id and 
	  BSF.id = BAB.id and 
	  BAB.id = BROE.id and 
	  /*batter_avg.year = batter_slg.year and 
	  batter_slg.year = batter_OBP.year and
	  batter_OBP.year = batter_ops.year and
	  batter_ops.year = BHPG.years and
	  BHPG.years = BWPG.years and
	  BWPG.years = BIPG.years and 
	  BIPG.years = BSPG.years and 
	  BSPG.years = batter_babip.years and*/ 
	  batter_babip.years = BPA.years and 
	  BPA.years = BDP.years and 
	  BDP.years = BSF.years and 
	  BSF.years = BAB.years and
	  BAB.years = BROE.years 
	);
alter table t2 add primary key(years,id);


drop table if exists batter_create_table_per_year;
create table batter_create_table_per_year(
select  t1.years,
		t1.id, 
		t1.first_name,
		t1.last_name,
		t2.PA as PA,
		t2.AB as AB, 
		t1.Single, 
		t1.DDouble, 
		t1.Triple, 
		t1.HR , 
		t1.K, 
		t1.BB,
		t1.HBP,
		t1.IBB as IBB,
		t2.DP as DP,
		(Single+DDouble+Triple+HR)/AB as AVG,
		(Single+DDouble+Triple+HR+HBP+BB)/(AB+BB+HBP+SF) as OBP,
		ROUND((0.792*(BB-IBB) + 0.75*HBP + 0.9*Single + 0.92*ROE + 1.24*DDouble + 1.56*Triple + 1.95*HR)/PA,3) as wOBA,
		SLG, 
		OPS,
		BABIP,
		SF,
		ROE
from t1,t2
where t1.id=t2.id and t1.years=t2.years
);
alter table batter_create_table_per_year add primary key(years,id);

--  select * from batter_create_table_per_year limit 10;