drop table if exists batter_hit;
create table batter_hit(
select years,id,sum(Single) as Single,sum(DDouble) as DDouble, sum(Triple) as Triple,sum(HR) as HR
from batter_hit_per_game as BHPG
group by years,id
);
ALTER TABLE batter_hit ADD PRIMARY KEY(years,id);