drop table if exists batter_create_table_per_game2;
create table batter_create_table_per_game2(
select T.years, 
       T.id,T.first_name, 
       T.last_name, 
       T.g_id, 
       A.PA, 
       B.AB, 
       T.Single, 
       T.DDouble, 
       T.Triple,
       T.HR, 
       T.K, 
       T.BB, 
       T.HBP, 
       T.IBB,
       T.SF, 
       T.GDP,
       date_format(G.date,"%Y%m%d")
from   batter_create_table_per_game as T, 
       batter_PA_per_game as A, 
       batter_AB_per_game as B,
       games as G
where T.g_id=A.g_id and
      A.g_id=B.g_id and
      B.g_id=G.g_id and
      T.id=A.id AND
      A.id=B.id
);
--  select * from batter_create_table_per_game2 limit 10;