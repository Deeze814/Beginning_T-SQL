--Paging

DECLARE @PageSize INT = 5    
		,@PageNo INT = 1;    
		
--Paging via Windowing functions (ROW_NUMBER)   
WITH cteProducts
AS
(        
	SELECT 
		ProductID
		,p.Name
		,Color
		,Size
		,ROW_NUMBER() OVER(ORDER BY p.Name, p.Color, p.Size) AS RowNum        
	FROM Production.Product p       
	JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID            
	JOIN Production.ProductCategory c ON s.ProductCategoryID = c.ProductCategoryID             
	WHERE c.Name = 'Bikes'    
)     
SELECT 
	TOP(@PageSize) ProductID
	,Name
	,Color
	,Size     
FROM cteProducts     
WHERE RowNum BETWEEN (@PageNo -1) * @PageSize + 1         
	AND @PageNo * @PageSize    
ORDER BY Name, Color, Size; 

--2    
SELECT 
	ProductID
	,p.Name
	,p.Color
	,p.Size    
FROM Production.Product p    
JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID    
JOIN Production.ProductCategory c ON s.ProductCategoryID = c.ProductCategoryID     
WHERE c.Name = 'Bikes'    
ORDER BY p.Name, Color, Size         
OFFSET @PageSize * (@PageNo -1) ROWS FETCH NEXT @PageSize ROWS ONLY; --Evaluates as (5 *(1-1)) = 0 Rows skiped (OFFSET), 5 rows returned (FETCH NEXT)...Results in rows 1-5

/******** NOTES *******************************************************************************************
--Both Queries produce:

ProductID	Name						Color	Size
772			Mountain-100 Silver, 42		Silver	42
773			Mountain-100 Silver, 44		Silver	44
774			Mountain-100 Silver, 48		Silver	48
782			Mountain-200 Black, 38		Black	38
783			Mountain-200 Black, 42		Black	42

**********************************************************************************************************/