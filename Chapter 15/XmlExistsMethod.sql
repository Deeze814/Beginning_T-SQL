--XML Exist Method

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

--Using exist to filter down the elements that match its predicate statement and then return those elements values
SELECT ProductID, 
    ProductDescription.value('(/Product/ListPrice)[1]', 'MONEY') AS ListPrice
FROM #Bikes
WHERE ProductDescription.exist('/Product/ListPrice[text()[1] lt 3000]') = 1;

DROP TABLE #Bikes;

/******** NOTES *******************************************************************************************
Sample Output:
ProductID	ListPrice
754			1457.99
755			1457.99
756			1457.99
757			1457.99
758			1457.99
759			782.99
760			782.99

**********************************************************************************************************/



/*~~~~~ Working with Dates and Exists ~~~~~*/

--XML with attribute based date value
DECLARE @test1 XML = '
<root>
    <Product ProductID="123" LastOrderDate="2014-06-02"/>
</root>';

--XML with nested element based date value
DECLARE @test2 XML = '
<root>
    <Product>
	    <ProductID>123</ProductID>
		<LastOrderDate>2014-06-02</LastOrderDate>
	</Product>
</root>';

--Query 1:
SELECT @test1.exist('/root/Product[(@LastOrderDate cast as xs:date?) eq xs:date("2014-06-02")]');

--Query 2:
SELECT @test2.exist('/root/Product/LastOrderDate[(text()[1] cast as xs:date?) eq xs:date("2014-06-02")]');


/******** NOTES *******************************************************************************************
--Both of the queries return 1 since the 'LastOrderDate' of both XML documents are 2014-06-02

--Query 1	Has to use the '@' syntax to pull the attribute and then cast its value as a date using the 'xs:date'
			notation. Then it will compare that to the sought after date value, which also must be cast from its
			string verion to the appropriate XML casted value.

--Query 2	Uses the text() function to pull the element value. It must specify the index of the value ([1])
			and then also cast the returned value to a date.

**********************************************************************************************************/