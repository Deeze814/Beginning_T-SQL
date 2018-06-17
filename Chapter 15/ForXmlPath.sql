--FOR XML PATH mode

--Default element-centric style
SELECT TOP(3) 
	p.FirstName
    ,p.LastName 
    ,s.Bonus
    ,s.SalesYTD
FROM Person.Person p
JOIN Sales.SalesPerson s ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY SalesYTD DESC
FOR XML PATH;

/******** NOTES *******************************************************************************************
--Output
<row>
  <FirstName>Linda</FirstName>
  <LastName>Mitchell</LastName>
  <Bonus>2000.0000</Bonus>
  <SalesYTD>4251368.5497</SalesYTD>
</row>
<row>
  <FirstName>Jae</FirstName>
  <LastName>Pak</LastName>
  <Bonus>5150.0000</Bonus>
  <SalesYTD>4116871.2277</SalesYTD>
</row>
<row>
  <FirstName>Michael</FirstName>
  <LastName>Blythe</LastName>
  <Bonus>4100.0000</Bonus>
  <SalesYTD>3763178.1787</SalesYTD>
</row>

**********************************************************************************************************/



--Mixing element and attribute centric styles
SELECT TOP(3) 
	p.FirstName "@FirstName"
    ,p.LastName "@LastName"
    ,s.Bonus "Sales/Bonus" 
    ,s.SalesYTD "Sales/YTD"
FROM Person.Person p
JOIN Sales.SalesPerson s ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY s.SalesYTD DESC
FOR XML PATH;

/******** NOTES *******************************************************************************************
--Output
<row FirstName="Linda" LastName="Mitchell">
  <Sales>
    <Bonus>2000.0000</Bonus>
    <YTD>4251368.5497</YTD>
  </Sales>
</row>
<row FirstName="Jae" LastName="Pak">
  <Sales>
    <Bonus>5150.0000</Bonus>
    <YTD>4116871.2277</YTD>
  </Sales>
</row>
<row FirstName="Michael" LastName="Blythe">
  <Sales>
    <Bonus>4100.0000</Bonus>
    <YTD>3763178.1787</YTD>
  </Sales>
</row>

**********************************************************************************************************/


--Using the @ and / notations to build XML documents
SELECT TOP(5) 
	ProductID "@ProductID" --will be an attribute due to @
    ,[Name] "Product/ProductName" --will be a new nested element under Product due to /
    ,Color "Product/Color"--will be a new nested element under Product due to /
FROM Production.Product
ORDER BY ProductID 
FOR XML PATH ('Product');

/******** NOTES *******************************************************************************************
--Output
<Product ProductID="1">
  <Product>
    <ProductName>Adjustable Race</ProductName>
  </Product>
</Product>
<Product ProductID="2">
  <Product>
    <ProductName>Bearing Ball</ProductName>
  </Product>
</Product>
<Product ProductID="3">
  <Product>
    <ProductName>BB Ball Bearing</ProductName>
  </Product>
</Product>
<Product ProductID="4">
  <Product>
    <ProductName>Headset Ball Bearings</ProductName>
  </Product>
</Product>
<Product ProductID="316">
  <Product>
    <ProductName>Blade</ProductName>
  </Product>
</Product>
**********************************************************************************************************/