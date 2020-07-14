drop table if exists batter_create_table_per_game;
create table batter_create_table_per_game(
select BH.*, BS.K, BW.BB, BW.HBP, BI.IBB, BP.DP as GDP,BSF.SF
from batter_hit_per_game as BH, 
     batter_strikeout_per_game as BS, 
     batter_walk_per_game as BW,
     batter_IBB_per_game as BI,
     batter_DP_per_game as BP,
     batter_SF_per_game as BSF
where BH.g_id=BS.g_id
    and BS.g_id=BW.g_id
    and BW.g_id=BI.g_id
    and BI.g_id=BP.g_id
    and BP.g_id=BSF.g_id
    and BH.id=BS.id
    and BS.id=BW.id
    and BW.id=BI.id
    and BI.id=BP.id
    and BP.id=BSF.id
);
