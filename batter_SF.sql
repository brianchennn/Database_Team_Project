drop table if exists batter_SF;
create table batter_SF(
select years,id,sum(SF) as SF
from batter_SF_per_game
group by years,id
);
ALTER TABLE batter_SF ADD PRIMARY KEY(years,id);