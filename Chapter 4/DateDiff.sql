
SELECT 
	 OrderDate
	,GETDATE() AS CurrentDateTime
	,DATEDIFF(year, OrderDate, GETDATE()) AS YearDiff
	,DATEDIFF(month, OrderDate, GETDATE()) AS MonthDiff
	,DATEDIFF(d, OrderDate, GETDATE()) AS DayDiff
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN (43659,43714,60621);