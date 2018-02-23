--Works but we end up with 2 spaces between first and last name when middle name is NULL
SELECT TOP(10)
	 BusinessEntityID
	,FirstName + ' ' + ISNULL(MiddleName, '') + ' ' +LastName  AS 'Full Name'	
FROM Person.Person;

--This will return the correct values and only one space between first and last name
SELECT TOP(10)
	 BusinessEntityID
	,FirstName + ISNULL(' ' + MiddleName, '') + ' ' + LastName  AS 'Full Name'	
FROM Person.Person;

--This will return the correct value and only one space between first and last name
SELECT TOP(10)
	 BusinessEntityID
	,FirstName + COALESCE(' ' + MiddleName, '') + ' ' + LastName  AS 'Full Name'	
FROM Person.Person;

