--CUBE and ROLLUP functions

--Look at the Product table
SELECT * FROM Production.Product;

--1
SELECT 
	COUNT(*) AS CountOfRows
	,ISNULL(Color,CASE 
					WHEN GROUPING(Color) = 0 THEN 'UNK' 
					ELSE 'ALL' 
				  END) AS Color --When row's Color is NULL, use 'UNK' if the record is in the first group. Otherwise, use 'ALL'
	,ISNULL(Size,CASE 
					WHEN GROUPING(Size) = 0 THEN 'UNK' 
					ELSE 'ALL' 
				 END) AS Size   --When row's Size is NULL, 'UNK' if the record is in the first grouping. Otherwise, use 'ALL'
FROM Production.Product     
GROUP BY CUBE(Color,Size)    
ORDER BY Size, Color; --This query will group all records that hae the same size value, and then partition the records with the same size value into buckets based on color     
  
--2    
SELECT 
	COUNT(*) AS CountOfRows
	,ISNULL(Color,CASE 
					WHEN GROUPING(Color) = 0 THEN 'UNK'  --When this table row has a NULL color value, represent this table row's color value as 'UNK'
					ELSE 'ALL'  --When this row is row resulting from the application of the CUBE/ROLLUP (GROUPING(COLOR) != 0) and is NULL, represent it's color value as 'ALL'
				  END) AS Color
	,ISNULL(Size,CASE 
					WHEN GROUPING(Size) = 0 THEN 'UNK' 
					ELSE 'ALL' 
				 END) AS Size    
FROM Production.Product    
GROUP BY ROLLUP(Color,Size)    
ORDER BY Size, Color;  

/******** NOTES *******************************************************************************************
IMPORTANT:	The GROUPING function will return a 1 if it is a summary row or 0 if its not. GROUPING is used 
			to distinguish the null values that are returned by ROLLUP, CUBE or GROUPING SETS from standard 
			null values. The NULL returned as the result of a ROLLUP, CUBE or GROUPING SETS operation is a
			special use of NULL. This acts as a column placeholder in the result set and means all.

			Basically, the CUBE or ROLLUP function is going to show you a record that is an aggreate of column
			values it is looking at. If the current row is a resultof the CUBE or ROLLUP function, then 
			GROUPING(<column>) will be 1, if the row is just the result of a natural table row, then its 
			grouping value is 0.

			https://docs.microsoft.com/en-us/sql/t-sql/functions/grouping-transact-sql?view=sql-server-2017 

--Query 1:	This query will group all records that hae the same size value, and then partition the records with 
			the same size value into buckets based on color. The CountOfRows will tell you how many records with 
			the current partition's size have a particular color
	CountOfRows		Color		Size
	12				ALL			38		--5 Black + 5 Silver +  2 Yellow = 10 All
	5				Black		38
	5				Silver		38
	2				Yellow		38
	11				ALL			40
	4				Black		40
	4				Silver		40
	3				Yellow		40
	15				ALL			42
	5				Black		42
	7				Silver		42
	3				Yellow		42
	29				ALL			44
	11				Black		44
	2				Blue		44
	7				Red			44
	4				Silver		44
	5				Yellow		44


Query 2:	Notice that this query lacks sub-total rows for size 38 & 40 (sub-total rows denoted by ALL value).
			Since Rollup is only considering groups with respect to the COLOR column but not SIZE. This means we
			only see the total number of products with a particular size/color combination. We do not calculate 
			how many overall products fall within the same SIZE value (we would need to calcualte aggregate totals
			on both COLOR and SIZE using CUBE).

	CountOfRows	Color		Size
	5			Black		38
	5			Silver		38
	2			Yellow		38
	4			Black		40
	4			Silver		40
	3			Yellow		40
	5			Black		42
	7			Silver		42
	3			Yellow		42
	11			Black		44
	2			Blue		44
	7			Red			44
	4			Silver		44
	5			Yellow		44

**********************************************************************************************************/