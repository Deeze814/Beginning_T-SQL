--XML Value Method

--Create Temp table
CREATE TABLE #Bikes(ProductID INT, ProductDescription XML);

--Populate #Bikes with an XML description of each unique product ID
INSERT INTO #Bikes(ProductID, ProductDescription)
SELECT 
	ProductID
	,( 
		SELECT --This will produce the Information for each unique product ID 
			ProductID
			,Product.Name
			,Color
			,Size
			,ListPrice
			,sc.Name AS BikeSubCategory
		FROM Production.Product AS Product
		JOIN Production.ProductSubcategory sc ON Product.ProductSubcategoryID = sc.ProductSubcategoryID
		JOIN Production.ProductCategory c ON sc.ProductCategoryID = c.ProductCategoryID
		WHERE Product.ProductID = Prod.ProductID
		FOR XML RAW('Product'), ELEMENTS --This will take the values of each of the columns and create a new sub-element (ProductID, Name, Color, etc...) under the Parent (Product) element.
	 ) AS ProdXML --This Column in the select is actually a Correlated subquery
FROM Production.Product Prod
JOIN Production.ProductSubcategory sc ON Prod.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN Production.ProductCategory c ON sc.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bikes';

--Select the list price for each row
SELECT ProductID, 
    ProductDescription.value('(/Product/ListPrice)[1]', 'MONEY') AS ListPrice
FROM #Bikes;

DROP TABLE #Bikes;

/******** NOTES *******************************************************************************************
--We have to specify the [1] even though each row only has one occurance of the 'ListPrice' element
Sample Output:
ProductID	ListPrice
749			3578.27
750			3578.27
751			3578.27
752			3578.27
753			3578.27
754			1457.99
755			1457.99
756			1457.99

**********************************************************************************************************/


--Using the XML Value Method when the XML conatins attributes instead of nested elements
DECLARE @test XML = '
<root>
	<Product ProductID="123" Name="Road Bike"/>
	<Product ProductID="124" Name="Mountain Bike"/>
</root>';

SELECT @test.value('(/root/Product/@Name)[2]','NVARCHAR(25)') AS ProductName;--Get the Name from the Second Product (second product denoted with the [2])

/******** NOTES *******************************************************************************************
Output:
ProductName
Mountain Bike

**********************************************************************************************************/