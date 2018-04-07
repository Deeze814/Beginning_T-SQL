--CTE without specifying column names
WITH cteOrder 
AS
(
	SELECT
		SalesOrderID
		,CustomerID
		,TotalDue + Freight AS Total
	FROM Sales.SalesOrderHeader 
)
SELECT
	c.CustomerID
	,cte.SalesOrderID
	,cte.Total
FROM Sales.Customer C
JOIN cteOrder cte ON c.CustomerID = cte.CustomerID;

--CTE with column names specified
WITH cteOrder ([Order ID], [Customer ID], Total)
AS
(
	SELECT
		SalesOrderID
		,CustomerID
		,TotalDue + Freight AS Total
	FROM Sales.SalesOrderHeader 
)
SELECT
	c.CustomerID
	,cte.[Order ID]
	,cte.Total
FROM Sales.Customer C
JOIN cteOrder cte ON c.CustomerID = cte.[Customer ID];