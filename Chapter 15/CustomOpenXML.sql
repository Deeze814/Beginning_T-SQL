--Specifying custom columns

--Create sample XML file
DECLARE @hdoc int;
DECLARE @doc varchar(1000) = N'
<Products>
<Product ProductID="32565451" ProductName="Bicycle Pump">
   <Order ProductID="32565451" SalesID="5" OrderDate="2011-07-04">
      <OrderDetail OrderID="10248" CustomerID="22" Quantity="12"/>
      <OrderDetail OrderID="10248" CustomerID="11" Quantity="10"/>
   </Order>
</Product>
<Product ProductID="57841259" ProductName="Bicycle Seat">
   <Order ProductID="57841259" SalesID="3" OrderDate="2011-015-16">
      <OrderDetail OrderID="54127" CustomerID="72" Quantity="3"/>
   </Order>
</Product>
</Products>';

--Load the XML doc into memory
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc;

--Shred the XML and use custom column names
SELECT *
FROM OPENXML
(
	@hdoc
	,N'/Products/Product/Order/OrderDetail'
)
WITH 
(
	CustomerID INT '@CustomerID'
    ,ProductID INT '../@ProductID'
    ,ProductName VARCHAR(30) '../../@ProductName'
    ,OrderID INT '@OrderID'
    ,Orderdate VARCHAR(30) '../@OrderDate'
);

--Remove the document
EXEC sp_xml_removedocument @hdoc;



/******** NOTES *******************************************************************************************
--Output
CustomerID	ProductID	ProductName		OrderID		Orderdate
22		32565451		Bicycle Pump	10248		2011-07-04
11		32565451		Bicycle Pump	10248		2011-07-04
72		57841259		Bicycle Seat	54127		2011-015-16

**********************************************************************************************************/