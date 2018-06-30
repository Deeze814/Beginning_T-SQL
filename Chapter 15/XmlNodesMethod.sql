--XML Nodes Method

--Create the XML document
DECLARE @XML XML = '
<Product>
	<ProductID>749</ProductID>
	<ProductID>749</ProductID>
	<ProductID>750</ProductID>
	<ProductID>751</ProductID>
	<ProductID>752</ProductID>
	<ProductID>753</ProductID>
	<ProductID>754</ProductID>
	<ProductID>755</ProductID>
	<ProductID>756</ProductID>
	<ProductID>757</ProductID>
	<ProductID>758</ProductID>
</Product>';

--Shred the document by parsing each ProductID into a 'node' and then extracting its value via the VALUE method
SELECT P.ProdID.value('.', 'INT') as ProductID
FROM @XML.nodes('/Product/ProductID') P(ProdID);

/******** NOTES *******************************************************************************************
--Output

ProductID
749
749
750
751
752
753
754
755
756
757
758

**********************************************************************************************************/