/*球隊case 5*/
/*每年度所有隊伍的ejection次數*/
/*若某年某隊伍的ejection次數為0的話則不會顯示於表中*/
CREATE TABLE ejection_team select temp.year, temp.team, count(*) as cnt
from (
	select substring_index(E.date, "/", -1) as year, E.team
	from ejections as E) as temp
group by temp.year, temp.team;
	
