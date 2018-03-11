--Using Datepart to get the numeric parts of the date
SELECT
	 CONVERT(DATE, OrderDate) AS OrderDate --Trimming time with convert
	,DATEPART(year, OrderDate) AS OrderYear
	,DATEPART(m, OrderDate) AS OrderMonth
	,DATEPART(day, OrderDate) AS OrderDay
	,DATEPART(weekday, OrderDate) AS OrderWeekDay
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN (43659, 43714, 60621);
/*
OrderDate	OrderYear	OrderMonth	OrderDay	OrderWeekDay
2011-05-31	2011		5			31			3
2011-06-04	2011		6			4			7
2013-11-21	2013		11			21			5
*/

--Using DateName to get english text representing parts of the date
SELECT
	 CONVERT(DATE, OrderDate) AS OrderDate --Trimming time with convert
	,DATENAME(year, OrderDate) AS OrderYear
	,DATENAME(m, OrderDate) AS OrderMonth
	,DATENAME(day, OrderDate) AS OrderDay
	,DATENAME(weekday, OrderDate) AS OrderWeekDay
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN (43659, 43714, 60621);
/*
OrderDate	OrderYear	OrderMonth	OrderDay	OrderWeekDay
2011-05-31	2011		May			31			Tuesday
2011-06-04	2011		June		4			Saturday
2013-11-21	2013		November	21			Thursday
*/