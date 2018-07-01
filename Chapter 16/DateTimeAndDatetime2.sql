--DATE, TIME, DATETIME2

--Delete table from previous batch executions
IF OBJECT_ID('dbo.DateDemo') IS NOT NULL BEGIN        
	DROP TABLE dbo.DateDemo;    
END;   
       
--Create a demo table 
CREATE TABLE dbo.DateDemo
(
	JustTheDate DATE
	,JustTheTime TIME(1)
	,NewDateTime2 DATETIME2(3)
	,UTCDate DATETIME2
);          

--Insert a row    
INSERT INTO dbo.DateDemo 
(
	JustTheDate
	,JustTheTime
	,NewDateTime2
	,UTCDate
)    
VALUES 
(
	SYSDATETIME()
	,SYSDATETIME()
	,SYSDATETIME()
	,SYSUTCDATETIME()
);
       
--View the dat
SELECT 
	JustTheDate
	,JustTheTime
	,NewDateTime2
	,UTCDate    
FROM dbo.DateDemo;   


/******** NOTES *******************************************************************************************
--Output (Ran at 1:08 P.M on 7/01/2018)
JustTheDate		JustTheTime		NewDateTime2				UTCDate
2018-07-01		13:08:51.8		2018-07-01 13:08:51.822		2018-07-01 18:08:51.8217262

**********************************************************************************************************/