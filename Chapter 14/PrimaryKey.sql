--Adding Primary keys
USE tempdb;    
GO       
--Create test tables    
IF OBJECT_ID('table1') IS NOT NULL BEGIN        
	DROP TABLE table1;    
END;       
IF OBJECT_ID('table2') IS NOT NULL BEGIN        
	DROP TABLE table2;    
END;
IF OBJECT_ID('table3') IS NOT NULL BEGIN        
	DROP TABLE table3;    
END;    
   
--Primary key with name
CREATE TABLE table1 
(
	col1 INT NOT NULL,        
	col2 VARCHAR(10),        
	CONSTRAINT PK_table1_Col1 PRIMARY KEY (col1)
);    
   
--Composite primary key
CREATE TABLE table2 
(
	col1 INT NOT NULL,        
	col2 VARCHAR(10) NOT NULL, 
	col3 INT NULL,        
	CONSTRAINT PK_table2_col1col2 PRIMARY KEY (col1, col2)    
);      

--Table that will gets its primary key from the below ALTER statment
CREATE TABLE table3 
(
	col1 INT NOT NULL,        
	col2 VARCHAR(10) NOT NULL, 
	col3 INT NULL
);       
--5    
ALTER TABLE table3 ADD CONSTRAINT PK_table3_col1col2        
PRIMARY KEY NONCLUSTERED (col1,col2);  

/******** NOTES *******************************************************************************************


**********************************************************************************************************/