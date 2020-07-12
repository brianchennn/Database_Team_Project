select BH.*, BS.K, BW.BB, BW.HBP
from batter_hit_per_game as BH, batter_strikeout_per_game as BS, batter_walk_per_game as BW
where BH.g_id=BS.g_id
    and BS.g_id=BW.g_id
    and BH.id=BS.id
    and BS.id=BW.id