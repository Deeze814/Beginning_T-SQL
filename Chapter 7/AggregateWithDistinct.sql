--Looking at the table we are operating on
SELECT * FROM Sales.SalesOrderHeader; --31465
SELECT * FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NULL; --27659
--3806 rows with non NULL value for SalesPersonID

--Shows the breakdown of each aggregate operation on the table, valdiates the above results
SELECT
	COUNT(*) AS CountOfRows
	,COUNT(SalesPersonID) AS CountOfSalesPeople
	,COUNT(DISTINCT SalesPersonID) AS CountOfUniqueSalesPeople
FROM Sales.SalesOrderHeader;
/*
CountOfRows	CountOfSalesPeople	CountOfUniqueSalesPeople
31465		3806				17

--NOTE the message tab:
Warning: Null value is eliminated by an aggregate or other SET operation.
*/


--The below query is another application of the DISTINCT keyword in an aggregate function
SELECT
	SUM(TotalDue) AS TotalOfAllOrders
	,SUM(DISTINCT TotalDue) AS TotalOfDistinctTotalDue
FROM Sales.SalesOrderHeader; 
/*
TotalOfAllOrders	TotalOfDistinctTotalDue
123216786.1159		91735344.3814

TotalOfAllOrders -> The sum of TotalDue for all rows in the table
TotalOfDistinctTotalDue -> The sum of UNIQUE TotalDue values in the table

*/