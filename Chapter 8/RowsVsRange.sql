--ROWS vs RANGE 

--
SELECT 
	SalesOrderID
	,CONVERT(DATE, OrderDate) AS OrderDate --Trimming time with convert
	,CustomerID
	,TotalDue
	,SUM(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ROWS_RT
	,SUM(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate
		RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RANGE_RT
FROM Sales.SalesOrderHeader
WHERE CustomerID = 29837;

/******** NOTES *******************************************************************************************
Notice that for OrderDate 2013-05-30, there are two orders on that date.
ROWS treats each order record for that date as different records and gives the correct running total 
RANGE treats each record as the same and thus shows the overall total for both rows in the window 

SalesOrderID	OrderDate		CustomerID	TotalDue	ROWS_RT		RANGE_RT
51170			2013-05-30		29837		4190.3125	4190.3125	8414.8269
51171			2013-05-30		29837		4224.5144	8414.8269	8414.8269
55306			2013-08-30		29837		1153.8016	9568.6285	11399.1962
55320			2013-08-30		29837		1830.5677	11399.1962	11399.1962
61252			2013-11-30		29837		419.7041	11818.9003	12441.8471
61262			2013-11-30		29837		622.9468	12441.8471	12441.8471
67203			2014-02-28		29837		2746.7906	15188.6377	15188.6377
67323			2014-03-01		29837		2036.9284	17225.5661	17225.5661


**********************************************************************************************************/