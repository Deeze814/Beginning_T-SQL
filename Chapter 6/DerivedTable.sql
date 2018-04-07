--Derived Table
SELECT
	c.CustomerID
	,soh.SalesOrderID
FROM Sales.Customer c
JOIN (SELECT SalesOrderID, CustomerID		
	  FROM Sales.SalesOrderHeader) AS soh ON c.CustomerID = soh.CustomerID;	