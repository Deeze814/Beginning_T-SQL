SELECT
	 DB_NAME() AS 'Database Name'
	,HOST_NAME() AS 'Host Name'
	,CURRENT_USER AS 'Current User'
	,SUSER_NAME() AS 'Login'
	,USER_NAME() AS 'User Name'
	,APP_NAME() AS 'App Name';