SELECT 
	 LastName
	,CHARINDEX('e',LastName) AS 'Find E' 
	,CHARINDEX('e',LastName, 4) AS 'Skip first 3 charaters' 
	,CHARINDEX('be',LastName) AS 'Find be'
	,CHARINDEX('Be',LastName) AS 'Find BE'
FROM Person.Person
WHERE BusinessEntityID IN (293,295,211,297,299,3057,15027);

/*
LastName	Find E	Skip first 3 charaters	Find be	Find BE
Abolrous	0		0						0		0
Abel		3		3						2		2
Abercrombie	3		3						2		2
Acevedo		3		3						0		0
Ackerman	4		4						0		0
Alexander	3		3						0		0
Bell		2		0						1		1
*/