drop table if exists pitcher_strikeout_per_year;
create table pitcher_strikeout_per_year(
select years,
    id, 
    first_name,last_name,
    g_id, 
    sum(K) as K
from pitcher_strikeout
group by years , id
);
alter table pitcher_strikeout_per_year add primary key(years,id);