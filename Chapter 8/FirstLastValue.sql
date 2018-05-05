--FIRST_VALUE and LAST_VALUE

--Using FIRST_VALUE and LAST_VALUE to find first/last occurences of an element
SELECT
	SalesOrderID
	,CONVERT(DATE, OrderDate) AS OrderDate
	,CustomerID
	,FIRST_VALUE(CONVERT(DATE, OrderDate)) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID
		ROWS BETWEEN UNBOUNDED PRECEDING  AND CURRENT ROW) AS FirstOrderDate
	,LAST_VALUE(CONVERT(DATE, OrderDate)) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LastOrderDate
	,LAST_VALUE(CONVERT(DATE, OrderDate)) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID) AS DefaultFrame --No defined frame
FROM Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID;


/******** NOTES *******************************************************************************************
We are defining each frame to be each unique CustomerID and ordering each record for that customer by 
the SalesOrderID value.

**Note**
The column using LAST_VALUE that did not specify a frame (DefaultFrame) the value for the last value is
the OrderDate value for that particular row. This is because the default frame only goes to the current row
when no frame is specified. Compare columns LastOrderDate with DefaultFrame to the affect of framing when
using LAST_VALUE.

SalesOrderID	OrderDate	CustomerID	FirstOrderDate	LastOrderDate	DefaultFrame
43793			2011-06-21	11000		2011-06-21		2013-10-03		2011-06-21
51522			2013-06-20	11000		2011-06-21		2013-10-03		2013-06-20
57418			2013-10-03	11000		2011-06-21		2013-10-03		2013-10-03
43767			2011-06-17	11001		2011-06-17		2014-05-12		2011-06-17
51493			2013-06-18	11001		2011-06-17		2014-05-12		2013-06-18
72773			2014-05-12	11001		2011-06-17		2014-05-12		2014-05-12
43736			2011-06-09	11002		2011-06-09		2013-07-26		2011-06-09
51238			2013-06-02	11002		2011-06-09		2013-07-26		2013-06-02
53237			2013-07-26	11002		2011-06-09		2013-07-26		2013-07-26
43701			2011-05-31	11003		2011-05-31		2013-10-10		2011-05-31
51315			2013-06-07	11003		2011-05-31		2013-10-10		2013-06-07
57783			2013-10-10	11003		2011-05-31		2013-10-10		2013-10-10
43810			2011-06-25	11004		2011-06-25		2013-10-01		2011-06-25
51595			2013-06-24	11004		2011-06-25		2013-10-01		2013-06-24
57293			2013-10-01	11004		2011-06-25		2013-10-01		2013-10-01
43704			2011-06-01	11005		2011-06-01		2013-10-02		2011-06-01
51612			2013-06-25	11005		2011-06-01		2013-10-02		2013-06-25

**********************************************************************************************************/