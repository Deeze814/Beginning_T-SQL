--Create a table type

/************************************** Part 1 - Create Table Type ***************************************************************/
--Drop table type if it already exists
IF EXISTS(SELECT NULL FROM sys.types WHERE name = 'CustomerInfo')
BEGIN
	DROP TYPE dbo.CustomerInfo;
END;
--Create the Data Type
CREATE TYPE CustomerInfo
AS TABLE
(
	CustomerID INT NOT NULL PRIMARY KEY,
	FavoriteColor VARCHAR(20) NULL,
	FavoriteSeason VARCHAR(10) NULL
);


/******** NOTES *******************************************************************************************
--To see the new type in Object Explorer:
Databases --> AdventureWorks2012 --> Programmability --> Types --> User-Defined Table Types

**********************************************************************************************************/




/************************************** Part 2 - Create and Populate table variabled based on type ***************************************************************/

DECLARE @myTableVariable dbo.CustomerInfo;

INSERT INTO @myTableVariable(CustomerID, FavoriteColor, FavoriteSeason)
VALUES(11001, 'Blue', 'Summer')
	 ,(11002, 'Orange', 'Fall');

SELECT CustomerID, FavoriteColor, FavoriteSeason FROM @myTableVariable;

/******** NOTES *******************************************************************************************
--The @myTableVariable variable has the same definition as the dbo.CustomerInfo type. It could be used to send
  multiple rows to a stored procedre. This is called a 'tabled-valued parameter'

**********************************************************************************************************/



/************************************** Part 3 - Create SP and use the table variable ***************************************************************/

--Create the SP
--Drop test proc if it already exists
IF EXISTS( SELECT NULL FROM sys.procedures WHERE name = 'usp_TestTAbleVariable')
BEGIN
	DROP PROCEDURE dbo.usp_TestTableVariable;
END;
GO
--Create the proc
CREATE PROC dbo.usp_TestTableVariable
	@myTable CustomerInfo READONLY
AS
SELECT
	c.CustomerID
	,c.AccountNumber
	,mt.FavoriteColor
	,mt.FavoriteSeason
FROM Sales.Customer c
JOIN @myTable mt ON c.CustomerID = mt.CustomerID;
GO

--Initialize table variable to pass to proc
DECLARE @myTableVariable dbo.CustomerInfo;
INSERT INTO @myTableVariable(CustomerID, FavoriteColor, FavoriteSeason)
VALUES(11001, 'Blue', 'Summer')
	 ,(11002, 'Orange', 'Fall');

--Call the SP
EXEC dbo.usp_TestTableVariable @myTableVariable;



/******** NOTES *******************************************************************************************
--The @myTable parameter is declared as READONLY, this must be specified when using a table-valued parameter
  to call the procedure.

**********************************************************************************************************/