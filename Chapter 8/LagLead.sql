--LAG and LEAD

--1
SELECT 
	SalesOrderID
	,CONVERT(DATE, OrderDate) AS OrderDate
	,CustomerID
	,LAG(CONVERT(DATE, OrderDate)) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID) AS PrevOrderDate
	,LEAD(CONVERT(DATE, OrderDate)) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID) AS FollowingOrderDate
FROM Sales.SalesOrderHeader;

/******** NOTES *******************************************************************************************
This query shows the lag and lead functions working in the context of a partition.

SalesOrderID	OrderDate	CustomerID	PrevOrderDate	FollowingOrderDate
43793			2011-06-21	11000		NULL			2013-06-20
51522			2013-06-20	11000		2011-06-21		2013-10-03
57418			2013-10-03	11000		2013-06-20		NULL
43767			2011-06-17	11001		NULL			2013-06-18
51493			2013-06-18	11001		2011-06-17		2014-05-12
72773			2014-05-12	11001		2013-06-18		NULL
43736			2011-06-09	11002		NULL			2013-06-02
51238			2013-06-02	11002		2011-06-09		2013-07-26
53237			2013-07-26	11002		2013-06-02		NULL
43701			2011-05-31	11003		NULL			2013-06-07
51315			2013-06-07	11003		2011-05-31		2013-10-10
57783			2013-10-10	11003		2013-06-07		NULL
43810			2011-06-25	11004		NULL			2013-06-24
51595			2013-06-24	11004		2011-06-25		2013-10-01

**********************************************************************************************************/


--2
SELECT
	SalesOrderID
	,CONVERT(DATE, OrderDate) AS OrderDate
	,CustomerID
	,DATEDIFF(D,LAG(OrderDate,1,OrderDate)
			OVER(PARTITION BY CustomerID ORDER BY SalesOrderID),OrderDate) AS DaysSinceLastOrder
FROM Sales.SalesOrderHeader;


/******** NOTES *******************************************************************************************
Shows how the Lag function can be used in the context of another function to generate unique information.

SalesOrderID	OrderDate	CustomerID	DaysSinceLastOrder
43793			2011-06-21	11000		0
51522			2013-06-20	11000		730
57418			2013-10-03	11000		105
43767			2011-06-17	11001		0
51493			2013-06-18	11001		732
72773			2014-05-12	11001		328
43736			2011-06-09	11002		0
51238			2013-06-02	11002		724
53237			2013-07-26	11002		54
43701			2011-05-31	11003		0
51315			2013-06-07	11003		738
57783			2013-10-10	11003		125
43810			2011-06-25	11004		0
51595			2013-06-24	11004		730

**********************************************************************************************************/