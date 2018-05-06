--Window Aggregates being less performant than traditional SQL
/**** TURN EXECUTION PLAN ON ****/
SET STATISTICS IO ON;

--1 Window Aggregate
SELECT 
	CustomerID
	,SalesOrderID
	,TotalDue
	,SUM(TotalDue) OVER(PARTITION BY CustomerID) AS CustTotal
FROM Sales.SalesOrderHeader;

--2 Traditional SQL (Non-window aggregate)
WITH cteTotal AS
(
	SELECT 
		CustomerID
		,SUM(TotalDue) AS CustTotal
	FROM Sales.SalesOrderHeader
	GROUP BY CustomerID
)
SELECT 
	cte.CustomerID
	,soh.SalesOrderID
	,soh.TotalDue
	,cte.CustTotal
FROM Sales.SalesOrderHeader soh
JOIN cteTotal cte ON soh.CustomerID = cte.CustomerID
ORDER BY CustomerID;

	


/******** NOTES *******************************************************************************************
--Query 1 (window aggregate) had 63% of the query cost

--I added an ORDER BY to Query 2 and now Query 2 has 51% of the overall execution cost.
--The book cites the fact that query 1 will always perform worse than query 2 even with the appropriate
  idexes, but its the fact that query 1 does an implicit sort based on window function usage. I confirmed
  this by adding an ORDER BY to query 2 and it gave the same results (number and order) as query 1 with
  query 1 becoming slightly more efficient. 

--Looking at the the STAT IO, when the ORDER BY is added to query 2, the logical reads are exactly the same

--Query 1 will always do a sort on the partitioned by column since that is implicit functionality for 
  window aggregates. If you do not need to sort, then use the CTE. If you do need to sort, either way
  is applicable. 
**********************************************************************************************************/