--DateTimeOffset

--Drop table
IF OBJECT_ID('dbo.OffsetDemo') IS NOT NULL BEGIN        
	DROP TABLE dbo.OffsetDemo;    
END; 
     
--Create demo table with data type DATETIMEOFFSET
CREATE TABLE dbo.OffsetDemo(Date1 DATETIMEOFFSET);          

--Insert values
INSERT INTO dbo.OffsetDemo(Date1)    
VALUES 	(SYSDATETIMEOFFSET())	--This function returns the date and time on the server along with the time zone offset (from UTC)
		,(SWITCHOFFSET(SYSDATETIMEOFFSET(),'+00:00'))
		,(SWITCHOFFSET(SYSDATETIMEOFFSET(),'-01:00'))
		,(TODATETIMEOFFSET(SYSDATETIME(),'+05:00'));       

--View the values
SELECT Date1 FROM dbo.OffsetDemo;

/******** NOTES *******************************************************************************************

--Output:
Date1
2018-07-01 13:15:41.6663754 -05:00
2018-07-01 18:15:41.6663754 +00:00
2018-07-01 13:15:41.6663754 +05:00


--Explaination:
(1)	SYSDATETIMEOFFSET() -							This shows as a -05:00 besid the value, which is because I ran the query on my computer which
													is in the Central timezone During the daylight savings time offset so central is 5 hours behind
													UTC at the time this query was run (7/1/2018)
	
(2) SWITCHOFFSET(SYSDATETIMEOFFSET(),'+00:00') -	This uses the SWITCHOFFSET function to swap the value that would be used (based on server location)
													to instead use the timezone offset specified with the second argument. This particular example is 
													switching from the Central timezone (server default) to the UTC time zone (as denoted by +00:00).
													The result is that we add the 5 hours to the date since it would be calculated using Central time
													and that is 5 hours behind the specified timezone.

(3) TODATETIMEOFFSET(SYSDATETIME(),'+05:00')) -		This uses the TODATETIMEOFFSET function which will take the calulated time value (as calculated by
													server's timezone) and will store that time as the time in a different timezone. The timezone the 
													record is to have is specified in the second argument. In this example we calculate the time of the 
													server to be 13:23 (1:23 PM). Then we say we want to store this time value in the DB but we want to 
													store the time with a timezone that is 5 hours AHEAD of UTC. This means the time recorded in the 
													database would represent 1:23 PM in YEKT time (Yekaterinburg Time) which is +5 hours ahead of UTC

**********************************************************************************************************/