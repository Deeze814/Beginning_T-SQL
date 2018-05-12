--PATINDEX

--1
SELECT 
	LastName
	,PATINDEX('Ber[rg]%', LastName) AS Position
FROM Person.Person
WHERE PATINDEX('Ber[rg]%', LastName) > 0;

/******** NOTES *******************************************************************************************
--Query 1 returns any rows where the last name begins with 'Ber' and is immediately followed by either an
'r' or a 'g' and then any number of characters

LastName	Position
Berg		1
Berge		1
Berge		1
Berger		1
Berger		1
Bergin		1
Berglund	1
Berglund	1
Berry		1
Berry		1
Berry		1

**********************************************************************************************************/


--2
SELECT 
	LastName
	,PATINDEX('%r%', LastName) AS Position
FROM Person.Person
WHERE PATINDEX('%r%', LastName) > 0;



/******** NOTES *******************************************************************************************
--Query 2 will return any row that has the letter 'r'.

LastName		Position
Abercrombie		4
Abercrombie		4
Abercrombie		4
Abolrous		5
Abolrous		5
Ackerman		5
Ackerman		5
Aguilar			7
Ahlering		5
Akers			4
Akers			4
Akers			4
Alberts			5
Alberts			5
**********************************************************************************************************/