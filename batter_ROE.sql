drop table if exists batter_ROE;
create table batter_ROE(
select years,id,sum(ROE) as ROE
from batter_ROE_per_game
group by years,id
);
ALTER TABLE batter_ROE ADD PRIMARY KEY(years,id);