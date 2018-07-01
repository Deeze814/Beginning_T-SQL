--Geometry

--Drop Demo table
IF OBJECT_ID('dbo.GeometryData') IS NOT NULL BEGIN        
	DROP TABLE dbo.GeometryData;    
END;       

--Create Demo table 
CREATE TABLE dbo.GeometryData 
(        
	Point1 GEOMETRY
	,Point2 GEOMETRY
	,Line1 GEOMETRY
	,Line2 GEOMETRY
	,Polygon1 GEOMETRY
	,Polygon2 GEOMETRY
);  
     
--Insert new GEOMETRY types into the table
INSERT INTO dbo.GeometryData 
(
	Point1
	,Point2
	,Line1
	,Line2
	,Polygon1
	,Polygon2
)    
VALUES 
(       
	GEOMETRY::Parse('Point(1 4)'),        
	GEOMETRY::Parse('Point(2 5)'),        
	GEOMETRY::Parse('LineString(1 4, 2 5)'),        
	GEOMETRY::Parse('LineString(4 1, 5 2, 7 3, 10 6)'),        
	GEOMETRY::Parse('Polygon((1 4, 2 5, 5 2, 0 4, 1 4))'),        
	GEOMETRY::Parse('Polygon((1 4, 2 7, 7 2, 0 4, 1 4))')
);   
    
--QUERY 1: View the Data
SELECT 
	Point1.ToString() AS Point1
	,Point2.ToString() AS Point2
	,Line1.ToString() AS Line1
	,Line2.ToString() AS Line2
	,Polygon1.ToString() AS Polygon1
	,Polygon2.ToString() AS Polygon2    
FROM dbo.GeometryData;       

--QUERY 2: View the data using built in functions that operate on the GEOMETRY type
SELECT 
	Point1.STX AS Point1X
	,Point1.STY AS Point1Y
	,Line1.STIntersects(Polygon1) AS Line1Poly1Intersects
	,Line1.STLength() AS Line1Len
	,Line1.STStartPoint().ToString() AS Line1Start
	,Line2.STNumPoints() AS Line2PtCt
	,Polygon1.STArea() AS Poly1Area
	,Polygon1.STIntersects(Polygon2) AS Poly1Poly2Intersects    
FROM dbo.GeometryData;  

/******** NOTES *******************************************************************************************
QUERY 1 output:
Point1			Point2			Line1					Line2								Polygon1								Polygon2
POINT (1 4)		POINT (2 5)		LINESTRING (1 4, 2 5)	LINESTRING (4 1, 5 2, 7 3, 10 6)	POLYGON ((1 4, 2 5, 5 2, 0 4, 1 4))		POLYGON ((1 4, 2 7, 7 2, 0 4, 1 4))


QUERY 2 output:
Point1X		Point1Y	Line1Poly1Intersects	Line1Len			Line1Start		Line2PtCt	Poly1Area	Poly1Poly2Intersects
1			4		1						1.4142135623731		POINT (1 4)		4			4			1
**********************************************************************************************************/