/* Be sure to turn on execution plan */

--Hash Match
SELECT
	c.CustomerID
	,soh.TotalDue
FROM Sales.Customer c 
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID;