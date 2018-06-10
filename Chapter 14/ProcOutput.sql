--Stored Procedure with OUTPUT clause


IF OBJECT_ID('dbo.usp_OrderDetailCount') IS NOT NULL BEGIN        
	DROP PROC dbo.usp_OrderDetailCount;    
END;    
GO      
 
--Create PROC with OUTPUT clause
CREATE PROC dbo.usp_OrderDetailCount 
	@OrderID INT
	,@Count INT OUTPUT 
AS           
	SELECT 
		@Count = COUNT(SalesOrderDetailID)       
	FROM Sales.SalesOrderDetail        
	WHERE SalesOrderID = @OrderID;        
GO       
--3    
DECLARE @OrderCount INT;       
--4    
EXEC usp_OrderDetailCount 71774, @OrderCount OUTPUT;       
--5    
PRINT @OrderCount; 


/******** NOTES *******************************************************************************************
Output: 2

**********************************************************************************************************/