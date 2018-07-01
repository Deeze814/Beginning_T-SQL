--Geography

--Create variable of type GEOGRAPHY
DECLARE @OneAddress GEOGRAPHY;     
 
--Looking at the column on Person.Address
SELECT * FROM Person.Address WHERE AddressID IN (1,91, 831,11419); --SpatialLocation is a GEOGRAPHY type

--Set value from the Person.Address table
SELECT @OneAddress = SpatialLocation    
FROM Person.Address    
WHERE AddressID = 91;       

--Compare distance of address values
SELECT 
	a.AddressID,PostalCode
	,a.City
	,sp.Name AS State
	,a.SpatialLocation.ToString()
	,(@OneAddress.STDistance(a.SpatialLocation)) * 0.000621371 AS DiffInMiles
	,@OneAddress.STDistance(a.SpatialLocation) AS DiffInMeters    
FROM Person.Address a
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
WHERE a.AddressID IN (1,91, 831,11419);--Compare the address with other people's addresses


/******** NOTES *******************************************************************************************


**********************************************************************************************************/