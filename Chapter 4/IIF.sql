
SELECT IIF( 50 > 20, 'TRUE', 'FALSE') AS RESULT; --TRUE

DECLARE 
	 @a INT = 50
	,@b INT = 20;	
SELECT IIF( @a > @b, 'TRUE', 'FALSE') AS RESULT; --TRUE
