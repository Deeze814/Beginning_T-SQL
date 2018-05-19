--Grouping Sets

--Query 1: Showing the syntax when using a UNION
SELECT 
	NULL AS SalesOrderID
	,SUM(UnitPrice) AS SumOfPrice
	,ProductID    
FROM Sales.SalesOrderDetail    
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY ProductID    

UNION ALL    

SELECT 
	SalesOrderID
	,SUM(UnitPrice)
	,NULL     
FROM Sales.SalesOrderDetail    
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY SalesOrderID;       

--Query 2: Same results using GROUPING SETS
SELECT 
	SalesOrderID
	,SUM(UnitPrice) AS SumOfPrice
	,ProductID    
FROM Sales.SalesOrderDetail     
WHERE SalesOrderID BETWEEN 44175 AND 44178    
GROUP BY GROUPING SETS(SalesOrderID, ProductID);   


/******** NOTES *******************************************************************************************
Query 1: We want to get the summation of the UnitPrice of SalesOrderID BETWEEN 44175 AND 44178.
		 We want it grouped by SalesOrderID and ProductID.
SalesOrderID	SumOfPrice	ProductID
NULL			3578.27		751
NULL			3578.27		752
NULL			3578.27		753
NULL			3374.99		777
44175			3578.27		NULL
44176			3578.27		NULL
44177			3374.99		NULL
44178			3578.27		NULL

Query 2: Essentially will perform an aggregate query for all specified columns in the GROUPING SETS predicate.

Both produce the exact same execution plan

**********************************************************************************************************/