drop table batter_create_table_per_game;
create table batter_create_table_per_game(
select BH.*, BS.K, BW.BB, BW.HBP, BP.DP as GDP
from batter_hit_per_game as BH, batter_strikeout_per_game as BS, batter_walk_per_game as BW,
     batter_DP_per_game as BP
where BH.g_id=BS.g_id
    and BS.g_id=BW.g_id
    and BW.g_id=BP.g_id
    and BH.id=BS.id
    and BS.id=BW.id
    and BW.id=BP.id
);