drop table if exists batter_PA;
create table batter_PA(select substring(A.ab_id,1,4) as years, A.batter_id as id, PL.first_name, PL.last_name, count(*) as PA
from atbats as A,player_names as PL
where A.batter_id = PL.id
group by years, batter_id

);
alter table batter_PA add primary key(years,id);