--Cartesian Product
SELECT
	soh.SalesOrderID
	,soh.OrderDate
	,soh.TotalDue
	,sod.SalesOrderDetailID
	,sod.ProductID
	,sod.OrderQty
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON 1 = 1;

--Left Join
SELECT 
	c.CustomerID
	,soh.SalesOrderID
	,soh.OrderDate
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4);

--Right Join
SELECT 
	c.CustomerID
	,soh.SalesOrderID
	,soh.OrderDate
FROM Sales.SalesOrderHeader soh  
RIGHT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID 
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4);