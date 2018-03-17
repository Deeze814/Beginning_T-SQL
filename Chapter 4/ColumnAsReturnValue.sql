SELECT
	 VacationHours
	,SickLeaveHours
	,CASE	
		WHEN VacationHours > SickLeaveHours THEN VacationHours
		ELSE SickLeaveHours
	END AS 'More Hours'
FROM HumanResources.Employee;

/*  Sample result subset
	VacationHours	SickLeaveHours	More Hours
	99				69				99
	1				20				20
	2				21				21
	48				80				80
	5				22				22
	6				23				23
	61				50				61
	62				51				62
	63				51				63
	16				64				64
	7				23				23
	9				24				24
	8				24				24
	3				21				21

*/