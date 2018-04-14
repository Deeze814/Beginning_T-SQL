--Gets customers that have an aggregate total exceeding 5,000
SELECT 
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING SUM(TotalDue) > 5000;

--Gets customers that have an aggregate total execeeding 5,000 and have exactly 10 orders.
SELECT 
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING COUNT(CustomerID) = 10 AND SUM(TotalDue) > 5000;

	--To see the customer have exactly 10 orders (rows)
	SELECT 
		CustomerID
	FROM Sales.SalesOrderHeader 
	WHERE CustomerID = 29830;

--This HAVING is filtering on a non-aggregated column (CustomerID), which is valid
SELECT 
	CustomerID
	,SUM(TotalDue) AS TotalPerCustomer
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING CustomerID > 27858;

	--Since the CustomerID is an non-aggregated column, you can move this to the WHERE clause.
	SELECT 
		CustomerID
		,SUM(TotalDue) AS TotalPerCustomer
	FROM Sales.SalesOrderHeader 
	WHERE CustomerID > 27858
	GROUP BY CustomerID;
