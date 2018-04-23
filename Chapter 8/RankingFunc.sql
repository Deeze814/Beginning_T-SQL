--Ranking Functions
SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS RowNum
	,RANK() OVER(ORDER BY CustomerID) AS RankNum
	,DENSE_RANK() OVER(ORDER BY CustomerID) AS DenseRankNum
	,ROW_NUMBER() OVER(ORDER BY  CustomerID DESC) AS ReversedRowNum
FROM Sales.Customer 
WHERE CustomerID BETWEEN 11000 AND 11200
ORDER BY CustomerID;
/******** NOTES *******************************************************************************************
Because Sales.Customer.CustomerID is unique, the first three functions return the same values

**********************************************************************************************************/


SELECT
	SalesOrderID
	,CustomerID
	,ROW_NUMBER() OVER(ORDER BY CustomerID) AS RowNum
	,RANK() OVER(ORDER BY CustomerID) AS RankNum
	,DENSE_RANK() OVER(ORDER BY CustomerID) AS DenseRankNum
FROM Sales.SalesOrderHeader 
WHERE CustomerID BETWEEN 11000 AND 11200
ORDER BY CustomerID;
/******** NOTES *******************************************************************************************
This query also orders by CustomerID, but CustomerID is not unique in the Sales.SalesOrderHeader table.

This duplication leads to the difference between the RANK and DENSE_RANK values.
Notice that after the duplicates are processed, the RANK value catches back up with the ROW_NUMBER value.
DENSE_RANK will remain sequential after it processes all the rows ordered by.

SalesOrderID	CustomerID	RowNum	RankNum	DenseRankNum
43793			11000		1		1		1
51522			11000		2		1		1
57418			11000		3		1		1
43767			11001		4		4		2
51493			11001		5		4		2
72773			11001		6		4		2
43736			11002		7		7		3
51238			11002		8		7		3
53237			11002		9		7		3
43701			11003		10		10		4
51315			11003		11		10		4
57783			11003		12		10		4
43810			11004		13		13		5
51595			11004		14		13		5
57293			11004		15		13		5

**********************************************************************************************************/
