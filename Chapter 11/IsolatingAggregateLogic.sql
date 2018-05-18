/****** Isolating Aggregate Logic *************/
--Correlated Sub-queries

--1
SELECT
	c.CustomerID
	,c.StoreID
	,c.AccountNumber
	,(SELECT COUNT(SalesOrderID)
	  FROM Sales.SalesOrderHeader soh
	  WHERE soh.CustomerID = c.CustomerID) AS CountOfSales
FROM Sales.Customer c
ORDER BY CountOfSales;

/******** NOTES *******************************************************************************************
This query is not that bad in terms of performance since we have limited the select list to having just one
correlated subquery. WE have also ensured that only one value is returned from the correlated subquery per
row in the outer select statement.

**********************************************************************************************************/
SET STATISTICS IO ON;
SELECT
	c.CustomerID
	,c.StoreID
	,c.AccountNumber
	,(SELECT COUNT(SalesOrderID)
	  FROM Sales.SalesOrderHeader soh
	  WHERE soh.CustomerID = c.CustomerID) AS CountOfSales
	,(SELECT SUM(TotalDue)
	  FROM Sales.SalesOrderHeader soh
	  WHERE soh.CustomerID = c.CustomerID) AS SumOfTotalDue
	,(SELECT AVG(TotalDue)
	  FROM Sales.SalesOrderHeader soh
	  WHERE soh.CustomerID = c.CustomerID) AS AvgOfTotalDue
FROM Sales.Customer c
ORDER BY CountOfSales;

/******** NOTES *******************************************************************************************
The correlated subquery (CountOfSales, SumOfTotalDue, AvgOfTotalDue) all ran once a piece for each record in
the outer query.
This means that if the outer select returns 19820, each of those correlated subqueries ran 19820 times apeice 

**********************************************************************************************************/


--Derived Tables
--1
SELECT 
	c.CustomerID
	,c.StoreID
	,c.AccountNumber
	,s.CountOfSales
	,s.SumOfTotalDue
	,s.AvgOfTotalDue
FROM Sales.Customer c
JOIN (SELECT
		CustomerID
		,COUNT(SalesOrderID) AS CountOfSales
		,SUM(TotalDue) AS SumOfTotalDue
		,AVG(TotalDue) AS AvgOfTotalDue
	  FROM Sales.SalesOrderHeader soh
	  GROUP BY soh.CustomerID) AS s ON c.CustomerID = s.CustomerID;

/******** NOTES *******************************************************************************************
This technique is much more performant when combining multiple aggregate functions than its correlated 
subqueries counterpart.

**********************************************************************************************************/

--Using CROSS APPLY and OUTER APPLY

--1    
SELECT 
	soh.CustomerID
	,soh.OrderDate
	,soh.TotalDue
	,crt.RunningTotal     
FROM Sales.SalesOrderHeader soh     
CROSS APPLY(        
	SELECT 
		SUM(TotalDue) AS RunningTotal            
	FROM Sales.SalesOrderHeader rt            
	WHERE rt.CustomerID = soh.CustomerID                
		AND rt.SalesOrderID <= SOH.SalesOrderID) crt    
	ORDER BY soh.CustomerID, soh.SalesOrderID;      


/******** NOTES *******************************************************************************************
--Query 1: The inner query joins to the outer query on the CustomerID and the OrderID where the ORderID is less 
		   than or equal to the OrderID of the outer query.The inner query will run once for every record in the
		   outer query.
		   Since this is being used to calculate a running total, you could use the SQL Server 2012 and onward
		   'Window Framing' to achieve this with better performance.

**********************************************************************************************************/