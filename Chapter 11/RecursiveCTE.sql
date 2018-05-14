--Recursive CTE
USE tempdb;
GO

WITH OrgChart (EmployeeID, ManagerID, Title, Level,Node)        
AS 
(
	--Anchor member
	SELECT 
		EmployeeID
		,ManagerID
		,Title
		,0
		,cONVERT(VARCHAR(30),'/') AS Node 
	FROM dbo.Employee            
	WHERE ManagerID IS NULL            
	
	UNION ALL            
	--Recursive member
	SELECT 
		e.EmployeeID
		,e.ManagerID
		,e.Title
		,oc.Level + 1
		,CONVERT(VARCHAR(30)
		,oc.Node + CONVERT(VARCHAR(30), e.ManagerID) + '/')            
	FROM dbo.Employee e            
	JOIN OrgChart oc ON e.ManagerID = oc.EmployeeID        
)    
SELECT 
	EmployeeID
	,ManagerID
	,SPACE(Level * 3) + Title AS Title
	,Level
	,Node    
FROM OrgChart
ORDER BY Node;  

/******** NOTES *******************************************************************************************


EmployeeID	ManagerID	Title								Level	Node
109			NULL		Chief Executive Officer				0		/
6			109			 Marketing Manager					1		/109/
12			109			 Vice President of Engineering		1		/109/
148			109			 Vice President of Production		1		/109/
3			12			  Engineering Manager				2		/109/12/
4			3	           Senior Tool Designer				3		/109/12/3/
9			3	           Design Engineer					3		/109/12/3/
11			3	           Design Engineer					3		/109/12/3/
263			3	            Senior Tool Designer			3		/109/12/3/
5			263	            Tool Designer					4		/109/12/3/263/
21			148			  Production Control Manager		2		/109/148/
7			21	           Production Supervisor - WC60		3		/109/148/21/
14			21	           Production Supervisor - WC50		3		/109/148/21/
16			21	           Production Supervisor - WC60		3		/109/148/21/
18			21	           Production Supervisor - WC60		3		/109/148/21/
25			21	           Production Supervisor - WC10		3		/109/148/21/
173			21	           Production Supervisor - WC30		3		/109/148/21/
184			21	           Production Supervisor - WC30		3		/109/148/21/
185			21	           Production Supervisor - WC10		3		/109/148/21/
197			21	           Production Supervisor - WC45		3		/109/148/21/
1			16	            Production Technician - WC60	4		/109/148/21/16/
20			173	            Production Technician - WC30	4		/109/148/21/173/
24			184	            Production Technician - WC30	4		/109/148/21/184/
8			185	            Production Technician - WC10	4		/109/148/21/185/
10			185	            Production Technician - WC10	4		/109/148/21/185/
13			185	            Production Technician - WC10	4		/109/148/21/185/
15			185	            Production Technician - WC10	4		/109/148/21/185/
17			185	            Production Technician - WC10	4		/109/148/21/185/
19			185	            Production Technician - WC10	4		/109/148/21/185/
22			197	            Production Technician - WC45	4		/109/148/21/197/
23			197	            Production Technician - WC45	4		/109/148/21/197/
2			6			  Marketing Assistant				2		/109/6/

**********************************************************************************************************/