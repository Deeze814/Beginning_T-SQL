--Running queries with STAT IO
SET STATISTICS IO ON;
GO

SELECT * FROM Sales.SalesOrderHeader;
/******** NOTES *************
(31465 rows affected)
Table 'SalesOrderHeader'. Scan count 1, logical reads 689, physical reads 3, read-ahead reads 685, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

This query has to return ALL columns for the rows, so the DB engine must read more pages when accessing the columns.
There is less data (rows) per page because each row contains every single column.
This explains why it had to do 3 physical reads from disk in conjunction with its 689 logical reads

This query lacks a WHERE clause, so the DB engine MUST do a SCAN of the clustered index (table).
This means the DB engine must completely read every page in the index.

****************************/




SELECT SalesOrderID FROM Sales.SalesOrderHeader;
/******** NOTES *************
(31465 rows affected)
Table 'SalesOrderHeader'. Scan count 1, logical reads 57, physical reads 1, read-ahead reads 55, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

This query only has to return the SalesOrderID column per row, so it has more rows per page.
This query only has to do a SCAN of one of the NON-CLUSTERED indexes.

	--Every NON-CLUSTERED index automatically includes the cluster key, which is used to find the matching clustered index row.
	--Nonclusterd indexes are genearlly much smaller structures than the table itself, so that is why a much smaller number of pages were read.
****************************/


SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader;
/******** NOTES *************
(31465 rows affected)
Table 'SalesOrderHeader'. Scan count 1, logical reads 689, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.\

This query also required 689 logical reads, but no physical reads.
It requires 689 reads because there is not a non-clustered index containing SalesOrderID and OrderDate (either as a key or included column).
	--This means every record from the table must be scanned (enitre clustered index)
	--The reason it did not have to do 3 physical scans is because it is only returning 2 columns per row.
		--This allows it to place more data per page than Query 1
			--Query 1 has to put all columns in each row, thus fewer rows per page.
****************************/