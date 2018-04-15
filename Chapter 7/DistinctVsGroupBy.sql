--Using Distinct
SELECT DISTINCT SalesOrderID
FROM Sales.SalesOrderDetail; --31465

--Using Group BY
SELECT SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID; --31465

/********************************************* NOTES *********************************************
Query 1 and query 2 return identical results. Even though Query 2 does not contain an aggregate 
expression, it is still an aggregrate query because it contains a GROUP BY. By grouping on 
SalesOrderID, only the unique values show up in the returned rows.

SQL server will generally process both results the same way (check the execution plan of both).
It could be argued that since you were not interested in selecting any aggregate based information,
then you should avoid using the GROUP BY (as its intended use is with aggregrate queries). There are
others who say that DISTINCT should always be avoided (book never really said why).

So choose which approach is most efficent by comparing the execution plans for any (more costly) steps.

Looking through stackoverflow and a few other sites it seems that people prefer using GROUP BY when 
dealing with a table with alot of records (example cited several million rows), and using distinct when
no aggregation is occuring and the table data is not as large.
*************************************************************************************************/