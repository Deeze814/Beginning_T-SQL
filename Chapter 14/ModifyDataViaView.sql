--Modify data via views

--Drop DB objects from previous iterations
IF OBJECT_ID('dbo.demoCustomer') IS NOT NULL BEGIN        
	DROP TABLE dbo.demoCustomer;    
END;    
IF OBJECT_ID('dbo.demoPerson') IS NOT NULL BEGIN        
	DROP TABLE dbo.demoPerson;    
END;    
IF OBJECT_ID('dbo.vw_Customer') IS NOT NULL BEGIN        
	DROP VIEW dbo.vw_Customer;    
END;  
     
--Populate the demo tables  
SELECT 
	CustomerID
	,TerritoryID
	,StoreID
	,PersonID    
INTO dbo.demoCustomer    
FROM Sales.Customer;
       
SELECT 
	BusinessEntityID
	,Title
	,FirstName
	,MiddleName
	,LastName    
INTO dbo.demoPerson    
From Person.Person;    
GO
      
--Create vie that operates on the Demo tables
CREATE VIEW vw_Customer AS        
SELECT 
	CustomerID
	,TerritoryID
	,PersonID
	,StoreID
	,Title
	,FirstName
	,MiddleName
	,LastName        
FROM dbo.demoCustomer       
INNER JOIN dbo.demoPerson ON PersonID = BusinessEntityID;    
GO  
     
--Select info from the view    
SELECT CustomerID, FirstName, MiddleName, LastName    
FROM dbo.vw_Customer    
WHERE CustomerID IN (29484,29486,29489,100000);     
  
--Update the underlying demo table via the View  
PRINT 'Update one row';    
UPDATE dbo.vw_Customer SET FirstName = 'Kathi'    
WHERE CustomerID = 29486;       
GO 
   
--This leads to the Error: View or function 'dbo.vw_Customer' is not updatable because the modification affects multiple base tables.
PRINT 'Attempt to update both sides of the join'    
GO    
UPDATE dbo.vw_Customer 
SET FirstName = 'Franie'
	,TerritoryID = 5   
WHERE CustomerID = 29489
GO  

--This leads to the Error: View or function 'dbo.vw_Customer' is not updatable because the modification affects multiple base tables. 
PRINT 'Attempt to delete a row';    
GO    
DELETE FROM dbo.vw_Customer    
WHERE CustomerID = 29484;       
GO  

--Succeeds because it only affects one table (demoCustomer)      
PRINT 'Insert into dbo.demoCustomer';    
INSERT INTO dbo.vw_Customer(TerritoryID,        
	StoreID, PersonID)    
VALUES (5,5,100000);       
GO   

--This leads to Error: Cannot insert the value NULL into column 'BusinessEntityID', table 'AdventureWorks2012.dbo.demoPerson'; column does not allow nulls. INSERT fails.
PRINT 'Attempt to insert a row into demoPerson';    
GO    
INSERT INTO dbo.vw_Customer(Title, FirstName, LastName)   
VALUES ('Mrs.','Lady','Samoyed');      
 
--10    
SELECT CustomerID, FirstName, MiddleName, LastName    
FROM dbo.vw_Customer    
WHERE CustomerID IN (29484,29486,29489,100000);      
 
--11    
SELECT CustomerID, TerritoryID, StoreID, PersonID    
FROM dbo.demoCustomer    
WHERE PersonID = 100000; 

/******** NOTES *******************************************************************************************


**********************************************************************************************************/