
--Does not return any rows due to the NULL values in SalesOrderHeader
SELECT
	cr.CurrencyRateID
	,cr.FromCurrencyCode
	,cr.ToCurrencyCode
FROM Sales.CurrencyRate cr
WHERE cr.CurrencyRateID NOT IN
	(SELECT CurrencyRateID
	 FROM Sales.SalesOrderHeader);

--Returns 11018 rows since we elimate NULL from consideration in the subquery
SELECT
	cr.CurrencyRateID
	,cr.FromCurrencyCode
	,cr.ToCurrencyCode
FROM Sales.CurrencyRate cr
WHERE cr.CurrencyRateID NOT IN
	(SELECT CurrencyRateID
	 FROM Sales.SalesOrderHeader 
	 WHERE CurrencyRateID IS NOT NULL);



