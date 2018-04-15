--Query 1
SELECT
	c.CustomerID
	,c.AccountNumber
	,COUNT(*) AS CountOfOrders
	,SUM(TotalDue) AS SumOfTotalDue
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, c.AccountNumber
ORDER BY c.CustomerID;

--Query 2
SELECT
	c.CustomerID
	,c.AccountNumber
	,COUNT(*) AS CountOfOrders
	,SUM(TotalDue) AS SumOfTotalDue
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, c.AccountNumber
ORDER BY c.CustomerID;

--Query 3
SELECT
	c.CustomerID
	,c.AccountNumber
	,COUNT(SalesOrderID) AS CountOfOrders
	,SUM(COALESCE(TotalDue, 0)) AS SumOfTotalDue
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, c.AccountNumber
ORDER BY c.CustomerID;

/********************************************* NOTES *********************************************
Query 1 includes only customers who have placed orders since we do an (inner) JOIN to Sales.SalesOrderHeader.

Query 2 includes all customers (via the Left Join to soh), but incorrectly returns a count of 1 for
customers with no orders and returns a NULL for the SumOfTotalDue. A value of 0 would probably be 
better than NULL for SumOfTotalDue.

Query 3 rectifies the issues with 1&2 by: 
	(1) Changing COUNT(*) to COUNT(SalesOrderID), which will elminates the NULL values and correctly returns
		0 for those customers who have not placed an order

	(2) The second problem of showing NULL for SumOfTotalDue for customers without an order is solved by using
		the COALESCE to set a value of 0 when the value of the SUM aggregation is NULL


*************************************************************************************************/