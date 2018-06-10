--Inserting the Rows from a Stored Procedure into a Table    

IF OBJECT_ID('dbo.tempCustomer') IS NOT NULL BEGIN        
	DROP TABLE dbo.tempCustomer;    
END;    
IF OBJECT_ID('dbo.usp_CustomerName') IS NOT NULL BEGIN        
	DROP PROC dbo.usp_CustomerName;    
END;   
GO   
    
--Create demo table   
CREATE TABLE dbo.tempCustomer
(
	CustomerID INT
	,FirstName NVARCHAR(50)
	,MiddleName NVARCHAR(50)
	,LastName NVARCHAR(50)
);    
GO  
     
--Create the Procedure
CREATE PROC dbo.usp_CustomerName 
	@CustomerID INT = -1 
AS        
	SELECT 
		c.CustomerID
		,p.FirstName
		,p.MiddleName
		,p.LastName        
	FROM Sales.Customer c        
	JOIN Person.Person p ON c.PersonID = p.BusinessEntityID        
	WHERE @CustomerID = CASE @CustomerID --This case statement will allow the SP to give back all Person/Customer records if a CustomerID is not specified
							WHEN -1 THEN -1 
							ELSE c.CustomerID 
					    END;                  
GO  
     
--4    
INSERT INTO dbo.tempCustomer EXEC dbo.usp_CustomerName;       
--5    
SELECT 
	CustomerID
	,FirstName
	,MiddleName
	,LastName    
FROM dbo.tempCustomer;  
/******** NOTES *******************************************************************************************


**********************************************************************************************************/