--Creating and Using User-Defined Scalar Functions

--Drop previous DB objects
IF OBJECT_ID('dbo.udf_Product') IS NOT NULL BEGIN        
	DROP FUNCTION dbo.udf_Product;    
END;    
IF OBJECT_ID('dbo.udf_Delim') IS NOT NULL BEGIN        
	DROP FUNCTION dbo.udf_Delim;    
END;   
GO 
      
--Create the new scalr UDF that will multiple the two numbers and return the result
CREATE FUNCTION dbo.udf_Product(@num1 INT, @num2 INT)  
RETURNS INT 
AS    
BEGIN           
	DECLARE @Product INT;        
	SET @Product = ISNULL(@num1,0) * ISNULL(@num2,0);        
	RETURN @Product;       
END;    
GO     
  
--Create new scalar UDF that will seperate each character of the string with the sentin delimiter
CREATE FUNCTION dbo.udf_Delim(@String VARCHAR(100),@Delimiter CHAR(1))        
RETURNS VARCHAR(200) 
AS    
BEGIN       
	DECLARE @NewString VARCHAR(200) = ''
			,@Length INT 
			,@Count INT = 1;  
	SET @Length = LEN(@String);

	WHILE @Count <= @Length
		BEGIN   
			SET @NewString += 
					CASE @COUNT 
						WHEN @Length THEN SUBSTRING(@String,@Count,1) --Do not add trailing comma on last character
					    ELSE SUBSTRING(@String,@Count,1) + @Delimiter
					END

			SET @Count += 1;    
		END           
	RETURN @NewString;    
END    
GO    
   
--Test the new scalar UDF
SELECT 
	StoreID
	,TerritoryID
	,dbo.udf_Product(StoreID, TerritoryID) AS TheProduct
	,dbo.udf_Delim(FirstName,',') AS FirstNameWithCommas    
FROM Sales.Customer c    
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;   

/******** NOTES *******************************************************************************************
Output:

StoreID	TerritoryID		TheProduct	FirstNameWithCommas
294		4				1176		C,a,t,h,e,r,i,n,e
296		3				888			K,i,m
298		2				596			H,u,m,b,e,r,t,o
292		5				1460		G,u,s,t,a,v,o
300		9				2700		P,i,l,a,r
NULL	4				0			A,a,r,o,n
NULL	4				0			A,d,a,m
NULL	1				0			A,l,e,x
NULL	4				0			A,l,e,x,a,n,d,r,a
NULL	7				0			A,l,l,i,s,o,n
NULL	4				0			A,m,a,n,d,a
NULL	9				0			A,m,b,e,r
NULL	4				0			A,n,d,r,e,a
NULL	4				0			A,n,g,e,l
NULL	1				0			B,a,i,l,e,y
NULL	1				0			B,e,n
NULL	4				0			B,l,a,k,e

**********************************************************************************************************/