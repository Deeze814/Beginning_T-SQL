--Partitioning window functions

--Ranking function with a partition
SELECT 
	SalesOrderID
	,CONVERT(DATE, OrderDate) AS OrderDate --Trimming time with convert
	,CustomerID
	,ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RowNum
FROM Sales.SalesOrderHeader
ORDER BY  CustomerID;

/******** NOTES *******************************************************************************************
This query results in the ranking function results being partitioned out by the customer ID.
This means that the RowNum value wills start at 1 for each customer ID value.
It then compares all of the OrderDate values of that customer to see which date is first.
It then assigns the RowNum value based on the date value ASC.


SalesOrderID	OrderDate		CustomerID	RowNum
43793			2011-06-21		11000		1
51522			2013-06-20		11000		2
57418			2013-10-03		11000		3
43767			2011-06-17		11001		1
51493			2013-06-18		11001		2
72773			2014-05-12		11001		3
43736			2011-06-09		11002		1
51238			2013-06-02		11002		2
53237			2013-07-26		11002		3
43701			2011-05-31		11003		1
51315			2013-06-07		11003		2
57783			2013-10-10		11003		3
43810			2011-06-25		11004		1
51595			2013-06-24		11004		2


**********************************************************************************************************/

