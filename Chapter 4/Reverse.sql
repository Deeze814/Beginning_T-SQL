--Using SUBSTRING with CHARINDEX to get the email domain 
SELECT 
	EmailAddress,
	SUBSTRING(EmailAddress, CHARINDEX('@', EmailAddress) + 1, 50) AS DOMAIN
FROM Production.ProductReview;

/*
EmailAddress							DOMAIN
---------------------------------------------------------------
john@fourthcoffee.com					fourthcoffee.com
david@graphicdesigninstitute.com		graphicdesigninstitute.com
jill@margiestravel.com					margiestravel.com
laura@treyresearch.net					treyresearch.net
*/

--Using reverse to get the file name from the string valued file path

SELECT
	physical_name,
	RIGHT(physical_name, CHARINDEX('\', REVERSE(physical_name)) -1) AS FileName
FROM sys.database_files;

/*
physical_name																							FileName
----------------------------------------------------------------------------------------------------------------------------------
C:\Program Files\Microsoft SQL Server\MSSQL14.BEGINNING_TSQL\MSSQL\DATA\AdventureWorks2012.mdf			AdventureWorks2012.mdf
C:\Program Files\Microsoft SQL Server\MSSQL14.BEGINNING_TSQL\MSSQL\DATA\AdventureWorks2012_log.ldf		AdventureWorks2012_log.ldf

*/