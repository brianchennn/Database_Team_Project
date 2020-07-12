/*打者每場打席數*/
drop table if exists batter_atbat_num_per_game;
create table batter_atbat_num_per_game(
select SUBSTRING(A.ab_id, 1, 4) as years, PL.id, PL.first_name, PL.last_name, A.g_id, count(*) as PA
from atbats as A, player_names as PL
where A.batter_id = PL.id 
group by years, PL.id, A.g_id);
ALTER table batter_atbat_num_per_game add primary key(g_id,id);