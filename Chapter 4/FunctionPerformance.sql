--Creating a new non-clustered index to show how a DIRECT COMPARISON can benefit from the index whereas a function's execution does not
IF EXISTS(SELECT NULL FROM SYS.INDEXES WHERE object_id = OBJECT_ID(N'[Sales].[SalesOrderHeader]') AND name = N'DEMO_SalesOrderHeader_OrderDate')
BEGIN
	DROP INDEX [DEMO_SalesOrderHeader_OrderDate] ON [Sales].[SalesOrderHeader] WITH (ONLINE = OFF);
END;
GO

CREATE NONCLUSTERED INDEX [DEMO_SalesOrderHeader_OrderDate] ON [Sales].[SalesOrderHeader] ([OrderDate] ASC);


/**** Be sure to turn on the execution plan on the above tool bar *****/

--DIRECT COMPARISON, with non-clustered index
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2011-01-01 00:00:00'
  AND OrderDate < '2012-01-01 00:00:00'; --Index Seek (NonClustered), 7% Query Cost

--Function, with non-clustered index
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011; --Index Scan (NonClustered)

--DROP the index and now run the same query and see how both queries perform similarly 
IF EXISTS(SELECT NULL FROM SYS.INDEXES WHERE object_id = OBJECT_ID(N'[Sales].[SalesOrderHeader]') AND name = N'DEMO_SalesOrderHeader_OrderDate')
BEGIN
	DROP INDEX [DEMO_SalesOrderHeader_OrderDate] ON [Sales].[SalesOrderHeader] WITH (ONLINE = OFF);
END;
GO

--DIRECT COMPARISON, without non-clustered index
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2011-01-01 00:00:00'
  AND OrderDate < '2012-01-01 00:00:00'; --Index Scan (Clustered), 50% Query Cost

--Function, without non-clustered index
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011; --Index Scan (Clustered), 50% Query Cost