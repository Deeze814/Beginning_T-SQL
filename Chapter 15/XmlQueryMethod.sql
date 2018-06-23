--XML QUERY Method

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

--Query 1: View the data in the temp table
SELECT * FROM #Bikes;

--Query 2: Now use the Query method to find a partiuclar node's value (In this case it is the ListPrice element)
SELECT 
	ProductID
	,ProductDescription.query('Product/ListPrice') AS ListPrice
FROM #Bikes;

DROP TABLE #Bikes;

/******** NOTES *******************************************************************************************
--Sample output from Query 1:

ProductID	ProductDescription
749			<Product><ProductID>749</ProductID><Name>Road-150 Red, 62</Name><Color>Red</Color><Size>62</Size><ListPrice>3578.2700</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>
750			<Product><ProductID>750</ProductID><Name>Road-150 Red, 44</Name><Color>Red</Color><Size>44</Size><ListPrice>3578.2700</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>
751			<Product><ProductID>751</ProductID><Name>Road-150 Red, 48</Name><Color>Red</Color><Size>48</Size><ListPrice>3578.2700</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>
752			<Product><ProductID>752</ProductID><Name>Road-150 Red, 52</Name><Color>Red</Color><Size>52</Size><ListPrice>3578.2700</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>
753			<Product><ProductID>753</ProductID><Name>Road-150 Red, 56</Name><Color>Red</Color><Size>56</Size><ListPrice>3578.2700</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>
754			<Product><ProductID>754</ProductID><Name>Road-450 Red, 58</Name><Color>Red</Color><Size>58</Size><ListPrice>1457.9900</ListPrice><BikeSubCategory>Road Bikes</BikeSubCategory></Product>


	--Formated value for ProductID 749 ProductDescription:
	<Product>
	  <ProductID>749</ProductID>
	  <Name>Road-150 Red, 62</Name>
	  <Color>Red</Color>
	  <Size>62</Size>
	  <ListPrice>3578.2700</ListPrice>
	  <BikeSubCategory>Road Bikes</BikeSubCategory>
	</Product>

--Sample output for Query 2:
ProductID	ListPrice
749			<ListPrice>3578.2700</ListPrice>
750			<ListPrice>3578.2700</ListPrice>
751			<ListPrice>3578.2700</ListPrice>
752			<ListPrice>3578.2700</ListPrice>
753			<ListPrice>3578.2700</ListPrice>
754			<ListPrice>1457.9900</ListPrice>
**********************************************************************************************************/