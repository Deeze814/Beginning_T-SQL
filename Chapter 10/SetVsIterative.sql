--File Description

SET NOCOUNT ON; 
--Create a work table    
IF OBJECT_ID(N'dbo.demoPerformance', N'U') IS NOT NULL
	DROP TABLE [dbo].[demoPerformance];    
GO      

CREATE TABLE dbo.demoPerformance(        
	CustomerID INT NOT NULL     
	CONSTRAINT PK_demoPerformance PRIMARY KEY CLUSTERED    
	(CustomerID ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF,        
		ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]         
GO       

PRINT 'Insert all rows start';    
PRINT SYSDATETIME();       
--Insert all rows from the Sales.SalesOrderDetail table at once    
INSERT INTO demoPerformance    
SELECT CustomerID    
FROM Sales.Customer;
       
PRINT 'Insert all rows end';    
PRINT SYSDATETIME();       

--Remove all rows from the first insert    
TRUNCATE TABLE dbo.demoPerformance;       
PRINT 'Insert rows one at a time begin';    
PRINT SYSDATETIME();     
      
--Set up a loop to insert one row at a time    
WHILE EXISTS(           
	SELECT *        
	FROM Sales.Customer AS c            
	WHERE NOT EXISTS(                
		SELECT * FROM dbo.demoPerformance AS p            
		WHERE c.CustomerID = p.CustomerID))        
		BEGIN           
			INSERT INTO demoPerformance(CustomerID)            
			SELECT TOP(1) CustomerID            
			FROM Sales.Customer AS c            
			WHERE NOT EXISTS(SELECT * FROM dbo.demoPerformance WHERE CustomerID = c.CustomerID);
		END    
	PRINT 'Insert rows one at a time end';    
PRINT SYSDATETIME();  


/******** NOTES *******************************************************************************************
--Comparing set based Vs iterative based data insertion, the set based approach took less than a second.
  The loop(iterative based) took nearly 7 minutes

Insert all rows start
2018-05-13 13:40:36.9302460
Insert all rows end
2018-05-13 13:40:36.9457109

Insert rows one at a time begin
2018-05-13 13:40:36.9457109
Insert rows one at a time end
2018-05-13 13:47:24.1794253

**********************************************************************************************************/