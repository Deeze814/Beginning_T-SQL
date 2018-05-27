-- Listing 12-18. Using a Cursor 
--1    
DECLARE @ProductID INT;    
DECLARE @Name NVARCHAR(25);       
--2    
DECLARE products CURSOR FAST_FORWARD FOR        
SELECT 
	ProductID
	,Name        
FROM Production.Product;       
--3    
OPEN products;       
--4    
FETCH NEXT FROM products INTO @ProductID, @Name; 
--5    
WHILE @@FETCH_STATUS = 0 BEGIN        
--5.1        
PRINT @ProductID;        
PRINT @Name;        
--5.2        
FETCH NEXT FROM products INTO @ProductID, @Name;    
END       
--6    
CLOSE products;    
DEALLOCATE products;     

/******** NOTES *******************************************************************************************
Section (1):	Set up our variables to hold the value of each iteration

Section (2):	Create the cursor, "products" that loops through the result set of unique ProductID
				and Name combination from the Production.Product table

Section (3):	Opens the cursor so that it can be interacted with

Section (4):	Gets the next record in the cursor for processing and parses each column of the result 
				set into the variables

Section (5):	This while loop will check a variable of the cursor to see if another record is available
				based on the last FETCH NEXT operation

Section (5.1):	Print the current iteration's column values

Section (5.2):	Get the next row from the cursor

Section (6):	Cleans up the cursor by closing and deallocating the cursor

**********************************************************************************************************/