--Island problem (aka Boundary identification)

--1 (Create new table)
CREATE TABLE #Island(col1 INT);

INSERT INTO #Island(col1)
VALUES(1),(2),(3),(5),(6),(7),(9),(9),(10);

--2 Query to show what the sequence value for each island will be when used in the (3) query's CTE
SELECT
	col1
	,DENSE_RANK() OVER(ORDER BY col1) AS RankNum
	,col1 - DENSE_RANK() OVER(ORDER BY col1) AS Diff
FROM #Island;

--3 Using the data in Query 2 as a CTE, determine the islands and their data ranges
WITH cteIslands AS
(
	SELECT
		col1
		,col1 - DENSE_RANK() OVER(ORDER BY col1) AS Diff
	FROM #Island
)
SELECT
	MIN(col1) AS Beginning 
	,MAX(col1) AS Ending
FROM cteIslands
GROUP BY Diff;

--4 (Drop the table)
DROP TABLE #Island;
/******** NOTES *******************************************************************************************
In query 2, we see that the difference bewteen the col1 value and its associated RankNum will indicate if 
we have any gaps in the sequence and are on a new "island". The gaps will result whenver we skip values in 
the sequence which will give us ever increasing Diff values that identify new islands.

Query 3 shows us each island's starting and ending vavlues as deterimined by the grouping of islands by the
calculated Diff column.

**********************************************************************************************************/