drop table if exists batter_AB;
create table batter_AB(
SELECT years,id,first_name,last_name, g_id, sum(AB) as AB
from batter_AB_per_game
group by years,id
);
alter table batter_AB add primary key(years,id);