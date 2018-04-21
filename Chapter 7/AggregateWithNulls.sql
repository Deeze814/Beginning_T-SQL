--Create a table that will have customer totals and the discount on the order.
CREATE TABLE #AvgDemo
(
	CustID INT
	,OrderID INT NOT NULL
	,Total MONEY NOT NULL
	,DiscountAmt MONEY NULL
);

INSERT INTO #AvgDemo(CustID, OrderID, Total, DiscountAmt)
SELECT 
	soh.CustomerID
	,sod.SalesOrderID
	,sod.LineTotal
	,NULLIF(SUM(sod.UnitPriceDiscount * LineTotal), 0.00) AS Discount --If the result UnitPriceDiscount * LineTotal is 0.00, then we set Discount as NULL
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE CustomerID IN (29648, 30048, 30043, 29716)
GROUP BY soh.CustomerID, sod.SalesOrderID, sod.LineTotal;

--Uncomment to see the rows with NULL for DiscountAmt
--SELECT * FROM #AvgDemo; 

--NOTE: If you click the messages tab for this query, you will see that it warns you that 
--		it is elminating Null values. You can turn this warning of using the 
--		SET ANSI_WARNINGS OFF, but I probalby wouldnt do that.
SELECT 
	CustID
	,AVG(DiscountAmt) AS AvgDiscount --Averages only the columns that have non-null values
	,AVG(ISNULL(DiscountAmt, 0)) AS AvgDiscountWithNullRows --Average drops signifcanty when we treat Null values as 0
	,Sum(DiscountAmt) AS SumOfDiscount --Sums up the total discount amount for the customer
	,COUNT(*)  AS CountOfRows --How many rows are tied to this customer
	,COUNT(DiscountAmt) AS NonNullCount --How many rows have a non-null value for DiscountAmt for the customer
FROM #AvgDemo
GROUP BY CustID;

/**
CustID	AvgDiscount		AvgDiscountWithNullRows		SumOfDiscount	CountOfRows	NonNullCount
30048	15.7206			1.7724						723.1498		408			46
29716	226.2739		1.4366						452.5479		315			2
29648	97.5864			7.5066						195.1728		26			2
30043	58.2258			4.9503						1222.7436		247			21

--Example for CustID = 30048
	AvgDiscount:				723.1498 / 46  = 15.7206
	AvgDiscountWithNullRows:	723.1498 / 408 = 1.7724

**/


DROP TABLE #AvgDemo;