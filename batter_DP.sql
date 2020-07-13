drop table if exists batter_DP;
create table batter_DP(
select years,id,sum(DP) as DP
from batter_DP_per_game
group by years,id
);
ALTER TABLE batter_DP ADD PRIMARY KEY(years,id);