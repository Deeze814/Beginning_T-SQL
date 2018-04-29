--Running Totals

SELECT
	SalesOrderID
	,CustomerID
	,TotalDue
	,SUM(TotalDue) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID) AS RunningTotal
FROM Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID;

/******** NOTES *******************************************************************************************
This query calculates the running total as we process each row per unique customer ID

Ex. --> Customer ID: 11000
Row 1(43793): 3756.989 + 0			= 3756.989
Row 2(51522): 2587.8769 + 3756.989	= 6344.8659
Row 3(57418): 2770.2682 + 6344.8659 = 9115.1341

SalesOrderID	CustomerID	TotalDue	RunningTotal
43793			11000		3756.989	3756.989
51522			11000		2587.8769	6344.8659
57418			11000		2770.2682	9115.1341
43767			11001		3729.364	3729.364
51493			11001		2674.0227	6403.3867
72773			11001		650.8008	7054.1875
43736			11002		3756.989	3756.989
51238			11002		2535.964	6292.953
53237			11002		2673.0613	8966.0143
43701			11003		3756.989	3756.989
51315			11003		2562.4508	6319.4398
57783			11003		2674.4757	8993.9155
43810			11004		3756.989	3756.989
51595			11004		2626.5408	6383.5298
57293			11004		2673.0613	9056.5911

**********************************************************************************************************/


SELECT
	SalesOrderID
	,CustomerID
	,TotalDue
	,SUM(TotalDue) OVER (PARTITION BY CustomerID
		 ORDER BY SalesOrderID
		 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS ReverseRunningTotal
FROM Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID;

/******** NOTES *******************************************************************************************
This query calculates the running total as we process each row per unique customer ID, but does it in reverse order

Ex. --> Customer ID: 11000
Row 1(43793): 9115.1341 - 0			= 9115.1341
Row 2(51522): 9115.1341 - 3756.989	= 5358.1451
Row 3(57418): 5358.1451 - 2587.8769 = 2770.2682

SalesOrderID	CustomerID	TotalDue	ReverseRunningTotal
43793			11000		3756.989	9115.1341
51522			11000		2587.8769	5358.1451
57418			11000		2770.2682	2770.2682
43767			11001		3729.364	7054.1875
51493			11001		2674.0227	3324.8235
72773			11001		650.8008	650.8008
43736			11002		3756.989	8966.0143
51238			11002		2535.964	5209.0253
53237			11002		2673.0613	2673.0613
43701			11003		3756.989	8993.9155
51315			11003		2562.4508	5236.9265
57783			11003		2674.4757	2674.4757
43810			11004		3756.989	9056.5911
51595			11004		2626.5408	5299.6021
57293			11004		2673.0613	2673.0613

**********************************************************************************************************/