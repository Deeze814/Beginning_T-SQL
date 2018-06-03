--Adding a Check Constraint    
USE tempdb;    
GO    

--Query 1: Drop the table if is already exists (DDL)
IF OBJECT_ID('table1') IS NOT NULL BEGIN        
	DROP TABLE table1;    
END;      
 
--Query 2: Create the new table with a check constraint on col2 (DDL)
CREATE TABLE table1 (col1 SMALLINT, col2 VARCHAR(20),        
	CONSTRAINT ch_table1_col2_months        
	CHECK (col2 IN ('January','February','March','April','May',            
		'June','July','August','September','October',            
		'November','December')        
	)     
);           

--Query 3: Alter the table to now have a Check constraint on col1 (DDL)
ALTER TABLE table1 ADD CONSTRAINT ch_table1_col1        
CHECK (col1 BETWEEN 1 and 12);       
PRINT 'January';       

--Query 4: Insert a valid value into col1, but an invalid value in col2 (DML)
INSERT INTO table1 (col1,col2)    
VALUES (1,'Jan'); 

--Query 5: Insert a valid value into both columns (DML)
PRINT 'February';
INSERT INTO table1 (col1,col2)    
VALUES (2,'February');       
PRINT 'March';       

--Query 6: Insert invalid value into col1, but valid value into col2 (DML)
INSERT INTO table1 (col1,col2)    
VALUES (13,'March');       
PRINT 'Change 2 to 20';    

--Query 7: Execute an invalid update statment (DML)
UPDATE table1 SET col1 = 20;  


/******** NOTES *******************************************************************************************
Output:

January
Msg 547, Level 16, State 0, Line 25
The INSERT statement conflicted with the CHECK constraint "ch_table1_col2_months". The conflict occurred in database "tempdb", table "dbo.table1", column 'col2'.
The statement has been terminated.
February


March
Msg 547, Level 16, State 0, Line 35
The INSERT statement conflicted with the CHECK constraint "ch_table1_col1". The conflict occurred in database "tempdb", table "dbo.table1", column 'col1'.
The statement has been terminated.

Change 2 to 20
Msg 547, Level 16, State 0, Line 40
The UPDATE statement conflicted with the CHECK constraint "ch_table1_col1". The conflict occurred in database "tempdb", table "dbo.table1", column 'col1'.
The statement has been terminated.


**********************************************************************************************************/