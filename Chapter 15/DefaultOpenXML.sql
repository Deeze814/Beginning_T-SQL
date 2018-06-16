--Using OPENXML with default column names (edge table format)

--Create a sample XML doc
DECLARE @hdoc int;
DECLARE @doc varchar(1000) = N'
<Products>
<Product ProductID="32565451" ProductName="Bicycle Pump">
   <Order ProductID="32565451" SalesID="5" OrderDate="2011-07-04T00:00:00">
      <OrderDetail OrderID="10248" CustomerID="22" Quantity="12"/>
      <OrderDetail OrderID="10248" CustomerID="11" Quantity="10"/>
   </Order>
</Product>
<Product ProductID="57841259" ProductName="Bicycle Seat">
   <Order ProductID="57841259" SalesID="3" OrderDate="2011-015-16T00:00:00">
         <OrderDetail OrderID="54127" CustomerID="72" Quantity="3"/>
   </Order>
</Product>
</Products>';

--Load the doc into memory
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc;

--Parse the XML into a rowset (shredding)
SELECT *
FROM OPENXML(@hdoc, N'/Products/Product');

--Remove the document from memory
EXEC sp_xml_removedocument @hdoc;

/******** NOTES *******************************************************************************************
--Sample output
id	parentid	nodetype	localname	prefix	namespaceuri	datatype	prev	text
2	0			1			Product		NULL	NULL			NULL		NULL	NULL
3	2			2			ProductID	NULL	NULL			NULL		NULL	NULL
28	3			3			#text		NULL	NULL			NULL		NULL	32565451
4	2			2			ProductName	NULL	NULL			NULL		NULL	NULL
29	4			3			#text		NULL	NULL			NULL		NULL	Bicycle Pump
5	2			1			Order		NULL	NULL			NULL		NULL	NULL
6	5			2			ProductID	NULL	NULL			NULL		NULL	NULL
30	6			3			#text		NULL	NULL			NULL		NULL	32565451
7	5			2			SalesID		NULL	NULL			NULL		NULL	NULL
31	7			3			#text		NULL	NULL			NULL		NULL	5


**********************************************************************************************************/