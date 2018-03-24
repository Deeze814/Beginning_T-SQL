--Self Joins
CREATE TABLE #Employee( EmployeeID INT, ManagerID INT, Title NVARCHAR(50))

INSERT INTO #Employee(EmployeeID, ManagerID, Title)
VALUES (1,NULL,'CEO')
	  ,(2,1,'Engineering Manger')
	  ,(3,2,'Senior UX designer')
	  ,(4,2,'Desgin Engineer')
	  ,(5,2,'R&D Dev')
	  ,(6,1,'Marketing Manager')
	  ,(7,6,'Marketing Specialist');

SELECT 
	 employee.EmployeeID AS 'Employee'
	,employee.Title AS 'Employee Title'
	,manager.EmployeeID AS 'ManagerID'
	,manager.Title AS 'Manager Title'
FROM #Employee employee
LEFT JOIN #Employee manager ON employee.ManagerID = manager.EmployeeID;

DROP TABLE #Employee;

/*
Employee	Employee Title			ManagerID	Manager Title
1			CEO						NULL		NULL
2			Engineering Manger		1			CEO
3			Senior UX designer		2			Engineering Manger
4			Desgin Engineer			2			Engineering Manger
5			R&D Dev					2			Engineering Manger
6			Marketing Manager		1			CEO
7			Marketing Specialist	6			Marketing Manager
*/