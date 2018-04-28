--Window Function Aggregates

--
SELECT
	SalesOrderID
	,CustomerID
	,COUNT(*) OVER() AS CountOfSales
	,COUNT(*) OVER(PARTITION BY CustomerID) AS CountOfCustSales
	,SUM(TotalDue) OVER(PARTITION BY CustomerID) AS SumOfCustSales
FROM Sales.SalesOrderHeader 
ORDER BY CustomerID;

/******** NOTES *******************************************************************************************
The empty over clause performs the calculation over the entire set of rows.
The window defined by empty () is the entire set of rows.

SalesOrderID	CustomerID	CountOfSales	CountOfCustSales	SumOfCustSales
43793			11000		31465			3					9115.1341
51522			11000		31465			3					9115.1341
57418			11000		31465			3					9115.1341
51493			11001		31465			3					7054.1875
43767			11001		31465			3					7054.1875
72773			11001		31465			3					7054.1875
43736			11002		31465			3					8966.0143
51238			11002		31465			3					8966.0143
53237			11002		31465			3					8966.0143
57783			11003		31465			3					8993.9155
51315			11003		31465			3					8993.9155
43701			11003		31465			3					8993.9155
43810			11004		31465			3					9056.5911
51595			11004		31465			3					9056.5911
57293			11004		31465			3					9056.5911
57361			11005		31465			3					8974.0698
51612			11005		31465			3					8974.0698
43704			11005		31465			3					8974.0698
43819			11006		31465			3					8971.5283
51198			11006		31465			3					8971.5283
58007			11006		31465			3					8971.5283
54705			11007		31465			3					9073.1551
51581			11007		31465			3					9073.1551
**********************************************************************************************************/