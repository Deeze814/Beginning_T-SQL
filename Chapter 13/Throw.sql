--Using THROW for errors

 --Listing 13-9. Simple THROW Statement 
 THROW 999999, 'This is a test error.', 1;   


 -- Listing 13-10. Using THROW in a transaction 
BEGIN TRY    
	INSERT INTO Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)    
	VALUES (1, '697-555-0142', 1);    
END TRY    
BEGIN CATCH		
	THROW 999999, 'I will not allow you to insert a duplicate value.', 1;    
END CATCH; 

/******** NOTES *******************************************************************************************


**********************************************************************************************************/