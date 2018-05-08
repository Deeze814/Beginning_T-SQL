--Restricting results via pattern matching

--Using range with hyphen
SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'Cho[i-k]';

--Using range by exhaustivly specifying the valid range
SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'Cho[ijk]';

--Using range to exclude certain pattern matches
SELECT DISTINCT LastName
FROM Person.Person
WHERE LastName LIKE 'Cho[^i]';


/******** NOTES *******************************************************************************************
--Query 1: returns 1 record --> Choi
--Query 2: returns 1 record --> Choi
--Query 3: returns 2 records --> Chor, Chow

**********************************************************************************************************/