--Full-Text Search

--Using CONTAINS
--1
SELECT
	FileName
FROM Production.Document
WHERE CONTAINS(Document, 'important');

--2
SELECT
	FileName
FROM Production.Document
WHERE CONTAINS(Document, ' "service guidelines" ');

--Using CONTAINS with Multiple terms
--3
SELECT
	FileName
FROM Production.Document
WHERE CONTAINS(DocumentSummary, 'bicycle AND reflectors');

--4
SELECT
	FileName
FROM Production.Document
WHERE CONTAINS(Document, 'important AND "service guidelines"');


/******** NOTES *******************************************************************************************
Query 1 - Returns any row in which the Document contains the word 'important'.

Query 2 - Returns any row in which teh Document contains the PHRASE 'service guidelines'
		  Note: The use of "" signifies searching for a phrase

Query 3 - Returns any rows in which the Document Summary contains the words 'bicycle' and 'reflectors'
		  Note: they do not have to be adjecent.

Query 4 - Returns any rows in which the Document contains the word 'important' and the phrase 'service guidelines'

**********************************************************************************************************/

--FREETEXT
--1
SELECT
	FileName
	,DocumentSummary
FROM Production.Document
WHERE FREETEXT(DocumentSummary, 'provides');


/******** NOTES *******************************************************************************************
Query 1 - Notice the first returned row does not contain an exact match for 'provided', instead it matched
		  on the occurance of the similar word 'provided'

**********************************************************************************************************/