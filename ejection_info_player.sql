/*球隊case 6*/
/*查詢某球員的所有ejection*/
/*以 Bryce Harper 為模板*/

select E.*
from ejections as E, player_names as P
where P.first_name like "Bryce%"
	and P.last_name like "Harper%"
	and P.id = E.player_id;
	
