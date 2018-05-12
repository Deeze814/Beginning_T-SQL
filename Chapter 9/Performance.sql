--Performance

SET STATISTICS IO ON;
GO

--1
SELECT Name
FROM Production.Product
WHERE CHARINDEX('Bear', Name) = 1;

--2
SELECT Name
FROM Production.Product
WHERE Name LIKE('Bear%')

--3
SELECT Name, Color
FROM Production.Product
WHERE CHARINDEX('B', Color) = 1;

--4
SELECT Name, Color
FROM Production.Product
WHERE COLOR LIKE 'B%';

/******** NOTES *******************************************************************************************
--Query 1 vs 2: 
	1 is using the CHARINDEX to find all the roww where Name starts with 'Bear'. It will return the same rows
	as 2, but will have to do a SCAN on the AK_PRODUCT_NAME Non-Clustered index to evaluate each record's Name value
	2 will do a SEEK on the same index allowing it to much more quickly achive the same result (2 logical reads vs 6)

	IMPORTANT: Query 2 is SARGABLE, it can take full advantage of the AK_PRODUCT_NAME Non-Clustered index 
					
--Query 3 vs 4:
	Both queries will return the same result and both will have to perform a scan of the Clustered Index, so neither
	is more efficient than the other.


--Stat IO results

(1 row affected)
Table 'Product'. Scan count 1, logical reads 6, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(1 row affected)
Table 'Product'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(119 rows affected)
Table 'Product'. Scan count 1, logical reads 15, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

(119 rows affected)
Table 'Product'. Scan count 1, logical reads 15, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

**********************************************************************************************************/