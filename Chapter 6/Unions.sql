--Using UNION
SELECT
	BusinessEntityID AS ID
FROM HumanResources.Employee
UNION
SELECT
	BusinessEntityID AS ID
FROM Person.Person
UNION
SELECT 
	SalesOrderID AS ID
FROM Sales.SalesOrderHeader
ORDER BY ID; --Only unique values returned

--Using UNION ALL
SELECT
	BusinessEntityID AS ID
FROM HumanResources.Employee
UNION ALL
SELECT
	BusinessEntityID AS ID
FROM Person.Person
UNION ALL
SELECT 
	SalesOrderID AS ID
FROM Sales.SalesOrderHeader
ORDER BY ID;--Contains duplicates



/************************************************************
	Comparison of UNION vs UNION ALL performance
	Note: Turn on execution plan to see the difference

	--Notice the extra step of a Hash Match being done by the
	  Union query so that it can remove duplicates
*************************************************************/
--Union
SELECT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID <= 59549
UNION
SELECT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID > 59549;

--Union All
SELECT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID <= 59549
UNION ALL
SELECT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID > 59549;

--Now attempting to see if having the UNION ALL get the bulk of the DATA and then runnig a DISTINCT will help out
WITH cteUnionAll
AS
(
	SELECT SalesOrderDetailID
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderDetailID <= 59549
	UNION ALL
	SELECT SalesOrderDetailID
	FROM Sales.SalesOrderDetail
	WHERE SalesOrderDetailID > 59549
)
SELECT DISTINCT SalesOrderDetailID 
FROM cteUnionAll; --Still does the Hash Match

--What if we say distinct on each query of the UNION ALL?
SELECT DISTINCT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID <= 59549
UNION ALL
SELECT DISTINCT SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID > 59549; --Even worse, now the optimizer will run a Hash Match on each query (which is redundant since its selecting primary keys values).
