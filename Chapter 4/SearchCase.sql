--Search Case
SELECT 
	 Title
	,CASE 
		WHEN Title IN ('Ms.', 'Mrs.', 'Miss') THEN 'Female'
		WHEN Title = 'Mr.' THEN 'Male'
		ELSE 'Unknown'
	END AS Gender
FROM Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423);
/*
	Title	Gender
	NULL	Unknown
	Ms.		Female
	Mr.		Male
	Ms.		Female
	Sr.		Unknown
	Mrs.	Female
*/

--Search Case that does not work due to incompatiable types
SELECT 
	 Title
	,CASE 
		WHEN Title IN ('Ms.', 'Mrs.', 'Miss') THEN 1 --Incompatiable type
		WHEN Title = 'Mr.' THEN 'Male'
		ELSE 'Unknown'
	END AS Gender
FROM Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423);