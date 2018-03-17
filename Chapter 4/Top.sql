--Top 2% based on SalesOrderID 
DECLARE @Rows INT = 2;
SELECT TOP(@Rows) PERCENT
	CustomerID
	,OrderDate
	,SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID;

--Top 2 records based on SalesOrderID
SELECT TOP(2) 
	CustomerID
	,OrderDate
	,SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID;

--Top 2 records based on OrderDate, but including identical records
SELECT TOP(2) WITH TIES
	CustomerID
	,OrderDate
	,SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY OrderDate; --43 rows instead of just 2 (43 orders placed on 5/31/2011)

--Get 2 random records
SELECT TOP(2) 
	CustomerID
	,OrderDate
	,SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY NEWID();
