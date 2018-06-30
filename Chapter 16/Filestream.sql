--Setting up and using a FILESTREAM


/****** Setting up needed constructs for FileStream functionality ********
Step 1:	We need to get the current installation's default collation value, 
		since we will need it in the Hekaton table declaration

Step 2:	We need to Add a new memory optimized file group

Step 3: We need to add a storage 'container' for the filegroup

******************************************************************************/

--Step (1): Get the SQL Server installation's Collation value
--	SET NOCOUNT ON
--	GO
--	SELECT 
--		SERVERPROPERTY('collation') SQLServerCollation
--		,DATABASEPROPERTYEX('master', 'Collation') AS MasterDBCollation; --SQL_Latin1_General_CP1_CI_AS


----Step (2): Add a new memory optimized file group
--ALTER DATABASE AdventureWorks2012
--ADD FILEGROUP StandardFileGroup;
--GO

----Step (3): Add a new storage container
--ALTER DATABASE AdventureWorks2012 ADD FILE
--(
--	NAME = N'StandardFiles', 
--	FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL14.BEGINNING_TSQL\MSSQL\DATA\StandardFiles'
--)
--TO FILEGROUP InMemoryOLTPFileGroup;

----Since I have two filestreams in my DB (InMemoryOLTP and StandardFile) I need to set one to be the default
--ALTER DATABASE AdventureWorks2012 MODIFY FILEGROUP InMemoryOLTPFileGroup DEFAULT;


--SELECT database_id,type_desc,name,physical_name
--FROM sys.master_files WHERE database_id=DB_ID('AdventureWorks2012');


--EXEC sp_configure filestream_access_level, 2  
--RECONFIGURE  

--DROP TABLE NotepadFiles;    CHECKPOINT;   
--ALTER DATABASE AdventureWorks2012  
--REMOVE FILE StandardFile;  
--go
--ALTER DATABASE AdventureWorks2012  
--REMOVE FILEGROUP StandardFileGroup;  

--SELECT * FROM AdventureWorks2012.sys.data_spaces WHERE name = 'FileStream' 

/******** Creating Table and exercise ************************/
--Drop the Table from previous executions  
IF OBJECT_ID('dbo.NotepadFiles') IS NOT NULL BEGIN        
	DROP TABLE dbo.NotepadFiles;    
END;   
    
--Create new table that contains a column linked to the FILESTRAM  
CREATE table dbo.NotepadFiles
(
	Name VARCHAR(25)
	,FileData VARBINARY(MAX) FILESTREAM
	,RowID UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE DEFAULT NEWSEQUENTIALID()
);       

--Test filestream insert
INSERT INTO dbo.NotepadFiles(Name,FileData)    
VALUES 
(
	'test1'
	,CONVERT(VARBINARY(MAX),'This is a test')
),        
(
	'test2'
	,CONVERT(VARBINARY(MAX),'This is the second test')
);       


--View the data 
SELECT 
	Name
	,FileData,CONVERT(VARCHAR(MAX),FileData) TheData
	,RowID    
FROM dbo.NotepadFiles;



/******** NOTES *******************************************************************************************


**********************************************************************************************************/