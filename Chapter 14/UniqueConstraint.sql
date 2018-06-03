--Unique Constraint

USE tempdb;    
GO  
  
--Query 1: Drop the table if is already exists (DDL)
IF OBJECT_ID('table1') IS NOT NULL BEGIN        
	DROP TABLE table1;    
END;       

--Query 2: Add the UNIQUE constratin to col1 (DDL)
CREATE TABLE table1 (col1 INT NULL UNIQUE,        
	col2 VARCHAR(20) NULL, col3 DATE NULL);    
GO
              
--Query 3: Add a combination UNIQUE constratin on col2 and col3 (DDL)
ALTER TABLE table1 ADD CONSTRAINT        
	unq_table1_col2_col3 UNIQUE (col2,col3);   
	          
--Query 4: Insert 2 valid rows into the table (DML)   
PRINT 'Statement 4'    
INSERT INTO table1(col1,col2,col3)    
VALUES (1,2,'2009/01/01'),(2,2,'2009/01/02');  

--Query 5: Insert an invalid row, unq_table1_col2_col3 constraint error (DML)
PRINT 'Statement 5'    
INSERT INTO table1(col1,col2,col3)    
VALUES (3,2,'2009/01/01');       

--Query 6: Insert an invalid row, col1 UNIQUE constraint error (DML)
PRINT 'Statement 6'    
INSERT INTO table1(col1,col2,col3)    
VALUES (1,2,'2009/01/01');       

select * from table1;

--Query 7: Insert invalid row, unq_table1_col2_col3 constraint eror (DML)
PRINT 'Statement 7'    
UPDATE table1 SET col3 = '2009/01/02'    
WHERE col1 = 1;  

--Query 8: Going to see if col1 gives a constraint error for attempting to insert multiple NULL values 
PRINT 'Multiple NULL values'
INSERT INTO table1(col1,col2,col3)    
VALUES (NULL,5,'2010/01/01'); 

INSERT INTO table1(col1,col2,col3)    
VALUES (NULL,6,'2011/01/01');         



/******** NOTES *******************************************************************************************
OUTPUT:
Statement 4

(2 rows affected)
Statement 5
Msg 2627, Level 14, State 1, Line 27
Violation of UNIQUE KEY constraint 'unq_table1_col2_col3'. Cannot insert duplicate key in object 'dbo.table1'. The duplicate key value is (2, 2009-01-01).
The statement has been terminated.
Statement 6
Msg 2627, Level 14, State 1, Line 32
Violation of UNIQUE KEY constraint 'UQ__table1__357D0D3FF80876E1'. Cannot insert duplicate key in object 'dbo.table1'. The duplicate key value is (1).
The statement has been terminated.

(2 rows affected)
Statement 7
Msg 2627, Level 14, State 1, Line 39
Violation of UNIQUE KEY constraint 'unq_table1_col2_col3'. Cannot insert duplicate key in object 'dbo.table1'. The duplicate key value is (2, 2009-01-02).
The statement has been terminated.


NULL test output:
Multiple NULL values

(1 row affected)
Msg 2627, Level 14, State 1, Line 47
Violation of UNIQUE KEY constraint 'UQ__table1__357D0D3FF80876E1'. Cannot insert duplicate key in object 'dbo.table1'. The duplicate key value is (<NULL>).
The statement has been terminated.

**********************************************************************************************************/