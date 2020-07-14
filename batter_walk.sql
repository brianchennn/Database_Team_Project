drop table if exists batter_walk;
create table batter_walk(
select years,id,sum(BB) as BB, sum(HBP) as HBP
from batter_walk_per_game
group by years,id
);
ALTER TABLE batter_walk ADD PRIMARY KEY(years,id);