--Error handlign with TRY...CATCH

----1    
BEGIN TRY        
	PRINT 1/0;    
END TRY    
BEGIN CATCH        
	PRINT 'Inside the Catch block';        
	PRINT ERROR_NUMBER();        
	PRINT ERROR_MESSAGE();       
	PRINT ERROR_NUMBER();    
END CATCH    
PRINT 'Outside the catch block';    
PRINT CASE WHEN ERROR_NUMBER() IS NULL THEN 'NULL'        
ELSE CAST(ERROR_NUMBER() AS VARCHAR(10)) END;    
GO
       
--2   
BEGIN TRY        
DROP TABLE testTable;    
END TRY    
BEGIN CATCH        
PRINT 'An error has occurred.'        
PRINT ERROR_NUMBER();        
PRINT ERROR_MESSAGE();    
END CATCH; 

/******** NOTES *******************************************************************************************
--Output for Query 1:
	Inside the Catch block
	8134
	Divide by zero error encountered.
	8134
	Outside the catch block
	NULL

--Output for Query 2:
	An error has occurred.
	3701
	Cannot drop the table 'testTable', because it does not exist or you do not have permission.

**********************************************************************************************************/