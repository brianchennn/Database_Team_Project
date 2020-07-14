drop table if exists pitcher_inning_per_year;
create table pitcher_inning_per_year(
select years,
       id, 
       first_name, 
       last_name, 
       sum(IP) as IP
from pitcher_inning 
group by years,id
);
alter table pitcher_inning_per_year add primary key(years,id);    