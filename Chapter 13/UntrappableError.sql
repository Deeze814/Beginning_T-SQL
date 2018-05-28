--Untrappable Error

--1    
PRINT 'Syntax error.';    
GO    
BEGIN TRY        
	SELECT FROM Sales.SalesOrderDetail;    
END TRY    
BEGIN CATCH        
	PRINT ERROR_NUMBER();    
END CATCH;    
GO
       
--2    
PRINT 'Invalid column.';    
GO    
BEGIN TRY        
	SELECT ABC FROM Sales.SalesOrderDetail;    
END TRY    
BEGIN CATCH        
PRINT ERROR_NUMBER();    
END CATCH;   

/******** NOTES *******************************************************************************************
Notice that we do not get the Error Number from the catch statement since these errors are untrappable.

**********************************************************************************************************/