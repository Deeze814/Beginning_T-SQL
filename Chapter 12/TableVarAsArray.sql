--Using a table variable like an array
  
DECLARE @IDTable TABLE([Index] INT NOT NULL IDENTITY, ID INT);    
DECLARE @RowCount INT;    
DECLARE @ID INT;    
DECLARE @Count INT = 1;       
   
INSERT INTO @IDTable(ID)    
VALUES(500),(333),(200),(999);       
   
SELECT @RowCount = COUNT(*)    
FROM @IDTable;       
 
WHILE @Count <= @RowCount BEGIN        
	    
	SELECT @ID = ID        
	FROM @IDTable        
	WHERE [Index] = @Count;        
      
	PRINT CAST(@COUNT AS VARCHAR) + ': ' + CAST(@ID AS VARCHAR);        
       
	SET @Count += 1;    
END;   

/******** NOTES *******************************************************************************************


**********************************************************************************************************/