--Seek Vs. Scan

/*** IMPORTANT: Be sure to click the 'Include Actual Execution Plan' in the above tool bar ***/

--1
SELECT 
	 LastName
	,FirstName
FROM Person.Person
WHERE LastName = 'Smith';

--2
SELECT 
	LastName
	,FirstName
FROM Person.Person
WHERE FirstName = 'Ken';

--3
SELECT ModifiedDate
FROM Person.Person
WHERE ModifiedDate BETWEEN '2005-01-01' AND '2005-01-31';

/** Results **


(0%) Query 1:	Because we filtered on LastName, the DB engine could take full advantage of the *non-clustered index* and 
				perform an *Index Seek*

(4%) Query 2:	Becuase we filtered on FirstName, the DB could still use the *non-clustered index*; however, we had to go		
				record by record performing an *Index Scan*

(96%) Query 3:	Becuase we filtered on ModifiedDate, we could not use the non-clustered index since ModifiedDate is not 
				a column contained within that index. This forced the DB engine to do an *Index Scan* on the *clustered*
				index, which is the actual Person.Person table itself. This means that it had to go through each record 
				in Person.Person and test for matching criteria
			

***************/

