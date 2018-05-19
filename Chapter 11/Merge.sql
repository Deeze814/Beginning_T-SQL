--Using the MERGE Statement       
USE tempdb;    
GO 
   
--Create new tempdb tables     
IF OBJECT_ID('dbo.CustomerSource') IS NOT NULL BEGIN        
	DROP TABLE dbo.CustomerSource;    
END;    
IF OBJECT_ID('dbo.CustomerTarget') IS NOT NULL BEGIN        
	DROP TABLE dbo.CustomerTarget;    
END;
       
CREATE TABLE dbo.CustomerSource 
(
	CustomerID INT NOT NULL PRIMARY KEY
	,[Name] VARCHAR(150) NOT NULL
	, PersonID INT NOT NULL
);
    
CREATE TABLE dbo.CustomerTarget 
(
	CustomerID INT NOT NULL PRIMARY KEY
	,[Name] VARCHAR(150) NOT NULL
	,PersonID INT NOT NULL
);       

--Populate the tempdb table with records from the AdventureWorks2012 DB
INSERT INTO dbo.CustomerSource(CustomerID,Name,PersonID)    
SELECT 
	CustomerID
	,p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName
	,c.PersonID    
FROM AdventureWorks2012.Sales.Customer c     
INNER JOIN AdventureWorks2012.Person.Person p ON c.PersonID = p.BusinessEntityID    
WHERE c.CustomerID IN (29485,29486,29487,20075);   
      
INSERT INTO dbo.CustomerTarget(CustomerID,Name,PersonID)    
SELECT 
	c.CustomerID
	,p.FirstName  + ' ' + p.LastName
	,PersonID    
FROM AdventureWorks2012.Sales.Customer c     
INNER JOIN AdventureWorks2012.Person.Person p ON c.PersonID = p.BusinessEntityID    
WHERE c.CustomerID IN (29485,29486,21139);       

--Show the record in tempdb tables    
SELECT 
	CustomerID
	,Name
	,PersonID    
FROM dbo.CustomerSource    
ORDER BY CustomerID;
  
SELECT 
	CustomerID
	,Name
	,PersonID    
FROM dbo.CustomerTarget    
ORDER BY CustomerID;             

--Run the Merge statement between the two tempdb tables 
--All actions are with respect to the 'Target' table   
MERGE dbo.CustomerTarget t    
USING dbo.CustomerSource s 
ON (s.CustomerID = t.CustomerID)    
WHEN MATCHED AND s.Name <> t.Name --When CustomerTarget.CustomerID = CustomerSource.CustomerID (WHEN MATCHED)   
	THEN UPDATE SET Name = s.Name --When CustomerSource.Name != CustomerTarget.Name, set CustomerTarget.Name = CustomerSource.Name    
WHEN NOT MATCHED BY TARGET  --When CustomerSource has a CustomerID value not present in CustomerTarget
	THEN INSERT (CustomerID, Name, PersonID) VALUES (CustomerID, Name, PersonID) --Insert the record into CustomerTarget   
WHEN NOT MATCHED BY SOURCE --When CustomerTarget has a CustomerID value not present in CustomerSource
	THEN DELETE    --Delete the CustomerTarget record
OUTPUT $action, DELETED.*, INSERTED.*;--semi-colon is required        

--Show the result of the MERGE 
SELECT CustomerID, Name, PersonID    
FROM dbo.CustomerTarget    
ORDER BY CustomerID;      

/******** NOTES *******************************************************************************************
--Select 1 showing dbo.CustomerSource
	CustomerID	Name				PersonID
	20075		Aaron A Allen		17561
	29485		Catherine R. Abel	293
	29486		Kim Abercrombie		295
	29487		Humberto Acevedo	297

--Select 2 showing dbo.CustomerTarget
	CustomerID	Name				PersonID
	21139		Alex Adams			16724
	29485		Catherine Abel		293
	29486		Kim Abercrombie		295

--Ouput clause from the MERGE statement
	$action	CustomerID	Name			PersonID	CustomerID	Name				PersonID
	INSERT	NULL		NULL			NULL		20075		Aaron A Allen		17561
	DELETE	21139		Alex Adams		16724		NULL		NULL				NULL
	UPDATE	29485		Catherine Abel	293			29485		Catherine R. Abel	293
	INSERT	NULL		NULL			NULL		29487		Humberto Acevedo	297

--Select 3 showing dbo.CustomerTarget after MERGE 
	CustomerID	Name				PersonID
	20075		Aaron A Allen		17561
	29485		Catherine R. Abel	293
	29486		Kim Abercrombie		295
	29487		Humberto Acevedo	297

**********************************************************************************************************/