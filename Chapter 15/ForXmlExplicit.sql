--FOR XML EXPLICIT mode

--
SELECT TOP(5) 
	   1		  AS Tag,
       NULL       AS Parent,
       CustomerID AS [Customer!1!CustomerID],
       NULL       AS [Name!2!FName],
       NULL       AS [Name!2!LName]
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P
ON  P.BusinessEntityID = C.PersonID
UNION 
SELECT TOP(5) 
	   2 AS Tag,
       1 AS Parent,
       CustomerID,
       FirstName,
       LastName
FROM Person.Person P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY [Customer!1!CustomerID], [Name!2!FName]
FOR XML EXPLICIT;

/******** NOTES *******************************************************************************************
--Output
<Customer CustomerID="11000">
  <Name FName="Jon" LName="Yang" />
</Customer>
<Customer CustomerID="11001">
  <Name FName="Eugene" LName="Huang" />
</Customer>
<Customer CustomerID="11002">
  <Name FName="Ruben" LName="Torres" />
</Customer>
<Customer CustomerID="11003">
  <Name FName="Christy" LName="Zhu" />
</Customer>
<Customer CustomerID="11004">
  <Name FName="Elizabeth" LName="Johnson" />
</Customer>

**********************************************************************************************************/