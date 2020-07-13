drop table if exists batter_IBB;
create table batter_IBB(
select BWPG.years,BWPG.id,BWPG.first_name,BWPG.last_name,sum(BWPG.IBB) as IBB
from batter_IBB_per_game as BWPG
group by BWPG.years,BWPG.id
);
ALTER TABLE batter_IBB ADD PRIMARY KEY(years,id);

