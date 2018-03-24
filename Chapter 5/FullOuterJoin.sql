--Going to create a table for the purpose of demostrating a full outer join
IF OBJECT_ID('Production.ProductColor') IS NOT NULL
BEGIN
	DROP TABLE Production.ProductColor;
END;

CREATE TABLE Production.ProductColor
(
	 Color VARCHAR(15) NOT NULL PRIMARY KEY
);
GO --Execute current SQL in the buffer to then execute the next batch of statmentes

--Insert most existing colors
INSERT INTO Production.ProductColor
SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT NULL
 AND Color <> 'Silver';


 --Insert additional colors
 INSERT INTO Production.ProductColor(Color)
 VALUES('Green'), ('Orange'), ('Purple');

 --Now look at the results of a full outer join
 SELECT TOP(10)
	c.Color AS 'Color from list'
	,p.Color AS 'Product color'
	,p.ProductID
FROM Production.Product p
FULL JOIN Production.ProductColor c ON p.Color = c.Color
ORDER BY p.ProductID;

/*
Color from list		Product color	ProductID
Green				NULL			NULL
Orange				NULL			NULL
Purple				NULL			NULL
NULL				NULL			1
NULL				NULL			2
NULL				NULL			3
NULL				NULL			4
NULL				NULL			316
Black				Black			317
Black				Black			318
*/