--Pivot Function

--1
SELECT 
	OrderYear
	,[1] AS Jan
	,[2] AS Feb
	,[3] AS Mar
	,[4] AS Apr
	,[5] AS May
	,[6] AS Jun    
FROM (SELECT 
		YEAR(OrderDate) AS OrderYear
		,TotalDue
		,MONTH(OrderDate) AS OrderMonth        
FROM Sales.SalesOrderHeader) AS MonthData    
PIVOT 
(         
	SUM(TotalDue)        
	FOR OrderMonth IN ([1],[2],[3],[4],[5],[6]) --The derived table contains ONLY the columns and expressions needed by the pivoted query       
) AS PivotData    
ORDER BY OrderYear;       

--2    
SELECT 
	OrderYear --Grouping Column
	,ROUND(ISNULL([1],0),0) AS Jan --<pivotedValue1>
	,ROUND(ISNULL([2],0),0) AS Feb --<pivotedValue2>
	,ROUND(ISNULL([3],0),0) AS Mar --<pivotedValue3>
	,ROUND(ISNULL([4],0),0) AS Apr --<pivotedValue4>
	,ROUND(ISNULL([5],0),0) AS May --<pivotedValue5>
	,ROUND(ISNULL([6],0),0) AS Jun --<pivotedValue6>   
FROM (SELECT 
		YEAR(OrderDate) AS OrderYear --<grouping column>
		,TotalDue	--<value column>
		,MONTH(OrderDate) AS OrderMonth --<pivoted column>        
FROM Sales.SalesOrderHeader) AS MonthData    
PIVOT 
(         
	SUM(TotalDue)        
	FOR OrderMonth IN ([1],[2],[3],[4],[5],[6])--The derived table contains ONLY the columns and expressions needed by the pivoted query               
) AS PivotData     
ORDER BY OrderYear;  

/******** NOTES *******************************************************************************************


**********************************************************************************************************/