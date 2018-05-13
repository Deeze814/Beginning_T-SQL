--Data Insertion

--Drop the table if it exists and then recreate it
IF OBJECT_ID(N'dbo.demoAutoPopulated', 'U') IS NOT NULL
BEGIN
	DROP TABLE dbo.demoAutoPopulated;
END;

CREATE TABLE dbo.demoAutoPopulated
(
	IdentityColumn INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	,RegularColumn NVARCHAR(50) NOT NULL
	,RowVersionColumn ROWVERSION NOT NULL
	,ComputedColumn AS (RegularColumn + CONVERT(NVARCHAR, IdentityColumn, 0)) PERSISTED
);

GO

--Insert values
INSERT INTO dbo.demoAutoPopulated(RegularColumn)
VALUES(N'a'),(N'b'),(N'c');

--Observe the data
SELECT * FROM dbo.demoAutoPopulated;

/******** NOTES *******************************************************************************************


**********************************************************************************************************/