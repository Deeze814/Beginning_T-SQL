SELECT 
	 LastName
	 ,SUBSTRING(LastName,1,4) AS 'First 4'
	 ,SUBSTRING(LastName,5,50) AS 'Characters 5 and later'
FROM Person.Person
WHERE BusinessEntityID IN (293,295,211,297,299,3057,15027);

/*
LastName	First 4	Characters	5 and later
Abolrous	Abol				rous
Abel		Abel	
Abercrombie	Aber				crombie
Acevedo		Acev				edo
Ackerman	Acke				rman
Alexander	Alex				ander
Bell		Bell	
*/