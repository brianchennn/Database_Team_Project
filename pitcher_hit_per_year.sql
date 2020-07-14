drop table if exists pitcher_hit_per_year;
create table pitcher_hit_per_year(
select years ,
    id, 
    first_name,last_name,
    g_id, 
    sum(Single) as Single, 
    sum(DDouble) as DDouble, 
    sum(Triple) as Triple,
    sum(HR) as HR
from pitcher_hit 
group by years , id
);
alter table pitcher_hit_per_year add primary key(years,id);