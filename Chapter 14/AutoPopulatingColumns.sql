-- Defining Tables with Automatically Populating Columns    
USE tempdb;    
GO    
--Drop the DB objects from previous batches 
IF OBJECT_ID('table3') IS NOT NULL BEGIN        
	DROP TABLE table3;    
END;  
IF OBJECT_ID('MySequence') IS NOT NULL BEGIN  
	DROP SEQUENCE MySequence;    
END;       
CREATE SEQUENCE MySequence START WITH 1;       

     
--Create a new table with the auto populating column types  
CREATE TABLE table3 
(
	idCol INT NOT NULL IDENTITY, --IDENTITY 
	col1 CHAR(1),       	      
	defCol DATE DEFAULT GETDATE(), --DEFAULT: Use Today's date if no value is specified         
	SeqCol INT DEFAULT NEXT VALUE FOR dbo.MySequence,  --DEFAULT: Use the next value in the dbo.MySequence SEQUENCE object if no value is specified      
	calcCol1 AS DATEADD(m,1,defCol), --COMPUTED: Add one month to the date alue inthe defCol column        
	calcCol2 AS col1 + ':' + col1, --COMPUTED: Format the value as col1:col1
	rvCol ROWVERSION, --ROWVERSION
	);    
GO       
--3    
INSERT INTO table3 (col1)    
VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('g');       
--4    
INSERT INTO table3 (col1, defCol)    
VALUES ('h', NULL),('i','2014/01/01');       
--5    
SELECT col1, idCol,defCol, calcCol1, calcCol2, SeqCol, rvCol
FROM table3;   

/******** NOTES *******************************************************************************************
OUTPUT:
col1	idCol	defCol			calcCol1		calcCol2	SeqCol	rvCol
a		1		2018-06-09		2018-07-09		a:a			1		0x00000000000007F1
b		2		2018-06-09		2018-07-09		b:b			2		0x00000000000007F2
c		3		2018-06-09		2018-07-09		c:c			3		0x00000000000007F3
d		4		2018-06-09		2018-07-09		d:d			4		0x00000000000007F4
e		5		2018-06-09		2018-07-09		e:e			5		0x00000000000007F5
g		6		2018-06-09		2018-07-09		g:g			6		0x00000000000007F6
h		7		NULL			NULL			h:h			7		0x00000000000007F7
i		8		2014-01-01		2014-02-01		i:i			8		0x00000000000007F8

**********************************************************************************************************/