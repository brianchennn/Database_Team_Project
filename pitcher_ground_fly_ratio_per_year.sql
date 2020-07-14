drop table if exists pitcher_ground_fly_ratio_per_year;
create table pitcher_ground_fly_ratio_per_year(
select years,
    id, 
    first_name,last_name,
    g_id, 
    sum(Ground) as Ground,
    sum(Fly) as Fly,
    Ground/Fly as ground_fly_ratio 
from pitcher_ground_fly_ratio 
group by years , id
);
alter table pitcher_ground_fly_ratio_per_year add primary key(years,id);