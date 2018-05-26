--File Description


--Disk-Based table Create example (for differences below)
CREATE TABLE dbo.DiskBasedProduct
(
	ID INT NOT NULL PRIMARY KEY,
	Code VARCHAR(10) NOT NULL ,
	Description VARCHAR(200) NOT NULL ,
	Price FLOAT NOT NULL
);
GO

/****** Setting up needed constructs for In-Memory OLTP functionality ********
Step 1:	We need to get the current installation's default collation value, 
		since we will need it in the Hekaton table declaration

Step 2:	We need to Add a new memory optimized file group

Step 3: We need to add a storage 'container' for the filegroup

Step 4: Create the new table

******************************************************************************/

--Step (1): Get the SQL Server installation's Collation value
	SET NOCOUNT ON
	GO
	SELECT 
		SERVERPROPERTY('collation') SQLServerCollation
		,DATABASEPROPERTYEX('master', 'Collation') AS MasterDBCollation; --SQL_Latin1_General_CP1_CI_AS


--Step (2): Add a new memory optimized file group
	ALTER DATABASE AdventureWorks2012
	ADD FILEGROUP InMemoryOLTPFileGroup CONTAINS MEMORY_OPTIMIZED_DATA
	GO


--Step (3): Add a new storage container
ALTER DATABASE AdventureWorks2012 ADD FILE
(
	NAME = N'InMemoryOLTPContainer', 
	FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL14.BEGINNING_TSQL\MSSQL\DATA\InMemoryOLTPContainer'
)
TO FILEGROUP [InMemoryOLTPFileGroup]


--Memory-Optimized Table: Durable
	CREATE TABLE dbo.HekatonProduct
	(
		ID INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000),
		Code VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		Description VARCHAR(200) NOT NULL,
		Price FLOAT NOT NULL
	)
	WITH 
	(
		MEMORY_OPTIMIZED = ON,
		DURABILITY = SCHEMA_ONLY
	);
	GO

--Insert test values
INSERT INTO dbo.DiskBasedProduct(ID, Code, Description, Price)
VALUES	(1,'A1','Test Product 1', 1.99)
	   ,(2,'B2','Test Product 2', 15.99)
	   ,(3,'C3','Test Product 3', 18.49)
	   ,(4,'D4','Test Product 4', 12.39)
	   ,(5,'E5','Test Product 5', 25.99)
	   ,(6,'F6','Test Product 6', 80.00)
	   ,(7,'G7','Test Product 7', 101.99)
	   ,(8,'H8','Test Product 8', 844.99);

INSERT INTO dbo.HekatonProduct(ID, Code, Description, Price)
VALUES	(1,'A1','Test Product 1', 1.99)
	   ,(2,'B2','Test Product 2', 15.99)
	   ,(3,'C3','Test Product 3', 18.49)
	   ,(4,'D4','Test Product 4', 12.39)
	   ,(5,'E5','Test Product 5', 25.99)
	   ,(6,'F6','Test Product 6', 80.00)
	   ,(7,'G7','Test Product 7', 101.99)
	   ,(8,'H8','Test Product 8', 844.99);

--Test performance of Disk vs Hekaton tables
SET STATISTICS IO ON;
SELECT * FROM dbo.DiskBasedProduct;
SELECT * FROM dbo.HekatonProduct;

DELETE FROM dbo.DiskBasedProduct;
DELETE FROM dbo.HekatonProduct;

--Test with more data, insert from the Production.Product table
INSERT INTO dbo.DiskBasedProduct(ID, Code, Description, Price)
SELECT ProductID, ProductNumber, Name, ListPrice
FROM Production.Product;

INSERT INTO dbo.HekatonProduct(ID, Code, Description, Price)
SELECT ProductID, ProductNumber, Name, ListPrice
FROM Production.Product;



/******** NOTES *******************************************************************************************
Looking at the execution plan, the Hekaton query took just 5% of the the ovrall batch for selecting the 
same data

Operating on a larger data set saw the Hekaton perform worse than the disk based table.
Hekaton query cost was 58%
**********************************************************************************************************/