drop table if exists pitcher_DP_per_year;
create table pitcher_DP_per_year(
select years ,
    id, 
    first_name,last_name,
    g_id, 
    sum(DP) as DP
from pitcher_DP 
group by years , id
);
alter table pitcher_DP_per_year add primary key(years,id);