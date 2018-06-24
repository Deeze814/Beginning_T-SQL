--XML Modify Method

--Create XML document
DECLARE @x xml =
'<Product ProductID = "521487">
  <ProductType>Paper Towels</ProductType>
  <Price>15</Price>
  <Vendor>Johnson Paper</Vendor>
  <VendorID>47</VendorID>
  <QuantityOnHand>500</QuantityOnHand>
</Product>';

--Show the XML Document contents
SELECT @x;

--INSERT: query: Inserting data into xml with the modify method 
SET @x.modify('
insert <WarehouseID>77</WarehouseID>
into (/Product)[1]'); --I initially ran this with INSERT and INTO as Capitalized but that threw an error, the lower case version worked...¯\_(ツ)_/¯

--Get the modified contents post INSERT query
SELECT @x;

--UPDATE: updating xml with the modify method 
SET @x.modify('
replace value of (/Product/QuantityOnHand[1]/text())[1] 
with "250"'); 

--Get modified contents post UPDATE
SELECT @x; 

--DELETE: deleting xml with the modify method 
SET @x.modify('
delete (/Product/Price)[1]');

--Get modified contents post DELETE
SELECT @x;

/******** NOTES *******************************************************************************************
--First, unmodified version output:
		<Product ProductID="521487">
		  <ProductType>Paper Towels</ProductType>
		  <Price>15</Price>
		  <Vendor>Johnson Paper</Vendor>
		  <VendorID>47</VendorID>
		  <QuantityOnHand>500</QuantityOnHand>
		</Product>

--INSERT:	Inserted a new nested 'WarehouseID' element under the first product element
	Output:
			<Product ProductID="521487">
			  <ProductType>Paper Towels</ProductType>
			  <Price>15</Price>
			  <Vendor>Johnson Paper</Vendor>
			  <VendorID>47</VendorID>
			  <QuantityOnHand>500</QuantityOnHand>
			  <WarehouseID>77</WarehouseID>
			</Product>

--UPDATE	Gets the First product element's 'QuantityOnHand' sub-element and then gets the 
			'QuantityOnHand' value via text(). Then replaces it with 250
	Output:
			<Product ProductID="521487">
			  <ProductType>Paper Towels</ProductType>
			  <Price>15</Price>
			  <Vendor>Johnson Paper</Vendor>
			  <VendorID>47</VendorID>
			  <QuantityOnHand>250</QuantityOnHand>
			  <WarehouseID>77</WarehouseID>
			</Product>

--DELETE:	Deletes the nested element 'Price' of the first 'Product' element
	Output:
			<Product ProductID="521487">
			  <ProductType>Paper Towels</ProductType>
			  <Vendor>Johnson Paper</Vendor>
			  <VendorID>47</VendorID>
			  <QuantityOnHand>250</QuantityOnHand>
			  <WarehouseID>77</WarehouseID>
			</Product>

**********************************************************************************************************/



