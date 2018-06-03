--Raise Error

USE master;    
GO       
--1 This code section creates a custom error message    
IF EXISTS(SELECT NULL FROM sys.messages where message_id = 50002) 
BEGIN        
	EXEC sp_dropmessage 50002;    
END;    
GO    

PRINT 'Creating a custom error message.'          
EXEC sp_addmessage 50002, 16, N'Customer missing.';--Crate the custom error message with an ID value of 50002, and a severity of 16
GO       

USE AdventureWorks2012;    
GO    
--2    
IF NOT EXISTS(SELECT NULL FROM Sales.Customer WHERE CustomerID = -1) 
BEGIN       
	RAISERROR(50002,16,1);    
END;    
GO    

--3    
BEGIN TRY        
	PRINT 1/0;    
END TRY    
BEGIN CATCH        
	IF ERROR_NUMBER() = 8134 
	BEGIN            
		RAISERROR('You cant math!',16,1);        
	END;    
END CATCH;   

/******** NOTES *******************************************************************************************
--Output:
	Creating a custom error message.
	Msg 50002, Level 16, State 1, Line 21
	Customer missing.
	Msg 50000, Level 16, State 1, Line 32
	You cant math!


**********************************************************************************************************/