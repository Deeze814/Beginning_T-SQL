--Namespaces

--Query 1: Look at the XML columd of the Store table
SELECT Demographics FROM Sales.Store;

--Query 2: 
SELECT Demographics.query
(
	'declare namespace ss = "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	<Store AnnualSales = "{ /ss:StoreSurvey/ss:AnnualSales }"
		BankName = "{ /ss:StoreSurvey/ss:BankName }" /> 
') AS Result
FROM Sales.Store;


/******** NOTES *******************************************************************************************
Query 1:	Looking at the sample output from the first record of Query 1

			<StoreSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey">
			  <AnnualSales>800000</AnnualSales>
			  <AnnualRevenue>80000</AnnualRevenue>
			  <BankName>United Security</BankName>
			  <BusinessType>BM</BusinessType>
			  <YearOpened>1996</YearOpened>
			  <Specialty>Mountain</Specialty>
			  <SquareFeet>21000</SquareFeet>
			  <Brands>2</Brands>
			  <Internet>ISDN</Internet>
			  <NumberEmployees>13</NumberEmployees>
			</StoreSurvey>

			--Note the 'StoreSurvey' elment is namespaced with the 'xmlns' attribute

Query 2:	
			Step 1:	First the query has to idenfity each 'StoreSurvey' element by identifying the schema under
					which the StoreSurvey is typed (http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey)

			Step 2:	The query will produce XML in which the only element will be the element will be 'Store'
					due to the query defining that as the element we are inputing the quried values within
					(Line 10 where the XML hardcodes <Store ....>)

			Step 3: Shred the XML of the Demographics column within the Stores.Store table and for each row
					crate a new XML document with a single top level element (Store) and each Store element
					having two attributes (AnnualSales & BankName) that take the values of the shredded XML
					document's elements of the same name.

	--Sample output from Query 2
	<Store AnnualSales="800000" BankName="United Security" />
	<Store AnnualSales="800000" BankName="International Bank" />
	<Store AnnualSales="800000" BankName="Primary Bank &amp; Reserve" />

**********************************************************************************************************/


--1
DECLARE @values NVARCHAR(30) = N'Bike,Seat,Pedals,Basket';

--2
DECLARE @XML XML;

--3
SELECT @XML = '<item>' + REPLACE(@values,',','</item><item>') + '</item>';

--4
SELECT @XML;

--5
SELECT I.Product.value('.','NVARCHAR(10)') AS Item
FROM @XML.nodes('/item') AS I(Product);