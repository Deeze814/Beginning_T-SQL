--Effective Sequence
USE tempdb;  
GO          
 
SELECT * FROM dbo.JobHistory;

DECLARE @Date DATE = '05-02-2009';       
--DECLARE @Date DATE = '06-02-2009';       
 
WITH EffectiveDate 
AS 
(            
	SELECT 
		MAX(EffDate) AS MaxDate
		,EmployeeID            
	FROM dbo.JobHistory 
	WHERE EffDate <= @Date            
	GROUP BY EmployeeID        
),        
EffectiveSeq AS 
(            
	SELECT 
		MAX(EffSeq) AS MaxSeq
		,j.EmployeeID
		,MaxDate            
	FROM dbo.JobHistory j             
	JOIN EffectiveDate d ON j.EffDate = d.MaxDate 
		AND j.EmployeeID = d.EmployeeID            
	GROUP BY j.EmployeeID, MaxDate
)    
SELECT 
	j.EmployeeID
	,EmploymentStatus
	,JobTitle
	,Salary    
FROM dbo.JobHistory j     
JOIN EffectiveSeq e ON j.EmployeeID = e.EmployeeID         
	AND j.EffDate = e.MaxDate 
	AND j.EffSeq = e.MaxSeq;   

	      
/******** NOTES *******************************************************************************************
What this query tells us is the current position an employee holds as of May 2nd 2009.
It does this by looking at the EffDate column as compared to the @Date variable.
It finds the date closest to the @Date variable to use for the outer query.

If an employee's 'Effective Date' (date closest to @Date) has more than one record, then multiple actions
occured for that employee on their effective date. This is when we use the 'Effective Sequence'. We basically
look take the record that has the highest EffSeq value for the given Effective Date.

EmployeeID	EmploymentStatus	JobTitle						Salary
1000		A					Intern							2000.00
1100		A					Accounts Payable Specialist II	3000.00
1200		T					Design Engineer					5000.00

**********************************************************************************************************/