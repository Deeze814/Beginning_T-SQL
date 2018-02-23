--Simple Concat Function
SELECT CONCAT('Haters ', 'say', ' Dre', ' fell off!');

--Using variables with CONCAT
DECLARE @a VARCHAR(30) = 'My cake day is ';
DECLARE @b DATE = '08/14/1984';
SELECT CONCAT(@a,@b) AS RESULT;

--Using CONCAT with table rows
SELECT CONCAT (AddressLine1, PostalCode) AS Address
FROM Person.Address;

--Using CONCAT with NULL
SELECT CONCAT('Dre is like ', 'the CONCAT',' function, ', 
'Haters are like', NULL, ' NULL values.', NULL, ' Dre just ignores the haters') AS ThaTruf;