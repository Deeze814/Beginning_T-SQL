/***** Group by column *****/
SELECT 
	CustomerID
	,Sum(TotalDue)
FROM SALES.SalesOrderHeader
GROUP BY CustomerID;

SELECT 
	TerritoryID
	,AVG(TotalDue) AS AveragePerTerritory
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID;


/***** Group by expression *****/
SELECT
	COUNT(*) AS CountOfOrders
	,YEAR(OrderDate) AS OrderDate
FROM Sales.SalesOrderHeader
GROUP BY OrderDate; --Returns muliple rows for the same years since the grouping is done on OrderDate

SELECT
	COUNT(*) AS CountOfOrders
	,YEAR(OrderDate) AS OrderDate
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate); --Returns the expected count of orders per year as a single record per year.