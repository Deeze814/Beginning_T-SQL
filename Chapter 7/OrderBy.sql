--Displays results in order of the non-aggregated column that is listed in the GROUP BY clause
SELECT
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID;

--Displays results in order of the maximum order per customer (an expression not even listed in the SELECT list -- MAX())
SELECT
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY MAX(TotalDue) DESC;

--Shows a shorcut for the aggregate, if you want to sort by one of the aggregate expressions in the select list,
-- you can list the aggregate column alias instead of the expression.
SELECT
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalPerCustomer DESC;

--Comparing the top 2 results from Query 2 & 3
SELECT TOP(1)
	CustomerID
	,SUM(TotalDue) AS [MAX TotalPerCustomer]
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY MAX(TotalDue) DESC;

SELECT TOP(1)
	CustomerID
	,SUM(TotalDue) AS [SUM TotalPerCustomer]
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY [SUM TotalPerCustomer] DESC;

SELECT 
	SalesOrderID
	,CustomerID
	,TotalDue
FROM Sales.SalesOrderHeader WHERE CustomerID IN (29641,29818);

SELECT 
	CustomerID
	,MAX(TotalDue) AS MaxTotalDue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY MAX(TotalDue) DESC; --Shows 29641 has the highest single charge of 187487.825, while 29818 has the highest summed charge total.
