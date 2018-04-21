# Beginning T-SQL, 3rd Edition - Kathi Kellenberger and Scott Shaw (Apress, 2014)
Repository to hold notes/exercises from the book

## Chapter 1: Getting Started ##
### Getting Setup ###

<ol>
	<li>In order to practice the examples from the book, we will need to install SQL Server and the Adventure Works database
	<li><b>SQL Server Download</b></li>
		<ul>
			<li>I installed SQL Server 2017 Express <b>with Advanced Services</b> from https://www.microsoft.com/en-us/sql-server/sql-server-editions-express 
				<ul>
					<li>I had to login using my MSDN account (can create one free of charge)</li>
					<li>Then I clicked the <b>Join Visual Studio Dev Essentials</b> button and <b>Confirm</b> on the popup.</li>
					<li>I then clicked the <b>Downloads</b> tab at the top and selected <b>SQL Server 2017</b></li>
					<li>I clicked <b>Download</b> next to <b>SQL Server 2017 Express</b>
						<ul>
							<li>The download button gave two options and I chose <b>SQL Server 2017 Express with Advanced Services</b></li>
						</ul>
					</li>
					<li>I extracted the download to my User/Documents folder</li>
				</ul>
			</li>			
		</ul>
	</li>
	<li><b>SQL Server Installation </b>
		<ul>
			<li>Select the <b>New SQL Server stand-alone installation or add features to existing installation</b></li>
			<li>I left all the pre-checked options as they were under the <b>Feature Selection</b></li>
			<li>On <b>Instance Configuration</b>, I set the <b>Named Instance</b> and <b>Instance ID</b> to a value of <b>BEGINNING_TSQL</b>
				<ul>
					<li>This produced an Instance ID of <b>MSSQL14.BEGINNING_TSQL</b></li>
				</ul>
			</li>
			<li>On the <b>Database Engine Configuration</b>
				<ul>
					<li>Leave the <b>Authentication Mode </b>as <b>Windows authentication mode</b></li>
					<li>Click the <b>FILESTREAM</b> tab and check all 3 check-boxes</li>
				</ul>				
			</li>
		</ul>
	</li>
	<li><b>SSMS Installation</b>
		<ul>
			<li>Once installed, I pinned the SSMS 2017 icon to the taskbar and started the application.</li>
			<li>Once started, I clicked the <b>Server name</b> drop-down
				<ul>
					<li>Selected <b>browse for more</b></li>
					<li>Expanded <b>Database Engine</b></li>
					<li>I selected the entry that matched the <b>Instance Name</b> from the <b>SQL Server Installation</b> process above (<b>BEGINNING_TSQL</b>)</li>	
					<li><b>NOTE:</b> This step initially did not work for me, I had to do the following
						<ul>
							<li>In the start menu, I typed <b>SQL Server</b> and opened the <b>SQL Server Configuration Manager</b></li>
							<li>Under the <b>SQL Server Configuration Manager --> SQL Server Services</b> it lists all of the SQL Server instance you have installed on your machine</li>
							<li>I had a previous installation of SQL Service and it was the only one running.</li>
							<li>I clicked that instance and stopped it</li>
							<li>Then I clicked my SQL Server (matches the <b>instance name</b> from the installation process) and started it</li>
							<li>Back in SSMS, I could now choose my instance name under the database engine section and successfully connect. </li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Installing the <b>Adventures Works</b> test database
		<ul>
			<li>The book is a bit out-dated and it seems that Adventure Works has been moved to being archived</li>
			<li>A new <b>World Wide Importers</b> database is the most current, but since all examples in this book use <b>Adventure Works 2012</b>, I will as well</li>
			<li>I got the 2012 .bak for Adventure Works at: https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks </li>
			<li>Following the instructions for restoring a backup (https://github.com/Microsoft/sql-server-samples/blob/master/samples/databases/adventure-works/README.md#to-restore-a-database-backup)
				<ul>
					<li>Locate the Backup folder for your SQL Server instance. The default path for 64-bit SQL Server 2016 is C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup. The MSSQL value is MSSQL14 for SQL Server 2017, MSSQL13 for SQL Server 2016, MSSQL12 for SQL Server 2014, MSSQL11 for SQL Server 2012, and MSSQL10 for SQL Server 2008R2.</li>
					<li>Download the .bak file from AdventureWorks release and save it to the Backup folder for your SQL Server instance.</li>	
					<li>Open SQL Server Management Studio and connect to your SQL Server instance.</li>
					<li>Restore the database using the SQL Server Management Studio user interface.
						<ul>
							<li>In Object Explorer, connect to an instance of the SQL Server Database Engine and then expand that instance.</li>
							<li>Right-click Databases and select Restore Database...</li>
							<li>On the General page, use the <b>Source</b> section to specify the source and location of the backup sets to restore. Select one of the following options:
								<ul>
									<li>I had to select the <b>Device</b> option</li>
									<li>Then the <b>...</b> to browse to my downloaded .bak files after click <b>Add</b></li>									
								</ul>
							</li>
						</ul>
					</li>					
				</ul>
			</li>
		</ul>
	</li>
</ol>

## Chapter 2: Exploring Database Concepts ##
### File Types ###

<ol>
	<li>SQL Server Files
		<ul>
			<li>A SQL Server data must comprise at least two files
				<ul>
					<li><b>.mdf:</b> The default data file
						<ul>
							<li>Data files can be organized into multiple file groups</li>
							<li>File groups are use for strategically backing up only portions of the database at a time or store the data on different drives for increased performance.</li>
						</ul>
					</li>
					<li><b>.ldf:</b> The log file
						<ul>
							<li>The log file in SQL Server stores <b>transactions</b> to ensure data consistency</li>
							<li>DBA can take frequent backups of the log files to allow the database to be restored to a point in time in case of data corruption, disk failure, or other disaster</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

### Indexes ###

<ol>
	<li>Understanding Indexes
		<ul>
			<li>A <b>clustered index</b> stores and organizes the table
				<ul>
					<li>A table can have only one clustered index</li>
					<li>A phone book is a good example of a clustered index
						<ul>
							<li>Each entry in the directory represents one row of the table</li>
							<li>When a new entry is added, it is added to the correct <b>data page</b> relative to the other existing entries</li>
							<li>A list of pointers maintains order between the pages, so the rows in other pages will not have to actually move.</li>
							<li>In our phone book example, the phone number is the primary key but not the clustered index
								<ul>
									<li>Normally the primary key is the clustered index (it is by default if you dont specify)</li>
								</ul>
							</li>
							<li>Our clustered index is the <b>First/Last name</b> combination
								<ul>
									<li>You would seek the phone number you want by looking up the last name and then the first name
										<ul>
											<li>The process of using the First/Last name to locate a record would be a <b>clustered index seek</b></li>
										</ul>
									</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>A <b>non-clustered index</b> is defined on one or more columns of the table, but is is a <b>separate structure</b> that points to the actual table
				<ul>
					<li>The non-clustered index allows for a different sorting strategy for records in a table but the information of this sorting is stored apart from the actual table it is referencing (unlike the clustered index which is the primary sort strategy of the actual table.)</li>
					<li>A good example of a non-clustered index would be the index in the back of a book.</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

## Chapter 3: Writing Simple Select Queries ##
### Taking Advantage of Indexes ###

<ol>
	<li>Searching on Composite keys
		<ul>
			<li>When a table contains an <b>index</b> on a column, the database engine will usually use that index to find the rows for the results if the column appears in the WHERE clause</li>
			<li>When the index is a <b>composite key</b> (such as the Person.Person table's <b>IX_Person_LastName_FirstName_MiddleName</b>), the <b>WHERE</b> clause needs to filter on the first column declared in the composite index in order to take full advantage of the index's performance benefit
				<ul>
					<li>This is because the non-clustered index created on Last/First/Middle name has the rows organized around the <b>Last Name</b> value.</li>
					<li>Think about our phone book example, searching for a phone number and you only have the first name
						<ul>
							<li>SQL Server has to do the same thing, looking at the First Name value of each entry in the index</li>
							<li>This is still faster than doing a lookup against the clustered index (the actual table) because the non-clustered index contains less data per row (only Last/First/Middle name values)</li>
						</ul>
					</li>					
				</ul>
			</li>
		</ul>
	</li>
	<li>Seek Vs. Scan
		<ul>
			<li><b>Seek</b>
				<ul>
					<li>When the DB can quickly look at records to tell if they match the criteria of a query
						<ul>
							<li>Can use sorting algorithms to become faster</li>
						</ul>
					</li>
				</ul>
			</li>
			<li><b>Scan:</b>
				<ul>
					<li>When the DB must sequentially process each row to test each record for matching the criteria of a query
						<ul>
							<li>It is sequential because the DB cannot determine from the index if the record matches search criteria and therefore has to go record by record.</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>For an example see <b>Chapter 3/Seek_Vs_Scan.SQL</b></li>
		</ul>
	</li>
</ol>

## Chapter 4: Using Built-In Functions and Expressions ##
### Concatenating Strings ###
<ol>
	<li>Concatenating String values with <b>NULL</b> will always return <b>NULL</b>
		<ul>
			<li>This concept is sometimes referred to as <b>NULL Propagation</b>
				<ul>
					<li>This makes sense when you consider that a value of NULL means <b>unknown</b> in TSQL</li>
					<li>Thus, if you add something to an unknown quantity or entity, you still do not know what the result will be and so NULL (or unknown) is returned</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>The <b>CONCAT</b> function
		<ul>
			<li>This function was introduced by SQL Server 2012</li>
			<li>It can concatenate string and even non-string values</li>
			<li>It takes any number of arguments and concatenates them together</li>
			<li><b>NULL</b> values are ignored by the CONCAT function</li>
			<li>See Chapter4/Concat_Function.sql for more information</li>
			<li>Instead of using <b>CAST</b> or <b>CONVERT</b> to concatenate numeric data types with strings, you can use <b>CONCAT</b> which will automatically convert the numeric value to a string
				<ul>
					<li>
<p>

```SQL
SELECT 1 + '1'
```
</p>
					</li>
					<li>If the desired result is `11` instead of 2, then you must explicitly convert the numeric one to a string.</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>ISNULL</b> and <b>COALESCE</b>
		<ul>
			<li>Both of these functions are available to provide a way to replace NULL values</li>
			<li><b>ISNULL</b>
				<ul>
					<li>Takes two parameters:
						<ul>
							<li>First: the value to check for NULL</li>
							<li>Second: the value to use in place of the checked value if it is NULL</li>
						</ul>
					</li>
					<li>Follows the format:
<p>

```SQL
ISNULL(<value>, <replacement>);
```
</p>
					</li>
				</ul>
			</li>
			<li><b>COALESCE</b>
				<ul>
					<li>Takes any number of arguments and returns the first non-NULL value</li>
					<li>COALESCE is generally preferred over ISNULL since it meets ANSI standards</li>
					<li>Follows the format
<p>

```SQL
COALESCE(<value1>,<value2>, ..., <valueN>);
```
</p>
					</li>
					<li>See <b>Chapter4/IsNull_Coalesce.sql</b> for more information</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>CASE</b> and <b>CONVERT</b>
		<ul>
			<li><b>CAST</b> follows the format:
<p>

```SQL
CAST(<value> AS <new data type>)
```
</p>
			</li>
			<li>CONVERT follow the format:
<p>

```SQL
CONVERT(<new data type>, <value>)
```
</p>
			</li>
		</ul>
	</li>
</ol>

### <b>LEFT</b> and <b>RIGHT</b> ###

<ol>
	<li>The <b>LEFT</b> and <b>RIGHT</b> functions return a specified number of characters on the left or right of a string
		<ul>
			<li>The format for each:
<p>

```SQL
LEFT(<string>,<number of characters>)
RIGHT(<string>,<number of characters>)
```
</p>
			</li>
			<li><b>NOTE:</b> Even if the value contains fewer characters than the number specified in the second parameter, the function still works to return as many characters as possible</li>
		</ul>
	</li>
</ol>

### <b>LEN</b> and <b>DATALENGTH</b> ###

<ol>
	<li>
		<ul>Both of these functions serve as a means to return the number of characters in a string
			<li>The format is the same for both:
<p>

```SQL
LEN(<string>)
DATALENGTH(<string>)
```
</p>
			</li>
			<li>Be careful when using <b>DATALENGTH</b>, as it will the number of <b>BYTES</b> in a string versus the number of characters
				<ul>
					<li>This becomes important when dealing with <b>VARCHAR</b> versus <b>NVARCHAR</b>
						<ul>
							<li><b>VARCHAR</b> stores characters as a single byte</li>
							<li><b>NVARCHAR</b> stores characters as two bytes</li>
						</ul>
					</li>
					<li>This means that using <b>DATALENGTH</b> on an <b>NVARCHAR</b> would result in a number twice as large as a call using <b>LEN</b> on the same string</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

### String Traversal ###
<ol>
	<li><b>CHARINDEX</b>
		<ul>
			<li>Used to find the location of a string within the specified string and return its numeric index
				<ul>
					<li><b>NOTE:</b> The first letter of the string is treated as <b>1</b>, not <b>0</b> in terms of the numeric value returned</li>
					<li><b>NOTE:</b> When specifying the <b>star location</b>, the start of the string is considered <b>0</b></li>
					<li><b>NOTE:</b> The search is case <b>insensitive</b></li>
				</ul>
			</li>
			<li>Follows the format:
<p>

```SQL
CHARINDEX(<search string>, <target string>[,<start location>])
```
</p>
			</li>
			<li>See exercise <b>Chapter4/CharIndex</b></li>
		</ul>
	</li>
	<li><b>SUBSTRING</b>
		<ul>
			<li>Allows the searching of a string in order to return the characters between the specified start and end parameters</li>
			<li>If the <b>start position</b> is past the end of the string, NULL will be returned</li>
			<li>
<p>

```SQL
SUBSTRING(<string>,<start location>, <length>)
```
</p>
			</li>
			<li>See exercise Chapter4/SubString</li>
		</ul>
	</li>
	<li><b>CHOOSE</b>
		<ul>
			<li>This is a new function introduced with SQL Server 2012</li>
			<li>Allows you to select a value in an array (series of values) based on an index
				<ul>
					<li>The index points to the position in the series of values (array) you want to return</li>
				</ul>
			</li>
			<li>Follows the format:
<p>

```SQL
CHOOSE(index, val_1, val_2[, val_n])
```
</p>			
			</li>
			<li>See Exercise <b>Chapter4/Choose</b></li>
			<li><b>NOTE:</b> The function takes the highest data type precedence.
				<ul>
					<li>This means if there is an integer in the list, the <b>CHOOSE</b> function will try to convert any results to an integer</li>
					<li>This is best used when the range of values ("array") are of the same type or easily convertible</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>REVERSE</b>
		<ul>
			<li>This function will reverse the characters in a string</li>
			<li>A common use case is to pair <b>REVERSE</b> with <b>CHARINDEX</b> and <b>RIGHT</b> to find a file name from a string value of its file path</li>
			<li>See <b>Chapter4/Reverse</b> for more information</li>
		</ul>
	</li>
</ol>

### Using Date and Time Functions ###

<ol>
	<li><b>GETDATE</b> or <b>SYSDATETIME</b> can be used to get the current date and time of the server
		<ul>
			<li><b>GETDATE</b> returns <b>3</b> decimal places after the second value
				<ul>
					<li>The data type returned is of the <b>DATETIME</b> type</li>
				</ul>
			</li>
			<li><b>SYSDATETIME</b> returns <b>7</b> decimal places after the second value
				<ul>
					<li>The data type returned is of the <b>DATETIME2(7)</b> type</li>
				</ul>
			</li>
		</ul>
		<li>The functions can be invoked in the following manner:
<p>

```SQL
SELECT GETDATE();
SELECT SYSDATETIME();
```
</p>			
		</li>
	</li>
	<li><b>DATEADD</b>
		<ul>
			<li>Follows the format:
<p>

```SQL
DATEADD(<date part>, <number>, <date>)
```
</p>
			</li>
			<li><b>NOTE:</b> T-SQL does not have a <b>DATESUBTRACT</b> but you can use a negative number to achieve the same effect.</li>
			<li>See exercise <b>Chapter4/DateAdd</b></li>
			<li>The values for the <b>Date Part</b> parameter</li>
		</ul>
	</li>
</ol>

| Date Part | Abbreviation 	|
| --------- | ------------ 	|
| Year		| yy, yyyy	   	|
| Quarter	| qq, q 	   	|
| Month		| mm, m  	   	|
| DayofYear	| dy, y   	   	|
| Day 		| dd, d		   	|
| Week		| wk, ww       	|
| Weekday	| Dw 		   	|
| Hour		| Hh			|
| Minute	| mi, n			|
| Second	| ss, s 		|
| Millisecond | Ms			|
| Microsecond | Mcs			|
| Nanosecond | Ns			|		

<ol start="4">
	<li><b>DATEDIFF</b>
		<ul>
			<li>The <b>DATEDIFF</b> function allows you to find the difference between two dates</li>
			<li>Follows the format:
<p>

```SQL
DATEDIFF(<datepart>, <early date>, <later date>)
```
</p>
			</li>
			<li>See exercise <b>Chapter4/DateDiff</b></li>
		</ul>
	</li>
</ol>


<ol start="5">
	<li><b>DATENAME</b> and <b>DATEPART</b>
		<ul>
			<li>These two functions return parts of a specified date</li>
			<li>They follow the format:
<p>

```SQL
DATENAME(<datepart>, <date>)
DATEPART(<datepart>, <date>)
```
</p>
			</li>
			<li><b>DATENAME</b> will give you the numeric representation of the part of the date specified</li>
			<li><b>DATEPART</b> will give you the English text description of the part of the date specified</li>
			<li>See exercise <b>Chapter4/DateNameDatePart</b></li>
			<li>Another shorthand way obtain the numeric representation of date parts:
<p>

```SQL
DAY(<date>)
MONTH(<date>)
YEAR(<date>)
```
</p>
			</li>
		</ul>
	</li>
</ol>


<ol start="6">
	<li><b>CONVERT</b>
		<ul>
			<li><b>CONVERT</b> can used with an optional parameter to provide string formating for the conversation of a date value into a string</li>
			<li>Follows the format:
<p>

```SQL
CONVERT(<data type, usually a VARCHAR>, <date>[, <style>])
```
</p>
			</li>
			<li>See exercise <b>Chapter4/ConvertDateToString</b></li>
		</ul>
	</li>
</ol>


<ol start="7">
	<li><b>FORMAT</b>
		<ul>
			<li>This function is was introduced in 2012 to simplify the conversion of date/time values as string values</li>
			<li>Another purpose is to convert date/time values to their cultural equivalencies</li>
			<li><b>IMPORTANT:</b> If performance is to be an issue, you are better served sticking with <b>CONVERT</b></li>
			<li>Follows the format:
<p>

```SQL
FORMAT(value, format[, culture])
```
</p>
			</li>
			<li>See exercise <b>Chapter4/Format</b></li>
		</ul>
	</li>
</ol>

<ol start="8">
	<li><b>DATEFROMPARTS</b>
		<ul>
			<li>Introduced in SQL Server 2012, these functions allow for a simple method to derive a date, time or date and time from a list of values
				<ul>
					<li>The primary function is called <b>DATEFROMPARTS</b>, but there is also a version of the function for both date or time data types</li>
				</ul>
			</li>
			<li>See Exercise <b>Chapter4/DateFromParts</b></li>
		</ul>
	</li>
</ol>


<ol start="9">
	<li><b>EOMONTH</b>
		<ul>
			<li>Another addition made by SQL Server 2012, <b>EOMONTH</b> will return the date of the last day of the supplied month argument</li>
			<li>YOu can alternatively supply an <b>offset</b> to return the end of the month for another month</li>
			<li>See exercise <b>Chapter4/EoMonth</b></li>
		</ul>
	</li>
</ol>


### Mathematical Functions ###
<ol>
	<li><b>ABS</b>
		<ul>
			<li>Will return the absolute value of number</li>
			<li>Follows the format:
<p>

```SQL
ABS(<number value>)
```
</p>
			</li>
		</ul>
	</li>
	<li><b>POWER</b>
		<ul>
			<li>Returns the result of raising the first argument to the power of the second argument</li>
			<li>Follows the format:
<p>

```SQL
POWER(<number>,<power>)
```
</p>				
			</li>
		</ul>
	</li>
	<li><b>SQUARE</b> and <b>SQRT</b>
		<ul>
			<li><b>SQUARE</b> returns the value of the specified number squared</li>
			<li><b>SQRT</b> returns the value of the square root of the specified number </li>
			<li>The functions follow the format:
<p>

```SQL
SQUARE(<number>)
SQRT(<number>)
```
</p>
			</li>
		</ul>
	</li>
	<li><b>RAND</b>
		<ul>
			<li>This function will return a value between 0 and 1</li>
			<li>It is invoked with either with no arguments or a single optional parameter, <b>@seed</b>
				<ul>
					<li>If a seed value is specified, the RAND function will return the same value each time</li>
					<li>If you supply a seed value to on of the calls to RAND within a <b>batch</b> statement, that see affects the other calls
						<ul>
							<li>The values are NOT the same, but the values are predictable</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>For more information, see exercise <b>Chapter4/MathFunctions</b></li>
</ol>

### Logical Functions and Expressions ###
<ol>
	<li>Searched <b>CASE</b> expression
		<ul>
			<li>Can be used when you want to compare value from a column to several other values in an <b>IN</b> list
				<ul>
					<li>Can also be use greater-than or less-than operators</li>
					<li>This usage of <b>CASE</b> will still return the first value that returns true for the evaluation</li>
				</ul>
			</li>
			<li>Follows the format:
<p>

```SQL
CASE	
	WHEN <test expression> THEN <value1>
	[WHEN <test expression> THEN <value2>]
	[ELSE <value3>]
END
```
</p>
			</li>
			<li><b>NOTE:</b> The return values in the CASE statement must be of compatible types</li>
			<li>See Exercise <b>Chapter4/SearchCase</b></li>
		</ul>
	</li>
	<li>Listing a Column as the Return value
		<ul>
			<li>It is also possible to list a column name instead of hard-coded value sin the THEN part of the <b>CASE</b> expression
				<ul>
					<li>This means you can display one column for some of the rows returned an another column for other rows</li>
				</ul>
			</li>
			<li>Generic syntax:
<p>

```SQL
SELECT 
	 column_1
	,column_2
	,CASE
		WHEN column_1 > column_2 THEN column_1
		ELSE column_2
	END AS 'More Hours'
FROM schema.tableName;
```
</p>				
			</li>
			<li>See exercise <b>Chapter4/ColumnAsReturnValue</b></li>
		</ul>
	</li>
	<li><b>IIF</b>
		<ul>
			<li>Introduced with SQL SERVER 2012, this operator behaves like a SQL based <b>ternary</b> operator</li>
			<li>Follows the format:
<p>

```SQL
IIF(boolean_expression, true_value, false_value);
```
</p>
			</li>
			<li>See Exercise <b>Chapter4/IIF</b></li>
		</ul>
	</li>
</ol>

### Administrative Functions ###
<ol>
	<li>Some of the built in functions within SQL Server allow DBAs to quickly ascertain information about the DB
		<ul>
			<li>Some of the administrative functions are listed in the below select statement
<p>

```SQL
SELECT
	 DB_NAME() AS 'Database Name'
	,HOST_NAME() AS 'Host Name'
	,CURRENT_USER AS 'Current User'
	,SUSER_NAME() AS 'Login'
	,USER_NAME() AS 'User Name'
	,APP_NAME() AS 'App Name';
```
</p>
			</li>
			<li>See exercise <b>Chapter4/AdminFunctions</b></li>
		</ul>
	</li>
	<li>Using functions in <b>WHERE</b> and <b>ORDER BY</b> clauses
		<ul>
			<li>An example of this would be the following queries
<p>

```SQL
SELECT FirstName
FROM Person.Person
WHERE CHARINDEX('ke', FirstName) > 0;

SELECT 
	LastName
	,REVERSE(LastName)
FROM Person.Person
ORDER BY REVERSE(LastName);
```
</p>
			</li>
			<li>While this is perfectly valid SQL, it is important to realize that using a function in the above locations can cause performance to suffer
				<ul>
					<li>When a function is invoked on a column, the DB engine must still evaluate <b>each row one at a time</b>					</li>
					<li>If the column that is the target of the function has an index created for it, the DB can search the index but must still do so one record at a time.</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>The <b>TOP</b> keyword
		<ul>
			<li>The TOP keyword allows you to limit the number or percentage or rows returned from a query</li>
			<li>Follows the format:
<p>

```SQL
SELECT TOP(<number>) [PERCENT] [WITH TIES] 
	<col1>
	,<col2>
FROM <table1> 
[ORDER BY <col1>]
```
</p>
			</li>
			<li>The <b>WITH TIES</b> option means that if there are rows that have identical values in the <b>ORDER BY</b>, the results will included all rows even though you now end up with more rows than you expect</li>
			<li>A trick you can use to get random rows is by sorting your query by the <b>NEWID</b> function
				<ul>
					<li>Looks like this:
<p>

```SQL
SELECT TOP(2)
	CustomerID
	,OrderDate
	,SalesOrderID
FROM Sales.SalesOrderHeader
ORDER BY NEWID();
```
</p>
					</li>
				</ul>
			</li>
			<li><b>NOTE:</b> Microsoft recommends using the <b>OFFSET</b> and <b>FETCH</b> clauses introduced with SQL Server 2008 as opposed to <b>TOP</b> as a paging solution and to limit the amount of data sent to a client
				<ul>
					<li><b>OFFSET</b> and <b>FETCH</b> also allow for more options, including the use of variables</li>
				</ul>
			</li>
			<li>See Exercise <b>Chapter4/Top</b></li>
		</ul>
	</li>
	<li><b>Thinking about performance with functions</b>
		<ul>
			<li>When using a function in the <b>WHERE</b> clause, you must be aware that the function will cause the database engine to perform a <b>SCAN</b> of the entire (clustered)index, retrieve each row's column value and then compare it to determine whether the result of the function applied to each value meets the criteria.
				<ul>
					<li>The DB has to scan the index because it has to get every row value, feed it into the function, and then see if it meets the <b>WHERE</b> criteria</li>
				</ul>
			</li>
			<li>If you create a non-clustered index on the column being feed into a <b>DIRECT COMPARISON</b>, then the DB can do a <b>SEEK</b> on the non-clustered index because it can compare each value of the index outright
				<ul>
					<li>As opposed to having to lookup each clustered index (every table row) and then find the column value that is being compared</li>
					<li>The non-clustered index gives the DB engine direct access to the value needing to be evaluated in <b>WHERE</b> clause</li>
				</ul>
			</li>
			<li><b>NOTE:</b> Direct comparisons in a <b>WHERE</b> clause are only faster if they are being done on an <b>indexed</b> column
				<ul>
					<li>Otherwise, they perform similarly to a <b>WHERE</b> clause with functions</li>
					<li>They both have to perform <b>clustered index scans</b></li>
				</ul>
			</li>
			<li>An illustration of <b>DIRECT COMPARISION</b> vs <b>Functions</b>
<p>

```SQL
--DIRECT COMPARISON
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2011-01-01 00:00:00'
  AND OrderDate < '2012-01-01 00:00:00';

--Function
SELECT
	SalesOrderID
	,OrderDate
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011;
```
</p>
			</li>
			<li>See exercise <b>Chapter4/FunctionPerformance</b></li>
		</ul>
	</li>
</ol>

## Chapter 5: Joining Tables ##
### Types of JOINs ###
<ol>
	<li><b>INNER JOINS</b>
		<ul>
			<li>Will return all records from the two joined tables that have value for the column that is being joined</li>
			<li><b>Cartesian Product</b>
				<ul>
					<li>This is a type of inner join that results in every row from the first table joins every row in the second table</li>
					<li>An example:
<p>

```SQL
--Cartesian Product
SELECT
	soh.SalesOrderID
	,soh.OrderDate
	,soh.TotalDue
	,sod.SalesOrderDetailID
	,sod.ProductID
	,sod.OrderQty
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON 1 = 1;
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>LEFT JOIN</b>
		<ul>
			<li>Will return all records in the first table and any records in the second table that have value for the joining column</li>
			<li>Example:
<p>

```SQL
--Left Join
SELECT 
	c.CustomerID
	,soh.SalesOrderID
	,soh.OrderDate
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4);
```
</p>			
				<ul>
					<li><b>Sales.Customer</b> is on the <b>LEFT</b> side of the JOIN so all of its rows (that meet filter criteria) will be returned</li>
				</ul>
			</li>			
		</ul>
	</li>
	<li><b>RIGHT JOIN</b>
		<ul>
			<li>Will return all records in the second table and any records in the first table that have value for the joining column</li>
			<li>Example:
<p>

```SQL
--Right Join
SELECT 
	c.CustomerID
	,soh.SalesOrderID
	,soh.OrderDate
FROM Sales.SalesOrderHeader soh  
RIGHT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID 
WHERE c.CustomerID IN (11028, 11029, 1, 2, 3, 4);
```
</p>			
				<ul>
					<li><b>Sales.Customer</b> is on the <b>RIGHT</b> side of the JOIN so all of its rows (that meet filter criteria) will be returned</li>
				</ul>
			</li>			
		</ul>
	</li>
	<li>A note on Inner, Left, and Right joins
		<ul>
			<li>Essentially, it is the construction of the query that determines the how records will be interpreted relative to the type of join being done
				<ul>
					<li>Tables declared prior to the current <b>JOIN</b> are the <b>LEFT</b></li>
					<li>Tables declared after the <b>JOIN</b> statement are on the <b>RIGHT</b></li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Adding a table to the Right side of a <b>LEFT JOIN</b>
		<ul>
			<li>If you need to join to a table that your existing query has <b>LEFT</b> joined to, the new table must also be a <b>LEFT</b> join
				<ul>
					<li>This will avoid losing the NULL values of your previous LEFT join</li>
				</ul>
			</li>
			<li>See Exercise <b>Chapter5/SuccessiveLeftJoins</b></li>
		</ul>
	</li>
		<li><b>FULL OUTER JOIN</b>
		<ul>
			<li>This essentially will do a LEFT and RIGHT JOIN on the two tables on the specified column
				<ul>
					<li>This means that all rows from the left side are returned, even if there is not a matching record on the right side</li>
					<li>And all the rows on the right side are returned even if there is not a matching column on the left side</li>
				</ul>
			</li>
			<li>For the most part, avoid doing this type of JOIN
				<ul>
					<li>If this type of JOIN is needed often when working with a database, it could indicate some problems with database design</li>
					<li><b>NOTE:</b> This type of JOIN can be useful whenever you are importing data from a client's database into your own
						<ul>
							<li>A query like this can be used to find problems in data so that it can be cleaned up before loading it into a production system or data warehouse</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Follows the format:
<p>

```SQL
SELECT 
  <column list>
FROM <table1>
FULL [OUTER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2>
```
</p>
			</li>
			<li>See exercise <b>Chapter5/FullOuterJoin</b></li>
		</ul>
	</li>
	<li><b>CROSS JOIN</b>
		<ul>
			<li>This is also a rarely used JOIN type in that it is actually the same as the <b>Cartesian Product</b></li>
			<li>This type of query is used whenever you intend to multiply two tables together
				<ul>
					<li>Every row form one table is matched to every row from another table</li>
				</ul>
			</li>
			<li>You might write a <b>CROSS JOIN</b> query to populate a table for a special purpose such as an inventory worksheet</li>
			<li>Follows the format:
<p>

```SQL
SELECT 
  <select list>
FROM <table1> 
CROSS JOIN <table2>;
```
</p>
			</li>
		</ul>
	</li>
	<li><b>Self-Joins</b>
		<ul>
			<li>A query that joins a table back to itself</li>
			<li>This type of query works on tables that have a column aside from the primary key of the table that is a foreign key back to the same table's primary key
				<ul>
					<li>An example would be a <b>Person.Employee</b> table that had <b>EmployeeID</b> as the primary key and then another column named <b>ManagerID</b></li>
					<li>The <b>MangerID</b> column would then have a <b>FOREIGN KEY</b> constraint pointed at the <b>EmployeeID</b> column of the same table</li>
				</ul>
			</li>
			<li>The 2012 edition of AdventureWorks does not have tables structured in this fashion because it was designed to leverage the <b>HIERARCHYID</b> data type</li>
			<li>You can actually join any table to itself even if it doesn't have a foreign key pointing back to the primary key of the table
				<ul>
					<li>This type of relationship is called a <b>unary relationship</b></li>
				</ul>
			</li>
			<li>Follows the format:
<p>

```SQL
SELECT
   <a.col1>
  ,<b.col1>
FROM  <table1> a
LEFT JOIN <table1> b ON a.<col1> = b.<col2>;
```
</p>				
			</li>
			<li>See exercise <b>Chapter5/SelfJoin</b></li>
		</ul>
	</li>
	<li><b>Optimizer Join Types</b>
		<ul>
			<li>When joining tables in SQL Server, the database engine will employ one of three join strategies: (1) Merge Join, (2) Has Match, (3) and Nested Loop</li>
			<li><b>There is no one way that is best</b>
				<ul>
					<li>The optimizer will choose the join type based on its expectations of the data being queried</li>
				</ul>
			</li>
			<li><b>MERGE JOIN</b>
				<ul>
					<li>This type of join strategy is used when the optimizer estimates that the join will result in a <b>large</b> number of rows on <b>both</b> tables, <b>AND</b> each table's data is <b>sorted</b> by the <b>joined column</b></li>
					<li>An example of this would be the following query run against the AdventureWorkd 2012 database
<p>

```SQL
SELECT
	soh.SalesOrderID
	,sod.OrderQty
	,sod.ProductID
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID;
```
</p>
					</li>
					<li>Since both <b>soh</b> and <b>sod</b> have a primary key column of <b>SalesOrderID</b>, the tables are already sorted on this index (the clustered indext)</li>
					<li><b>Important:</b> A merge join will sort <b>both</b> sides before starting its comparison</li>
					<li>See exercise <b>Chapter5/MergeJoin</b></li>
				</ul>
			</li>
			<li><b>Nested Loop</b>
				<ul>
					<li>This type of join is used when the optimizer <b>estimates</b> one side of the join has a small number of rows to join</li>
					<li>It doesn't matter if the two sides of the join are sorted
						<ul>
							<li>The DB engine will loop through all the rows from the small side of the join looking for a match in the rows of the larger side</li>
							<li>Since the join looping over a small data set, the data does not need to be sorted</li>
						</ul>
					</li>
					<li>An example of this would be the following query run against the AdventureWorkd 2012 database
<p>

```SQL
SELECT
	soh.SalesOrderID
	,sod.OrderQty
	,sod.ProductID
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.CustomerID = 11000;
```
</p>
					</li>
					<li>The filter of <b>soh.CustomerID</b> reduces the number of rows from <b>soh</b>, so the optimizer uses a nested loop on the small data set from <b>soh</b> looking for matches in <b>sod</b>
						<ul>
							<li>The process loops through the smaller side of the join, comparing each value to the values of the larger side of the join</li>
							<li>The process loops through the smaller input one time, but loops through the larger input one time for each iteration of the small loop</li>
						</ul>
					</li>
					<li>See exercise <b>Chapter5/NestedLoop</b></li>
				</ul>
			</li>
			<li><b>Hash Match</b>
				<ul>
					<li>This type of join is used when the optimizer estimates that a <b>large</b> number of rows will be returned from <b>both</b> sides of the join and the input is <b>not sorted</b> on the joining column</li>
					<li>The database engine will actually create hash tables in memory to get this work done</li>
					<li>An example of this would be the following query run against the AdventureWorkd 2012 database
<p>

```SQL
SELECT
	c.CustomerID
	,soh.TotalDue
FROM Sales.Customer c 
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID;
```
</p>
					</li>
					<li>Only <b>c</b> is sorted on <b>CustomerID</b> column.
						<ul>
							<li>And since <b>soh</b> is not sorted on <b>CustomerID</b>, a <b>Merge Join</b> cannot be used</li>
						</ul>
					</li>
					<li>We build the has table(s) with <b>c</b> records (since it is the smaller input) and then probe the hash tables(s) with <b>soh</b> input
						<ul>
							<li>This means we will loop through the larger input (<b>s</b> records) exactly once</li>
						</ul>
					</li>
					<li>See exercise <b>Chpater5/HashMatch</b></li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

## Chapter 6: Building on Sub-queries, CTEs, and Unions ##
### Writing Sub-queries ###
<ol>
	<li>Using a Subquery containing NULL with NOT IN
		<ul>
			<li>You will often get unexpected results if you do not take NULL values into account</li>
			<li>If the subquery contains any NULL values, using NOT IN will incorrectly produce no rows</li>
			<li>An example:
				<ul>
					<li>A subquery returns values NULL, 1, 2, and 3</li>
					<li>The values from the outer query (1,2, and 10) must be compared with the subquery list</li>
					<li>The database engine can tell 10 is not 1,2, or 3, but it cannot tell that 10 is not NULL (because NULL represents an unknown value)</li>
					<li>The intended result is 10 because it doesn't match any of the values from the subquery, but because of NULL, the comparison returns no results.</li>
				</ul>
			</li>
			<li>See exercise <b>Chapter6/NotInSubqueryContainingNull</b></li>
		</ul>
	</li>
</ol>

### UNIONs ###
<ol>
	<li>Using <b>UNION</b>s
		<ul>
			<li>A UNION query is not really a join, but a way to combine results of two queries with the same structure</li>
			<li>Follows the format:
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,<col3>
FROM <table1>

UNION [ALL]

SELECT
	<col1>
	,<col2>
	,<col3>
FROM <table2>
```
</p>
			</li>
			<li>In a UNION, the first query sets the <b>number</b> and <b>name</b> of each column
				<ul>
					<li>All subsequent queries must return columns of the same name and type as the first.</li>
				</ul>
			</li>
			<li>The difference between <b>UNION</b> and <b>UNION ALL</b>, is that <b>UNION</b> will remove duplicate records from the result set whereas <b>UNION ALL</b> will return all records (including duplicates)
				<ul>
					<li><b>UNION ALL</b> has increased performance benefits and should be used when possible, or within queries where duplicates are not possible or the presence of duplicates does not affect the caller</li>
					<li>When evaluating the execution plan of <b>UNION</b> vs <b>UNION ALL</b>, the <b>UNION</b> will always have an extra step of a <b>Hash Match</b> being performed in order to remove duplicates</li>
				</ul>
			</li>
			<li>See exercise <b>Chapter6/Unions</b></li>
		</ul>
	</li>
</ol>

### Common Table Expressions ###
<ol>
	<li>Derived Tables and Common Table Expressions (CTE)
		<ul>
			<li>A <b>Derived Table</b> is a subquery that appears in the <b>FROM</b> clause of a query
				<ul>
					<li>A Derived table allows the ability to join to a query instead of a table so that the logic of the query is isolated.</li>
					<li>Follows the format:
<p>

```SQL
SELECT 
	<select list>
FROM <table1>
JOIN (SELECT <select list>
	  FROM <table2>) AS <alias> ON <table1>.<col1> = <table2>.<col2>;
```
</p>						
					</li>
					<li>One interesting thing about derived tables is that they must <b>ALWAYS</b> be aliased</li>				
					<li><b>LIMITATIONS</b> of Derived Tables
						<ul>
							<li>You can use an <b>ORDER BY</b> clause in the derived table only if you use TOP</li>
							<li>A derived table cannot contain a CTE</li>
						</ul>
					</li>
					<li>See exercise <b>Chapter6/DerivedTable</b></li>
				</ul>
			</li>
			<li><b>Common Table Expressions</b> (CTE)
				<ul>
					<li>Introduced in 2005, CTEs give developers a way to separated out the logic of part of the query
						<ul>
							<li>There are 2 ways to write CTEs:
								<ul>
									<li>(1) Specify alias column names upfront
<p>

```SQL
WITH <cteName> [(<colname1>, <colname2>, ...<colnameN>)]
AS 
(
	SELECT
		<select list>
	FROM <table1>	
)
SELECT
	<select list>
FROM <table2>
JOIN <cteName> ON <table2>.<col1> = <ctename>.<col1>
```
</p>
									</li>
									<li>(2) Specify the column names within the CTE column declaration
<p>

```SQL
WITH <cteName>
AS 
(
	SELECT
		<select list>
	FROM <table1>	
)
SELECT
	<select list>
FROM <table2>
JOIN <cteName> ON <table2>.<col1> = <ctename>.<col1>
```
</p>
									</li>
								</ul>
							</li>
							<li>If aliases are defined upfront, they will be used instead of column names</li>
							<li>See exercise <b>Chapter6/CTEs</b></li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

## Chapter 7: Grouping and Summarizing Data ##
### Aggregate Functions ###
<ol>
	<li>Aggregate functions operate on sets of values from multiple rows all at once and with that knowledge keep the following items in mind:
		<ul>
			<li>The functions <b>AVG</b> and <b>SUM</b> will operate only on numeric and money data columns</li>
			<li>The functions <b>MIN</b>, <b>MAX</b>, and <b>COUNT</b> will work numeric, money, string, and temporal data columns</li>
			<li>The aggregate functions will not operate on <b>TEXT</b>, <b>NTEXT</b>, and <b>IMAGE</b>columns
				<ul>
					<li>These data types are deprecated.</li>
				</ul>
			</li>
			<li>The aggregate functions will not operate on some special data types like <b>HierarchyID</b> AND <b>Spatial</b></li>
			<li>The aggregate functions will not work on <b>BIT</b> columns except for <b>COUNT</b>
				<ul>
					<li>Note: You can always cast a <b>BIT</b> into an <b>INT</b> if you need to</li>
				</ul>
			</li>
			<li>The aggregate functions ignore NULL values except for the case of <b>COUNT(*)</b>
				<ul>
					<li>Using typical SSMS settings, you will get a warning about NULLs</li>
				</ul>
			</li>
			<li><b>IMPORTANT:</b> Once any aspect of aggregate queries are used in a query, the query becomes an aggregate query.</li>
		</ul>
	</li>
	<li>The <b>GROUP BY</b> clause
		<ul>
			<li>When you add non-aggregated columns to the select list containing an aggregated column, you add grouping levels to the query
				<ul>
					<li>This requires the query to have the <b>GROUP BY</b> clause</li>
					<li>The aggregate functions then operate on the grouping levels instead of on the entire result set</li>
				</ul>
			</li>
			<li><b>Grouping on Columns</b>
				<ul>
					<li>You can use the <b>GROUP BY</b> clause to group data so that the aggregate functions apply to groups of values instead of the entire result set</li>
					<li>The format for this:
<p>

```SQL
SELECT
	<aggregate function>(<col1>)
	,<col2>
FROM <table>
GROUP BY <col2>;
```
</p>						
					</li>
					<li><b>IMPORTANT:</b> If you dont want to group on a column, dont list it in the SELECT list</li>
					<li>See exercise <b>Chapter7/GroupBy</b></li>
				</ul>
			</li>
			<li><b>Grouping on Expressions</b>
				<ul>
					<li>It is also possible to use an expression when indicating the grouping to be used
						<ul>
							<li>You can use <b>Scalar expressions</b> in the Group By clause</li>
						</ul>
					</li>
					<li><b>IMPORTANT:</b> When using scalar expressions in the GROUP BY clause, you must list the expression in the GROUP BY declaration <b>EXACTLY</b> as it appears in the select list</li>
					<li>See exercise <b>Chapter7/GroupBy</b></li>
				</ul>
			</li>
		</ul>
	</li>
	<li>The <b>ORDER BY</b> clause
		<ul>
			<li>An order by clause can be used outside of an aggregate query, but when it is used within one, aggregate rules apply
				<ul>
					<li>If a non-aggregate column appears in the <b>ORDER BY</b>, it must also appear in the <b>GROUP BY</b> clause, just like the select list</li>
				</ul>
			</li>
			<li>The syntax is as follows:
<p>

```SQL
SELECT
	<aggregate function>(<col1>)
	,<col2>
FROM <table1>
GROUP BY <col2>
ORDER BY <col2>;
```
</p>				
			</li>
			<li>See Exercise <b>Chapter7/OrderBy</b></li>
		</ul>
	</li>
	<li>The <b>WHERE</b> and <b>HAVING</b> clause
		<ul>
			<li>The <b>WHERE</b> clause in an aggregate query may contain anything allowed in the WHERE clause in any other query type
				<ul>
					<li>It may <b>NOT</b>, however, contain an aggregate expression</li>
					<li>You use the <b>WHERE</b> clause to eliminate rows before the groupings (aggregation) and aggregates are applied</li>
				</ul>
			</li>
			<li>The <b>HAVING</b> clause allows you to eliminate rows within an aggregate grouping
				<ul>
					<li>The <b>HAVING</b> clause can include non-aggregated columns as long as the columns appear in the <b>GROUP BY</b> clause
						<ul>
							<li>This allows you to eliminate some of the groups with the <b>HAVING</b> clause</li>
							<li><b>INTERESTING:</b> The DB engine may move this type of filter criteria to the <b>WHERE</b> clause because it is more efficient to eliminate those rows first
								<ul>
									<li>As a best practice, criteria involving <b>non-aggregated columns</b> actually belong in the WHERE</li>
								</ul>
							</li>
						</ul>
						<li>Like the <b>GROUP BY</b> clause, <b>HAVING</b> will only appear in aggregate queries</li>
						<ul>
							<li>The <b>HAVING</b> clause follows the format:
<p>

```SQL
SELECT
	<aggregate function1>(<col1>)
	,<col2>
FROM <table1>
GROUP BY <col2>
HAVING <aggregate function2>(<col3>) = <value>;
```
</p>
							</li>
						</ul>
					</li>					
				</ul>
			</li>
			<li><b>IMPORTANT:</b> When considering which clause to use for filtering
				<ul>
					<li><b>WHERE</b> filters the results <b>BEFORE</b> grouping and aggregation occurs</li>
					<li><b>HAVING</b> filters the results <b>AFTER</b> grouping and aggregation occurs</li>
				</ul>
			</li>
			<li>See Exercise <b>Chapter7/WhereVsHaving</b></li>
		</ul>
		<li><b>IMPORTANT:</b> Tips on query structure and DB processing
			<ul>
				<li>When we write a query, it typically follows the order
					<ul>
						<li>SELECT</li>
						<li>FROM</li>
						<li>WHERE</li>
						<li>GROUP BY</li>
						<li>HAVING</li>
						<li>ORDER BY</li>
					</ul>
				</li>
				<li>The way the DB engine processes a query
					<ul>
						<li>FROM</li>
						<li>WHERE</li>
						<li>GROUP BY</li>
						<li>HAVING</li>
						<li>SELECT</li>
						<li>ORDER BY</li>
					</ul>
				</li>
				<li>The database engine process <b>WHERE</b> clause before it processes grouping and aggregates
					<ul>
						<li>Use the <b>WHERE</b> clause to eliminate rows <b>BEFORE</b> grouping and aggregation is done</li>
					</ul>
				</li>
				<li>The database engine processes <b>HAVING</b> after it processes the grouping and aggregates
					<ul>
						<li>Use the <b>HAVING</b> clause to eliminate rows based on aggregate expression and groupings</li>
					</ul>
				</li>
			</ul>
		</li>
	</li>
</ol>

### DISTINCT Keyword ###
<ol>
	<li><b>DISTINCT</b> vs <b>GROUP BY</b>
		<ul>
			<li>Developers often use the <b>DISTINCT</b> keyword to eliminate duplicate rows from a regular query
				<ul>
					<li>Be careful when tempted to do this, as this may be a sign that there is a problem with query logic</li>
					<li>If duplicate results are valid, using a <b>GROUP BY</b> will yield the same results</li>
				</ul>
			</li>			
			<li>See exercise <b>Chapter7/DistinctVsGroupBy</b></li>
		</ul>
	</li>
	<li>Using <b>DISTINCT</b> within an aggregate expression
		<ul>
			<li><b>DISTINCT</b> can be used within aggregate queries to cause the aggregate expression to only operate on unique values</li>
			<li>Follows the following syntax:
<p>

```SQL
SELECT
	<col1>
	,<aggregate function>(DISTINCT <col2>)
FROM <table1>;
```
</p>			
			</li>
			<li>See exercise <b>Chapter7/AggregateWithDistinct</b></li>
		</ul>
	</li>
</ol>

### Aggregate Queries with More Than One Table ###
<ol>
	<li>To see aggregates in action with more than one table, see exercise <b>Chapter7/AggregateMultiTable</b></li>
	<li>Aggregate Functions and NULL
		<ul>
			<li>Just as you have to consider NULL values in a normal query, you also have to account for NULL values within aggregate queries
				<ul>
					<li>How you view NULL values in the aggregate depends entirely on your interpretation of the data</li>
					<li>There is not right/wrong way; it will depend on the requirements or situation</li>
				</ul>
			</li>
			<li><b>IMPORTANT:</b> Since NULL is ignored by the aggregate function, you will need to give rows that have a NULL value for the column being aggregated a non-null value
				<ul>
					<li>An example of this would be to use the <b>NULLIF</b> or <b>ISNULL</b> function in conjunction with the aggregate function</li>
					<li>Syntax would look like this:
<p>

```SQL
SELECT 
	<col1>
	,NULLIF(SUM(<col2> * <col3>), 0.00)
FROM <table1>
GROUP BY <col1>;
```
</p>						
							<li>
								<ul>
									<li>If <b>col2</b> or <b>col3</b> is NULL, then we will assign a value of 0.00 for that row</li>
									<li>This will allow for the row to be included in the aggregate results</li>
									<li>If we do not use the <b>NULLIF</b>, we lose any data from rows that have NULL for either <col2> or <col3></li>
								</ul>
							</li>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

# Appendix A: Notepad++ custom setup
<ol>
	<li><b>IMPORTANT:</b> Regardless of what directory you tell the installer to place the Notepad++ files, it will create most of the required file directories in:
		<ul>
			<li><b>C:\Users\&lt;user&gt;\AppData\Roaming\Notepad++</b></li>
		</ul>
	</li>
	<li><b>THEMES</b>
		<ul>
			<li>In order to get a dark themed NPP, I had to download the <b>VSNotepadTheme</b> 
				<ul>
					<li>I then placed this in the <b>themes</b> folder underneath the AppData folder created during installation</li>
				</ul>
			</li>
			<li>To use this once NPP is open, go to <b>Settings --> Style Configurator --> Select Theme</b></li>
			<li>I also turned on html tag highlighting by going to <b>Language --> XML</b></li>
		</ul>
	</li>
	<li>MACROS
		<ul>
			<li>I imported macros I had on another computer's NPP installation</li>
			<li>To do this, I copied the <b>shortcuts.xml</b> file within the installed <b>Notepad++</b> directory</li>
			<li>I can either replace everything in the new Notepad++ installation's <b>shortcuts.xml</b> file or simply paste in the <b>&lt;Macros&gt;</b> section.</li>
		</ul>
	</li>
	<li>I also had to downgrade to NPP 6.9 (32 bit)
		<ul>
			<li>The current (7.5.5) was 64 bit and did not have support for <b>Plugin Manager</b></li>
			<li>The macros also did not recognize the <b>auto indent</b> functionality</li>
		</ul> 
	</li>
	<li>SPELL CHECKER
		<ul>
			<li>In order to get a spell checker that I could get (1)real-time spell checking as I typed and (2)ability to have the checker "learn" words like SQL
				<ul>
					<li>I installed <b>DSpellCheck</b>
						<ul>
							<li>This plugin allows the real-time checking of words in the document as you type</li>
							<li>It will underline misspelled words</li>
						</ul>
					</li>
					<li>I also installed <b>Spell-checker</b>
						<ul>
							<li>This is a more traditional spell checker in that you click the button and it will then check the entire document for spelling errors</li>
							<li>When a misspelling is encountered, the plugin gives you a chance to Replace, Ignore, or <b>Learn</b>
								<ul>
									<li>It is the ability to <b>Learn</b> that will allow you to no longer have to keep correcting the same word that the dictionary does not recognize (like SQL)</li>
								</ul>
							</li>
							<li>This plugin needs an additional .dll file that serves as its dictionary
								<ul>
									<li>I downloaded the <b>Aspell</b> dictionary from http://aspell.net/win32/
										<ul>
											<li>I took both the full installer and then the English exe</li>
										</ul>
									</li>
								</ul>
							</li>
						</ul>
					</li>
					<li>You can point <b>DSpellCheck</b> to using the <b>Aspell</b> dictionary as well
						<ul>
							<li>Under <b>Plugins --> DSpellCheck --> Settings</b>
								<ul>
									<li>Path the <b>Aspell Location</b> to the path you downloaded the dictionary .dll</li>
								</ul>
							</li>
							<li>This means you can use <b>Spell-Checker</b> to add words to your dictionary that then <b>DSpellCheck</b> will recognize and no longer underline the same word.</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol> 





