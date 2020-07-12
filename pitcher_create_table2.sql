/*整合了pitcher_create_table, pitch_type_per_game*/
drop table if exists pitcher_create_table2;
create table pitcher_create_table2(
select A.*,  B.FF,B.CH,B.EP,B.FC,B.CU,B.PO,B.FS,B.FT,B.IN,B.KC,B.KN,B.SC,B.SI,B.SL,B.UN
from pitcher_create_table as A, pitch_type_per_game as B
where A.g_id=B.g_id and A.id=B.id
);