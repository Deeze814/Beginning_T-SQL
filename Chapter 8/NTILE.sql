--NTILE ranking function

SELECT 
	vsp.FirstName
	,vsp.LastName
	,SUM(soh.TotalDue) AS TotalSales
	,NTILE(4) OVER(ORDER BY SUM(soh.TotalDue)) AS Bucket
FROM Sales.vSalesPerson vsp --view
JOIN Sales.SalesOrderHeader soh ON vsp.BusinessEntityID = soh.SalesPersonID
WHERE soh.OrderDate >= '2011-01-01'
	AND soh.OrderDate < '2012-01-01'
GROUP BY vsp.FirstName, vsp.LastName
ORDER BY TotalSales;

/******** NOTES *******************************************************************************************
This query divides people into four buckes based on 2011 sales.
The people with the highest sales end up in bucket 4.
The peopole with the lowest sales end up in bucket 1.

FirstName	LastName		TotalSales		Bucket
Stephen		Jiang			32567.9155		1
Garrett		Vargas			563326.5478		1
David		Campbell		675663.694		1
Pamela		Ansman-Wolfe	730273.4889		2
Michael		Blythe			986298.0902		2
Shu			Ito				1089874.3906	2
Linda		Mitchell		1294819.7439	3
José		Saraiva			1323328.6346	3
Jillian		Carson			1477158.2811	4
Tsvi		Reiter			1713640.8372	4

**********************************************************************************************************/

SELECT 
	vsp.FirstName
	,vsp.LastName
	,SUM(soh.TotalDue) AS TotalSales
	,NTILE(4) OVER(ORDER BY SUM(soh.TotalDue)) * 1000 Bonus
FROM Sales.vSalesPerson vsp --view
JOIN Sales.SalesOrderHeader soh ON vsp.BusinessEntityID = soh.SalesPersonID
WHERE soh.OrderDate >= '2011-01-01'
	AND soh.OrderDate < '2012-01-01'
GROUP BY vsp.FirstName, vsp.LastName
ORDER BY TotalSales;

/******** NOTES *******************************************************************************************
Same as the first query, only it multiples the NTILE bucket value by 1000 for this made up bonus value.

FirstName	LastName		TotalSales		Bonus
Stephen		Jiang			32567.9155		1000
Garrett		Vargas			563326.5478		1000
David		Campbell		675663.694		1000
Pamela		Ansman-Wolfe	730273.4889		2000
Michael		Blythe			986298.0902		2000
Shu			Ito				1089874.3906	2000
Linda		Mitchell		1294819.7439	3000
José		Saraiva			1323328.6346	3000
Jillian		Carson			1477158.2811	4000
Tsvi		Reiter			1713640.8372	4000

**********************************************************************************************************/