--FOR XML AUTO mode

--Attribute-Centric document
SELECT TOP(5) 
	Customer.CustomerID
	,Person.LastName
	,Person.FirstName
	,Person.MiddleName
FROM Person.Person Person
JOIN Sales.Customer Customer ON Person.BusinessEntityID = Customer.PersonID
ORDER BY Customer.CustomerID
FOR XML AUTO;

/******** NOTES *******************************************************************************************
--Output
<Customer CustomerID="11000">
  <Person LastName="Yang" FirstName="Jon" MiddleName="V" />
</Customer>
<Customer CustomerID="11001">
  <Person LastName="Huang" FirstName="Eugene" MiddleName="L" />
</Customer>
<Customer CustomerID="11002">
  <Person LastName="Torres" FirstName="Ruben" />
</Customer>
<Customer CustomerID="11003">
  <Person LastName="Zhu" FirstName="Christy" />
</Customer>
<Customer CustomerID="11004">
  <Person LastName="Johnson" FirstName="Elizabeth" />
</Customer>

**********************************************************************************************************/


--Element-Centric document
SELECT TOP(3) 
	CustomerID
	,LastName
	,FirstName
	,MiddleName
FROM Person.Person Person
INNER JOIN Sales.Customer Customer ON Person.BusinessEntityID = Customer.PersonID
ORDER BY CustomerID
FOR XML AUTO, ELEMENTS;

/******** NOTES *******************************************************************************************
--Output

<Customer>
  <CustomerID>11000</CustomerID>
  <Person>
    <LastName>Yang</LastName>
    <FirstName>Jon</FirstName>
    <MiddleName>V</MiddleName>
  </Person>
</Customer>
<Customer>
  <CustomerID>11001</CustomerID>
  <Person>
    <LastName>Huang</LastName>
    <FirstName>Eugene</FirstName>
    <MiddleName>L</MiddleName>
  </Person>
</Customer>
<Customer>
  <CustomerID>11002</CustomerID>
  <Person>
    <LastName>Torres</LastName>
    <FirstName>Ruben</FirstName>
  </Person>
</Customer>

**********************************************************************************************************/