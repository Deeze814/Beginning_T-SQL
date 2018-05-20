--Case Pivot

SELECT YEAR(OrderDate) AS OrderYear,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 1 THEN TotalDue ELSE 0 END),0) AS Jan,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 2 THEN TotalDue ELSE 0 END),0) AS Feb,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 3 THEN TotalDue ELSE 0 END),0) AS Mar,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 4 THEN TotalDue ELSE 0 END),0) AS Apr,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 5 THEN TotalDue ELSE 0 END),0) AS May,    
	ROUND(SUM(CASE MONTH(OrderDate) WHEN 6 THEN TotalDue ELSE 0 END),0) AS Jun    
FROM Sales.SalesOrderHeader    
GROUP BY YEAR(OrderDate)    
ORDER BY OrderYear; 

select SUM(TotalDue)
from Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
 AND MONTH(OrderDate) = 1 --Jan

/******** NOTES *******************************************************************************************
--	We are using the SUM aggregation for each case statment evaluation (for each month).
	We go through the records and say, if you are month XX then we will add your record's 
	TotalDue value to the running total of that month/year combination's current value.

OrderYear	Jan				Feb			Mar			Apr			May			Jun
2011		0.00			0.00		0.00		0.00		567021.00	507096.00
2012		4458337.00		1649052.00	3336347.00	1871924.00	3452924.00	4610647.00
2013		2340062.00		2600219.00	3831606.00	2840711.00	3658085.00	5726265.00
2014		4798028.00		1478213.00	8097036.00	1985886.00	6006183.00	54151.00

**********************************************************************************************************/