SELECT
	EOMONTH(GETDATE()) AS [End of this month]
	,EOMONTH(GETDATE(), 1) AS [End of next month]
	,EOMONTH('2017-08-14') AS [Last August];

/*    Ran on 3/13/2018

End of this month	End of next month	Last August
2018-03-31	2		2018-04-30			2017-08-31
*/