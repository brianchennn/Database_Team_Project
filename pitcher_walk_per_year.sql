drop table if exists pitcher_walk_per_year;
create table pitcher_walk_per_year(
select years,
    id, 
    first_name,last_name,
    g_id, 
    sum(BB) as BB,
    sum(HBP) as HBP
from pitcher_walk
group by years , id
);
alter table pitcher_walk_per_year add primary key(years,id);