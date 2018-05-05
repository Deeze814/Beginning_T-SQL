--Removing duplicate rows with ROW_NUMBER

--1
CREATE TABLE #dupes(col1 INT, col2 INT, col3 INT);
INSERT INTO #dupes(col1, col2, col3)
VALUES (1,1,1)
	  ,(1,1,1)
	  ,(1,2,3)
	  ,(1,2,2)
	  ,(1,2,2)
	  ,(2,3,3)
	  ,(2,3,3)
	  ,(2,3,3)
	  ,(2,3,3);


--2
SELECT
	col1
	,col2
	,col3
	,ROW_NUMBER() OVER (PARTITION BY col1, col2, col3 ORDER BY col1, col2, col3) AS RowNum
FROM #dupes;

--3
WITH cteDupes AS
(
	SELECT
		col1
		,col2
		,col3
		,ROW_NUMBER() OVER (PARTITION BY col1, col2, col3 ORDER BY col1, col2, col3) AS RowNum
	FROM #dupes
)
SELECT
	col1
	,col2
	,col3
FROM cteDupes
WHERE RowNum = 1;

--4
WITH cteDupes AS
(
	SELECT
		col1
		,col2
		,col3
		,ROW_NUMBER() OVER (PARTITION BY col1, col2, col3 ORDER BY col1, col2, col3) AS RowNum
	FROM #dupes
)
SELECT
	col1
	,col2
	,col3
FROM cteDupes
WHERE RowNum > 1;

--5
SELECT
	col1
	,col2
	,col3
FROM #dupes;

DROP TABLE #dupes;
/******** NOTES *******************************************************************************************
Query (1): Creats the table and duplicate data
Query (2): Selects the data and shows how each unique collection of rows produces a series of Row Numbers
Query (3): Shows how using the ROW_NUMBER in a CTE where ROW_NUMBER = 1 can be used to remove duplicate records
			over the rows based on the columns being considered
Query (4): Shows how many duplicate entries there are for each unique combination of the columns being considered
Query (5): Simple select to show all rows of the temp table

**********************************************************************************************************/