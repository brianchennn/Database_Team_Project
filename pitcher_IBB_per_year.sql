drop table if exists pitcher_IBB_per_year;
create table pitcher_IBB_per_year(
select years,
    id, 
    first_name,last_name,
    sum(IBB) as IBB
from pitcher_IBB_per_game 
group by years,id
);
alter table pitcher_IBB_per_year add primary key(years,id); 