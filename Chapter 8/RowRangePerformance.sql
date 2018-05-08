--Detailing ROWS better performance over RANGE

SET STATISTICS IO ON;
GO

--Using RANGE (it is the default)
SELECT
	SalesOrderID
	,TotalDue
	,CustomerID
	,SUM(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM Sales.SalesOrderHeader;

--Using ROWS
SELECT
	SalesOrderID
	,TotalDue
	,CustomerID
	,SUM(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Sales.SalesOrderHeader;

/******** NOTES *******************************************************************************************
--Looking at the below Stat IO results, we can see the calculations having to be done in the 'Worktable' via
the amount of logical reads is substantially higher for the query using RANGE than the query using ROWS.


(31465 rows affected)
Table 'Worktable'. Scan count 50525, logical reads 188673, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'SalesOrderHeader'. Scan count 1, logical reads 689, physical reads 3, read-ahead reads 685, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(31465 rows affected)
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'SalesOrderHeader'. Scan count 1, logical reads 689, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

**********************************************************************************************************/