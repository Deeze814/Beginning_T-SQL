--Propagating the LEFT JOIN to preserve NULL values
SELECT
	c.CustomerID
	,soh.SalesOrderID
	,sod.SalesOrderDetailID
	,sod.ProductID
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4); --16 rows with NULL values from [soh] being preserved

--Not propagating the NULL VALUES
SELECT
	c.CustomerID
	,soh.SalesOrderID
	,sod.SalesOrderDetailID
	,sod.ProductID
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4); --12 rows with NULL values from [soh] being lost