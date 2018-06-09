--Working with Views

--Drop the view from prevous iterations
IF OBJECT_ID('dbo.vw_Customer') IS NOT NULL BEGIN        
	DROP VIEW dbo.vw_Customer;    
END;    
GO       

--Create the VIEW that pulls customer/person information
CREATE VIEW dbo.vw_Customer AS        
SELECT 
	c.CustomerID
	,c.AccountNumber
	,c.StoreID
	,c.TerritoryID
	,p.FirstName
	,p.MiddleName
	,p.LastName        
FROM Sales.Customer c        
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;    
GO   
    
--Select data from the view  
SELECT 
	CustomerID
	,AccountNumber
	,FirstName
	,MiddleName
	,LastName    
FROM dbo.vw_Customer;       
GO --Have to have a GO before the Alter statement (Alter can be the only statment in the BATCH)    

--Alter the view (Adding Person.Title)   
ALTER VIEW dbo.vw_Customer AS           
SELECT 
	c.CustomerID
	,c.AccountNumber
	,c.StoreID
	,c.TerritoryID
	,p.FirstName
	,p.MiddleName
	,p.LastName
	,p.Title        
FROM Sales.Customer c        
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;
GO
--5    
SELECT 
	CustomerID
	,AccountNumber
	,FirstName
	,MiddleName
	,LastName
	,Title    
FROM dbo.vw_Customer    
ORDER BY CustomerID;  
/******** NOTES *******************************************************************************************


**********************************************************************************************************/