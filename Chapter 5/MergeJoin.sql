/* Be sure to turn on execution plan */

--Merge join
SELECT
	soh.SalesOrderID
	,sod.OrderQty
	,sod.ProductID
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID;