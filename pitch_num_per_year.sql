drop table if exists pitch_num_per_year;
create table pitch_num_per_year(
select  years, 
        id, first_name, 
        last_name, 
        g_id, 
        sum(Pitch_per_Game)  as pitch_per_year ,
        sum(IP) as IP
from pitch_num_per_game
group by years,id
);
alter table  pitch_num_per_year add primary key(years,id);