/**** Math Functions ****/

--ABS
SELECT 
	ABS(2) AS [Absolute value of 2], 
	ABS(-2) AS [Absolute value of -2];


--POWER
SELECT
	POWER(10,1) AS 'Ten to the first'
	,POWER(10,2) AS 'Ten to the second'
	,POWER(10,3) AS 'Ten to the third';

--SQUARE
SELECT SQUARE(10) AS '10 squared';

--Square root
SELECT SQRT(100) AS 'The square root of 100';

--Unseeded Rand
SELECT
	CAST(RAND() * 100 AS INT) + 1 AS '1 to 100',
	CAST(RAND() * 1000 AS INT) + 900 AS '900 TO 1900',
	CAST(RAND() * 5 AS INT) + 1 AS '1 TO 5';

--Seeded Rand
SELECT	RAND(3) AS 'RAND(3)', 
		RAND(3) AS 'RAND(3)', 
		RAND(5) AS 'RAND(5)', 
		RAND(5) AS 'RAND(5)',  
		RAND(7) AS 'RAND(7)', 
		RAND() AS 'Unseeded', 
		RAND() AS 'Unseeded';