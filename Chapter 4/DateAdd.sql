SELECT
	CONVERT(DATE,OrderDate) AS OrderDate,
	CONVERT(DATE,DATEADD(YEAR,1,OrderDate)) AS OneMoreYear,
	CONVERT(DATE,DATEADD(MONTH,1,OrderDate)) AS OneMoreMonth,
	CONVERT(DATE,DATEADD(DAY,-1,OrderDate)) AS OneLessDay
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN (43659, 43714, 60621)

/*

OrderDate		OneMoreYear		OneMoreMonth	OneLessDay
2011-05-31		2012-05-31		2011-06-30		2011-05-30
2011-06-04		2012-06-04		2011-07-04		2011-06-03
2013-11-21		2014-11-21		2013-12-21		2013-11-20

*/

SELECT CONVERT(DATE,DATEADD(MONTH,1,'02/25/2018')) as OneToFebDate;

/*
OneToFebDate
2018-03-25
*/