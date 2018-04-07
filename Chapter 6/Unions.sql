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