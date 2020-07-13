drop table if exists batter_strikeout;
create table batter_strikeout(
select years,id,sum(K) as K
from batter_strikeout_per_game as BHPG
group by years,id
);
ALTER TABLE batter_strikeout ADD PRIMARY KEY(years,id);