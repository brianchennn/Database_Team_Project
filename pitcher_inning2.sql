
SELECT T1.rowid,T2.rowid,T1.g_id, T1.ab_id, T1.pitcher_id, T1.o
FROM
    (SELECT 
        @rowid:=@rowid+1 as rowid ,a.g_id, a.ab_id, a.pitcher_id, a.o
    FROM
        atbats AS a,(SELECT @rowid := 0) as ini
	) as T1,
    (SELECT 
        @rowid:=@rowid+1 as rowid ,a.g_id, a.ab_id, a.pitcher_id, a.o
    FROM
        atbats AS a,(SELECT @rowid := 0) as ini
	) as T2
WHERE T1.rowid=T2.rowid+1 and T1.pitcher_id=T2.pitcher_id

