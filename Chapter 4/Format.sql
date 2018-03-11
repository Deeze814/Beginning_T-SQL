DECLARE @d DATETIME = GETDATE();

SELECT FORMAT(@d, 'dd', 'en-US') AS 'Date(dd) with en-US culture'
	  ,FORMAT(@d, 'yyyy-M-d') AS 'Date with no culture specified'
	  ,FORMAT(@d, 'MM/dd/yyyy', 'en-US') AS 'Date(MM/dd/yyyy) with en-US culture';