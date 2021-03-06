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
			<li>See Exercise <a href="./Chapter%204/CharIndex.sql">CharIndex</a></li>
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
			<li>See Exercise <a href="./Chapter%204/SubString.sql">SubString</a></li>
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
			<li>See Exercise <a href="./Chapter%204/Choose.sql">Choose</a></li>
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
			<li>See Exercise <a href="./Chapter%20e/DateAdd.sql">DateAdd</a></li>
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
			<li>See Exercise <a href="./Chapter%204/DateDiff.sql">DateDiff</a></li>
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
			<li>See Exercise <a href="./Chapter%204/DateNameDatePart.sql">DateNameDatePart</a></li>
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
			<li>See Exercise <a href="./Chapter%204/ConvertDateToString.sql">ConvertDateToString</a></li>
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
			<li>See Exercise <a href="./Chapter%204/Format.sql">Format</a></li>
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
			<li>See Exercise <a href="./Chapter%204/DateFromParts.sql">DateFromParts</a></li>
		</ul>
	</li>
</ol>


<ol start="9">
	<li><b>EOMONTH</b>
		<ul>
			<li>Another addition made by SQL Server 2012, <b>EOMONTH</b> will return the date of the last day of the supplied month argument</li>
			<li>YOu can alternatively supply an <b>offset</b> to return the end of the month for another month</li>			
			<li>See Exercise <a href="./Chapter%204/EoMonth.sql">EoMonth</a></li>
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
	<li>See Exercise <a href="./Chapter%204/MathFunctions.sql">MathFunctions</a></li>
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
			<li>See Exercise <a href="./Chapter%204/SearchCase.sql">SearchCase</a></li>
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
			<li>See Exercise <a href="./Chapter%204/ColumnAsReturnValue.sql">ColumnAsReturnValue</a></li>
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
			<li>See Exercise <a href="./Chapter%204/IIF.sql">IIF</a></li>
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
			<li>See Exercise <a href="./Chapter%204/AdminFunctions.sql">AdminFunctions</a></li>
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
			<li>See Exercise <a href="./Chapter%204/Top.sql">Top</a></li>
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
			<li>See Exercise <a href="./Chapter%204/FunctionPerformance.sql">FunctionPerformance</a></li>
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
			<li>See Exercise <a href="./Chapter%205/SuccessiveLeftJoins.sql">SuccessiveLeftJoins</a></li>
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
			<li>See Exercise <a href="./Chapter%205/FullOuterJoin.sql">FullOuterJoin</a></li>
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
			<li>See Exercise <a href="./Chapter%205/SelfJoin.sql">SelfJoin</a></li>
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
					<li>See Exercise <a href="./Chapter%205/MergeJoin.sql">MergeJoin</a></li>
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
					<li>See Exercise <a href="./Chapter%205/NestedLoop.sql">NestedLoop</a></li>
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
					<li>See Exercise <a href="./Chapter%205/HashMatch.sql">HashMatch</a></li>
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
			<li>See Exercise <a href="./Chapter%206/NotInSubqueryContainingNull.sql">NotInSubqueryContainingNull</a></li>
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
			<li>See Exercise <a href="./Chapter%206/Unions.sql">Unions</a></li>
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
					<li>See Exercise <a href="./Chapter%206/DerivedTable.sql">DerivedTable</a></li>
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
							<li>See Exercise <a href="./Chapter%206/CTEs.sql">CTEs</a></li>
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
					<li>See Exercise <a href="./Chapter%207/GroupBy.sql">GroupBy</a></li>
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
					<li>See Exercise <a href="./Chapter%207/GroupBy.sql">GroupBy</a></li>
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
			<li>See Exercise <a href="./Chapter%207/OrderBy.sql">OrderBy</a></li>
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
			<li>See Exercise <a href="./Chapter%207/WhereVsHaving.sql">WhereVsHaving</a></li>
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
			<li>See Exercise <a href="./Chapter%207/DistinctVsGroupBy.sql">DistinctVsGroupBy</a></li>
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
			<li>See Exercise <a href="./Chapter%207/AggregateWithDistinct.sql">AggregateWithDistinct</a></li>
		</ul>
	</li>
</ol>

### Aggregate Queries with More Than One Table ###
<ol>
	<li>To see aggregates in action with more than one table
		<ul>
			<li>See Exercise <a href="./Chapter%207/AggregateMultiTable.sql">AggregateMultiTable</a></li>
		</ul>
	</li>
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
	,AVG(ISNULL(<col2>, 0))
FROM <table1>
GROUP BY <col1>;
```
</p>						
					</li>
					<li>If col2 is Null, then the row will be assigned a value of 0 for its Average
						<ul>							
							<li>This will allow for the row to be included in the aggregate results</li>
							<li>If we do not use the <b>ISNULL</b>, we lose any data from rows that have NULL for col2</li>
						</ul>
					</li>
				</ul>				
				<li>See Exercise <a href="./Chapter%207/AggregateWithNulls.sql">AggregateWithNulls</a></li>
			</li>
		</ul>
	</li>
</ol>

### Performance Analysis ###
<ol>
	<li>In addition to the execution plan, SQL SERVER also offers the <b>STATISTICS IO</b> tool</li>
		<ul>
			<li>This command can be turned on to see the amount of reads/counts being done by each part of the query's execution plan</li>
			<li>To turn this command on, use the syntax:
<p>

```SQL
SET STATISTICS IO ON;
```
</p>
			</li>
		</ul>
	</li>
	<li>Stat IO provides information about how much data is read from disk and memory, the following table summarizes the meaning of each type of read.</li>
</ol>

| Action 			| Meaning	 																											|
| --------- 		| --------------------------------------------------------------------------------------------------------------------- |
| Scan Count		| The number of scans or seeks	   																						|
| Logical Reads		| The number of pages read from <b>memory</b>. <b>This is the most useful value</b> 	   								|
| Physical Reads	| The number of pages read from disk into memory  	   																	|
| Read-ahead Reads	| The number of pages placed into cache. This number will often be inflated when an <b>index is fragmented</b>  	   	|
| Lob logical Reads	| The number of pages read from memory of <b>Large Object Data</b> types	   											|
| Lob Physical Reads| The number of pages read from disk of Large Object Data types       													|
| Lob Read-ahead	| The number of pages placed into cache of Large Object Data types reads 		   										|

<ol start="3">
	<li>Basic breakdown of the above information:
		<ul>
			<li>Data is stored on disk in a structure called a <b>page</b>
				<ul>
					<li>Depending on the size of each row, a page could store more than one row (and most probably will)</li>
					<li>Say your row of interest is on a page with 99 other rows</li>
					<li>In order for SQL SERVER to be able to access the data, the page must be read from <b>disk</b> to <b>memory</b>
						<ul>
							<li>This means your row plus the other 99 rows of the page all reside within memory after the read is completed</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>The <b>physical reading</b> of pages from disk to memory is usually the <b>most resource-intensive</b> part of the query process and often the source of performance <b>bottlenecks</b>
				<ul>
					<li>Given this information, you may think that <b>physical reads</b> would be the most important</li>
					<li>Instead, when <b>tuning</b> queries, the <b>logical</b> reads value is actually the one to pay attention to.
						<ul>
							<li><b>IMPORTANT:</b>The <b>logical</b> reads <b>WILL NOT</b> change from execution to execution of the identical query</li>
							<li>The physical reads value can change depending on what is currently in memory.</li>
							<li>Using the <b>logical reads</b> value allows you to establish a common value when comparing difference versions of the same query.</li>
						</ul>
					</li>
					<li>When comparing query performance, the query that performs the <b>lowest</b> number of <b>logical</b> reads will have the best performance.</li>
				</ul>
			</li>
		</ul>
		<li>See Exercise <a href="./Chapter%207/StatIO.sql">StatIO</a>
			<ul>
				<li>Notes from the exercise:
					<ul>
						<li>Every <b>NON-CLUSTERED</b> index automatically includes the cluster key, which is used to find the matching clustered index row.</li>
						<li>Non-clustered indexes are generally much smaller structures than the table itself, so that is why a much smaller number of pages were read.</li>
					</ul>
				</li>
			</ul>
		</li>
	</li>
	<li><b>Column Store</b>
		<ul>
			<li>Introduced by SQL SERVER 2012, the <b>column store</b> stores individual <b>columns</b> within pages instead of <b>rows</b></li>
			<li>Microsoft also introduced <b>In-Memory OLTP</b> with SQL SERVER 2014
				<ul>
					<li>OLTP - Online Transaction Processing</li>
					<li>This technology allows entire tables to be loaded into memory automatically for extremely fast data manipulation</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

## Chapter 8: Discovering Windowing Functions ##
### Windowing Functions ###
<ol>
	<li>What is a Windowing function
		<ul>
			<li>A <b>"Window"</b> function performs calculations over a set of rows
				<ul>
					<li>The set of rows define the "window"</li>
				</ul>
			</li>
			<li>For each row of the results of a query, the windowing function will perform a specific calculation over a window of rows</li>
			<li>The window is defined with the <b>OVER</b> clause</li>
			<li>Windowing functions are allowed only in the <b>SELECT</b> or <b>ORDER BY</b> clauses
				<ul>
					<li>Another way they can be used is within a CTE to separate out the logic and filter in the outer query</li>
				</ul>
			</li>
			<li>The types of windowing functions fall into the following categories
				<ul>
					<li><b>Ranking functions</b>
						<ul>
							<li>This type of function adds a ranking to each row or divides the rows into buckets</li>
						</ul>
					</li>
					<li><b>Window aggregates</b>
						<ul>
							<li>This function allows you to calculate summary values in a non-aggregated query</li>
						</ul>
					</li><b>Accumulating aggregates</b>
					<li>
						<ul>
							<li>Enables the calculation of running totals</li>
						</ul>
					</li>
					<li><b>Analytic functions</b>
						<ul>
							<li>Several new <b>scalar</b> functions</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

### Ranking Functions ####
<ol>
	<li>The Ranking functions (<b>ROW_NUMBER, RANK, DENSE_RANK, NTILE</b>) were added in SQL SERVER 2005.
		<ul>
			<li>The first three assign a ranking to each row in the result set (window)</li>
			<li>The <b>NTILE</b> function divides the set of rows into buckets</li>
		</ul>
	</li>
	<li>Defining the Window
		<ul>
			<li>The <b>OVER</b> clause defines the window for the ranking function</li>
			<li>The <b>OVER</b> clause must specify the order or rows, which then determines how the function is applied to the data</li>
			<li><b>ROW_NUMBER</b>
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,ROW_NUMBER() OVER(ORDER BY  <col1>[,<col2>]) AS RowNum
FROM <table1>;
```
</p>				
			</li>
			<li><b>RANK</b>
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,RANK() OVER (ORDER BY <col1>[,<col2>]) AS RankNum
FROM <table1>;
```
</p>				
			</li>
			<li><b>DENSE_RANK</b>
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,DENSE_RANK() OVER(ORDER BY  <col1>[,<col2>]) AS DenseRankNum
FROM <table1>;
```
</p>				
			</li>
			<li>These functions differ in how they process <b>ties</b> or <b>duplicates</b> in the ORDER BY.
				<ul>
					<li>If the values of the column or combination of columns are unique, then all 3 return identical results</li>
					<li>The difference is that <b>ROW_NUMBER</b> will always return a unique value within the window</li>
					<li><b>RANK</b> and <b>DENSE_RANK</b> will return unique values if the ORDER BY is unique</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%208/RankingFunc.sql">RankingFunc</a></li>
		</ul>
	</li>
	<li>Dividing the Window into Partitions
		<ul>
			<li>Much like the panes in a normal window split the view of the window into sections, The window of the windowing function can be split into <b>partitions</b></li>
			<li>This may sound similar to the <b>GROUP BY</b>, but in reality it is quiet different
				<ul>
					<li>When using <b>GROUP BY</b>, you end up with one row in the results for each unique group</li>
					<li>When <b>partitioning</b> in the <b>OVER</b> clause, you retain all the detail rows in the result</li>
				</ul>
			</li>
			<li>For <b>Ranking Functions</b>, partitioning means you will start over for each partition</li>			
			<li>See Exercise <a href="./Chapter%208/Partitions.sql">Partitions</a></li>
		</ul>
	</li>
	<li>Using <b>NTILE</b>
		<ul>
			<li>The <b>NTILE</b> functions a bit differently from the other ranking functions</li>
			<li>It assigns a number to sections of rows and evenly distributes the data into these sections (buckets)</li>
			<li>Syntax:
<p>

```SQL
SELECT
	<col1>
	,NTILE(<number of buckets>) OVER([PARTITION BY <col2>] ORDER BY <col3>)
FROM <table>;
```
</p>
			</li>
			<li>Note that <b>NTILE</b> has a required parameter for specifying the number of buckets
				<ul>
					<li>Outside of this parameter, NTILE behaves like other ranking functions in terms of its <b>OVER</b> clause specification</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%208/NTILE.sql">NTILE</a></li>
		</ul>
	</li>
</ol>

### Summarizing Results with Window Aggregates ###
<ol>
	<li>Window aggregates allow you to add aggregate expressions to non-aggregate queries
		<ul>
			<li>Window aggregate functions require the <b>OVER</b> clause and support <b>PARTITION BY</b></li>
			<li>They do <b>NOT</b> support the <b>ORDER BY</b> option</li>
		</ul>
	</li>
	<li><b>IMPORTANT:</b>Keep in mind that aggregate functions and the window functions operate <b>AFTER</b> the <b>WHERE</b> clause
		<ul>
			<li>Fancy way of saying that window functions do not change the result set (since the result set is determined by the application of the WHERE clause)</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%208/WindowAggregates.sql">WindowAggregates</a></li>
</ol>

### Defining the Window with Framing ###
<ol>
	<li>Starting with SQL Server 2012, you can further define the window for certain window functions with <b>frames</b>
		<ul>
			<li>With <b>frames</b>, each row in the results will have a different window for the calculation
				<ul>
					<li><b>Framing</b> allows the window to consider a subset of the overall data set for a particular row window</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>There are three keyword phrases that we use when dealing with framing:
		<ul>
			<li><b>UNBOUNDED PRECEDING</b></li>
			<li><b>UNBOUNDED FOLLOWING</b></li>
			<li><b>CURRENT ROW</b></li>
		</ul>
		<li>The chart below explains
			<ul>
				<li><b>n</b> = last row</li>
				<li><b>i</b> = 10th row</li>
			</ul>
		</li>
	</li>
</ol>

| Frame Definition	| Rows in Frame for Row 10	(100 row result set)				   |
| -----------------	| ---------------------------------------------------------------- |
| ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW			| Rows 1 - 10 	=> 1...i   |
| ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING			| Rows 10 - 100	=> i...n   |
| ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLWING 	| Rows 1 - 100 	=> 1...n   |

<ol start="4">
	<li>When using <b>frames</b>, you can also specify an <b>offset</b> value to further refine your rows
		<ul>
			<li>The <b>offset</b> is the specification of the actual number of rows you want removed from the current row</li>
		</ul>
	</li>
	<li>The chart below explains
		<ul>
			<li><b>n</b> = last row</li>
			<li><b>i</b> = 10th row</li>
		</ul>
	</li>
	<li>Remember that each row has its own <b>frame</b>, so if you were to look at this from the perspective of row 9, the frame will shift left one row</li>
</ol>

| Frame Definition	| Rows in Frame for Row 10	(100 row result set)				   	|
| -----------------	| ---------------------------------------------------------------- 	|
| ROWS BETWEEN 3 PRECEDING AND CURRENT ROW			| Rows 7 - 10 	=> (i-3)...i  		|
| ROWS BETWEEN CURRENT ROW AND 5 FOLLOWING			| Rows 10 - 15	=> i...(i+5)	  	|
| ROWS BETWEEN UNBOUNDED PRECEDING AND 5 FOLLOWING 	| Rows 1 - 15 	=> 1...(i+5)  		|
| ROWS BETWEEN 3 PRECEDING AND 5 FOLLOWING 			| Rows 7 - 15 	=> (i-3)...(i+5)   	|

<ol start="7">
	<li>The examples above demonstrate <b>framing</b> using <b>ROWS</b>, but there is also another keyword <b>RANGE</b>
		<ul>
			<li>For the most part <b>ROWS</b>and <b>RANGE</b> do the same thing, however there are some subtle differences</li>
			<li>Window functions are part of the ANSI standard for the SQL language</li>
			<li>Microsoft has <b>NOT</b> fully implemented everything that the ANSI standards have specified for <b>RANGE</b>
				<ul>
					<li>So at this time, it is best to use <b>ROWS</b></li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

### Calculating Running Totals ###
<ol>
	<li>By adding an <b>ORDER BY</b> to a window aggregate expression, you can calculate a running total
		<ul>
			<li>The window aggregate function requires a frame, it it is <b>RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW</b> if nothing is specified
				<ul>
					<li>Again, it is better to use <b>ROWS</b> in place of <b>RANGE</b>, so specify the expression explicitly using <b>ROWS</b></li>
				</ul>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%208/RunningTotal.sql">RunningTotal</a></li>
</ol>

### Difference between ROWS and RANGE ###
<ol>
	<li>Besides RANGE not being fully implemented to the ANSI standards, there are core differences between ROWS and RANGE
		<ul>
			<li><b>ROWS</b> is a <b>physical</b> operator
				<ul>
					<li><b>ROWS</b> will operate over the physical rows of a result set</li>
					<li>This means that <b>ROWS</b> will return a running total based on the <i>physical position</i> of the row</li>
				</ul>
			</li>
			<li><b>RANGE</b> is a <b>logical</b> operator
				<ul>
					<li><b>RANGE</b> will operate on logical values</li>
					<li>This means <b>duplicates</b> are treated as a <b>single</b> value</li>
					<li>The resulting value is not a true running total calculation</li>
				</ul>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%208/RowsVsRange.sql">RowsVsRange</a></li>
</ol>

### Window Analytic Functions ###
<ol>
	<li><b>LAG</b> and <b>LEAD</b>
		<ul>
			<li>These two functions can be used to determine first and last occurrences of an element</li>
			<li>The performance of the functions is superb, but framing is not supported (but partitioning is)</li>			
			<li><b>LAG</b> lets you pull any column from a previous row
				<ul>
					<li>Syntax for <b>LAG</b>
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,LAG(<column to view>) OVER(ORDER BY <col1>[,<col2>]) AS <alias>
FROM <table>;
```
</p>
					</li>
					<li>Syntax for <b>LAG</b> with partitioning 
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,LAG(<column to view>[,<number of rows>][,<default value>]) OVER(ORDER BY <col1>[,<col2>]) AS <alias>
FROM <table>;
```
</p>					
					</li>
				</ul>
			</li>
			<li><b>LEAD</b> lets you pull column from a following row
				<ul>
					<li>Syntax for <b>LEAD</b>
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,LEAD(<column to view>) OVER(ORDER BY <col1>[,<col2>]) AS <alias>
FROM <table>;
```
</p>					
					</li>
					<li>Syntax for <b>LEAD</b> with partitioning 
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,LEAD(<column to view>[,<number of rows>][,<default value>]) OVER(ORDER BY <col1>[,<col2>]) AS <alias>
FROM <table>;
```
</p>					
					</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%208/LagLead.sql">LagLead</a></li>
		</ul>
	</li>	
	<li><b>FIRST_VALUE</b> and <b>LAST_VALUE</b>
		<ul>
			<li>These functions work similar to <b>LAG</b> and <b>LEAD</b> but pull values from either the very first row or very last row of the window</li>
			<li>Syntax for <b>FIRST_VALUE</b>
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,FIRST_VALUE(<column to view>) OVER(ORDER BY <col1>) [frame specification]
FROM <table1>;
```
</p>
			</li>
			<li>Syntax for <b>LAST_VALUE</b>
<p>

```SQL
SELECT
	<col1>
	[,<col2>]
	,LAST_VALUE(<column to view>) OVER(ORDER BY <col1>) frame specification
FROM <table1>;
```
</p>
				<ul>
					<li><b>NOTE:</b> The frame specification is not optional on <b>LAST_VALUE</b>
						<ul>
							<li>While you will not get an error message if you do not include a frame specification, the query will not work as expected because the default frame only goes up to the current row</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
		<li>See Exercise <a href="./Chapter%208/FirstLastValue.sql">FirstLastValue</a></li>
	</li>
</ol>

### Applying Windowing Functions ###
<ol>
	<li><b>Removing Duplicates</b>
		<ul>
			<li>One of the applications of <b>ROW_NUMBER</b> is to remove duplicate rows from data</li>
			<li><b>ROW_NUMBER</b> returns a unique number for each row in the window or set of rows returned</li>
			<li>By adding a row number, you can turn data with duplicates into unique rows temporarily</li>			
			<li>See Exercise <a href="./Chapter%208/RemoveDupWithRowNum.sql">RemoveDupWithRowNum</a></li>
		</ul>
	</li>
	<li><b>Solving the <i>Islands Problem</i></b>
		<ul>
			<li>The <i>islands problem</i> is a classic example of a problem that SQL developers face routinely
				<ul>
					<li>The crux of the issue is that we must identify boundaries that represent breaks in sequence within a data set</li>
					<li>For Example:
						<ul>
							<li>You have a data set of records with the values of 1,2,3,5,5,9,10,11</li>
							<li>The <i>islands</i> (boundaries) would be 1-3, 5, 8-11</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>One way to solve the problem is to use windowing functions (such as <b>DENSE_RANK</b>) to identify each island</li>			
			<li>See Exercise <a href="./Chapter%208/Islands.sql">Islands</a></li>
		</ul>
	</li>
</ol>

### Thinking About Performance with Window Functions ###
<ol>
	<li><b>Indexing</b>
		<ul>
			<li>A specific type of index can help the performance of most queries that make use of window functions
				<ul>
					<li>This index is commonly termed as a <b>POC</b> index (Partition, Order, Covering)</li>
					<li>See the article below for more information on the POC index
						<ul>
							<li>http://www.itprotoday.com/microsoft-sql-server/sql-server-2012-how-write-t-sql-window-functions-part-3</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>This index is composed of the <b>PARTITION BY </b> and <b>OVER BY</b> columns from the <b>OVER</b> clause (POC index)
				<ul>
					<li>The <b>P</b> and <b>O</b> columns need to be defined as the index key elements</li>
					<li>The <b>C</b> columns need to be included in the index leaf, using an <b>INCLUDE</b> clause in a non-clustered index
						<ul>
							<li>It the index is clustered, everything is implicitly covered</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>The author suggests that other columns listed in the SELECT list also be added as included columns to the index
				<ul>
					<li>Also, any columns listed in the WHERE clause should also be added as index keys in front of the PARTITION BY columns.</li>
				</ul>
			</li>
			<li>You shouldn't add this many indexes for every window function you write, but if you observe the function is having performance issues, this is a good place to start.</li>
		</ul>
	</li>
	<li><b>The Trouble with Window Aggregates</b>
		<ul>
			<li>While window aggregates are easier to write than the traditional logic counterparts, they also routinely experience worse performance</li>			
			<li>See Exercise <a href="./Chapter%208/TroubleWithWindAgg.sql">TroubleWithWindAgg</a></li>
		</ul>
	</li>
	<li><b>Framing</b>
		<ul>
			<li>Aside from the fact that <b>ROWS</b> is a physical operator and <b>RANGE</b> is a logical operator, there is also a performance difference between the two
				<ul>
					<li>Due to how the database engine implements the worktable used to perform the calculations, <b>RANGE</b> will have worse performance than <b>ROWS</b></li>
					<li>Since <b>RANGE</b> defines your window frame on a <b>logical</b> level, your frame can consist of more rows than when the frame is defined at the <b>physical</b> level with <b>ROWS</b></li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%208/RowRangePerformance.sql">RowRangePerformance</a></li>
		</ul>
	</li>
</ol>


## Chapter 9: Advanced WHERE clauses ##
### Pattern Matching ###
<ol>
	<li><b>Using LIKE</b>
		<ul>
			<li>Most of the time you will see <b>LIKE</b> using in conjunction with the percent sign(%) to signal wildcard usage to represent zero or more characters</li>
			<li>You may also see the usage of an underscore(_) to denote the replacement of exactly ONE character</li>
		</ul>
	</li>
	<li><b>Restricting the Characters in Pattern Matches</b>
		<ul>
			<li>The value matching a wildcard may be restricted to a list or range of characters</li>
			<li>To do this, surround the possible values or range by square brackets([])
				<ul>
					<li>Here is the syntax:
<p>

```SQL
SELECT 
	<col1>
	,<col2>
FROM <schema>.<table>
WHERE <column> LIKE 'value[a-c]';
```
</p>

<p>

```SQL
SELECT 
	<col1>
	,<col2>
FROM <schema>.<table>
WHERE <column> LIKE 'value[abc]';
```
</p>
					</li>
				</ul>
			</li>
			<li>Alternatively, you can use the caret(^) to list characters or the range of characters you do NOT want to use as replacements.
				<ul>
					<li>Here is the syntax:
<p>

```SQL
SELECT 
	<col1>
	,<col2>
FROM <schema>.<table>
WHERE <column> LIKE 'value[^d]';
```
</p>
					</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%209/PatternRestricting.sql">PatternRestricting</a></li>
		</ul>
	</li>
	<li><b>Using PATINDEX</b>
		<ul>
			<li><b>PATINDEX</b> works similar to the <b>CHARINDEX</b>, but includes the use of wildcards in the search condition</li>
			<li>Has the following syntax:
<p>

```SQL
PATINDEX('%pattern%', expression)
```
</p>
			</li>			
			<li>See Exercise <a href="./Chapter%209/PatIndex.sql">PatIndex</a></li>
		</ul>
	</li>
	<li><b>Performing a Full-Text Search</b>
		<ul>
			<li>Much like <b>LIKE</b> and <b>PATINDEX</b> allow you to find character matches within data, Full-text search provides the ability to search for words or phrases within string of binary data columns</li>
			<li>Full-Text search is especially beneficial when documents are stored as binary data in the database</li>
			<li><b>NOTE:</b> Full-Text search must be installed either during SQL Server installation or added later
				<ul>
					<li>You will also need to create a special full-text index on the table</li>
					<li>Below are a few tables in <b>AdventureWorks2012</b> that contain full-text search indexes
						<ol>
							<li>Production.ProductReview  --  Comments  --  NVARCHAR(3850)</li>
							<li>Production.Document --  DocumentSummary  --  NVARCHAR(MAX)</li>
							<li>Production.Document --  Document  --  VARBINARY(MAX)</li>
							<li>HumanResources.JobCandidate  --  Resume  --  XML</li>
						</ol>
					</li>
				</ul>
			</li>	
			<li>Using <b>CONTAINS</b>
				<ul>
					<li>The syntax for using <b>CONTAINS</b> in a full-text search:
<p>

```SQL
SELECT 
	<column1>
	,<column2>
FROM <schema>.<table>
WHERE CONTAINS(<index column>, <searchterm>);
```
</p>
					</li>					
					<li>See Exercise <a href="./Chapter%209/FullTextSearch.sql">FullTextSearch</a></li>
				</ul>
			</li>
			<li><b>Using <b>CONTAINS</b> with multiple terms</b>
				<ul>
					<li>You can use <b>CONTAINS</b> to find terms within a search column that are not adjacent in the record value</li>
					<li>The syntax is as follows:
<p>

```SQL
SELECT 
	<column1>
	,<column2>
FROM <schema>.<table>
WHERE CONTAINS(<index column>, <searchterm1 [AND][OR][searchterm2]>);
```
</p>
					</li>
					<li>See Exercise <a href="./Chapter%209/FullTextSearch.sql">FullTextSearch</a></li>
				</ul>
			</li>
			<li><b>FREETEXT</b>
				<ul>
					<li><b>FREETEXT</b> is similar to <b>CONTAINS</b> except that it returns rows that do not exactly match</li>
					<li>It will return rows that have similar meanings to your search terms by using a <b>thesaurus</b></li>
					<li><b>FREETEXT</b> is less precises than <b>CONTAINS</b> and less flexible
						<ul>
							<li>You cannot use <b>AND</b>, <b>OR</b>, and <b>NEAR</b> with <b>FREETEXT</b></li>
							<li>Avoid using double quotes</li>
						</ul>
					</li>
					<li>See Exercise <a href="./Chapter%209/FullTextSearch.sql">FullTextSearch</a></li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>SARGABLE</b>
		<ul>
			<li><b>Sargable</b> is a term that may appear in various SQL literature
				<ul>
					<li>It is a term that describes the condition where the optimizer can take full advantage of an index</li>
					<li>The term <b>sarg</b> is short for <b>search argument</b>, which is then turned into the adjective (sargable) to describe the search predicate.</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>Thinking about Performance</b>
		<ul>
			<li>See Exercise <a href="./Chapter%209/Performance.sql">Performance</a> for a comparison of <b>LIKE</b> vs. <b>CHARINDEX</b></li>
		</ul>
	</li>
</ol>

## Chapter 10: Manipulating Data ##
### Inserting New Rows ###
<ol>
	<li><b>Check table for existence</b>
		<ul>
			<li><b>Option 1:</b> SSMS can create the script and will check the <b>sys.objects.table</b> table to see if a specified table exists on the database</li>
			<li><b>Option 2: You can check the results of the <b>OBJECT_ID</b> function to see if a table(or other DDL objects) exist</b>
				<ul>
					<li>Syntax for <b>OBJECT_ID</b>
<p>

```SQL
IF OBJECT_ID('dbo.demoCustomer', 'U') IS NOT NULL
BEGIN
	DROP TABLE dbo.demoCustomer
END;
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>Adding rows with literal values</b>
		<ul>
			<li>When you add a hardcoded string literal to an insert statement, you can add a <b>N</b> to the front of the string declaration (outside of the string's single quotes)
				<ul>
					<li>This will convert the string to an <b>NVARCHAR</b> value to match the data type of the column</li>
					<li>Remember that <b>NVARCHAR</b> has more support for a wider array of character representation
						<ul>
							<li><b>NVARCHAR</b> can store <b>UNICODE</b> characters as well as <b>ASCII</b></li>
							<li><b>VARCHAR</b> can only store <b>ASCII</b></li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li><b>Inserting multiple rows using row constructors</b>
		<ul>
			<li>Starting with SQL Server 2008, you can insert multiple rows by specifying multiple values in a single insert statement</li>
			<li>Example:
<p>

```SQL
INSERT INTO dbo.demoCustomer(CustomerID, FirstName, MiddleName, LastName)
VALUES (12, N'Johnny', N'A.', N'Capino')
	  ,(16. N'Chris', N'R.', N'Beck');
```
</p>
			</li>
		</ul>
	</li>
	<li><b>Common pitfall when combining creation/insertion into a table in a single step</b>
		<ul>
			<li>Often, you will see SQL in which the SELECT INTO statement to create an empty table has a nonsensical predicate, such as WHERE 1=2
				<ul>
					<li>Even if your intent is to just create an empty table, the DB performance is helped if you have an explicit CREATE TABLE statement and then your INSERT INTO statement.</li>
					<li>Whenever a SQL statement creates a table(implicitly or explicitly), the DB will lock the system table</li>
					<li>If you separate your Create and Insert statements, then the DB will only lock the system tables during the create statement
						<ul>
							<li>Otherwise, if the statements are combined, the system tables stay locked until the entire query finishes(creation and insert)</li>
						</ul>
					</li>
				</ul>
			</li>			
		</ul>
	</li>
	<li><b>Inserting rows into tables with Automatically populating columns</b>
		<ul>
			<li>There are column types for which a value is computed based on the value of the row and (generally) should not be specified by the insert
				<ul>
					<li><b>Rowversion</b>: Formally <b>TIMESTAMP</b>, this contains a binary number that is unique within a database.
						<ul>
							<li>This column is generally checked to see if a change has occurred to a record since it was retrieved</li>
						</ul>
					</li>
					<li><b>Identity:</b> This contains an auto-incrementing numeric value.</li>
					<li><b>Computed Columns:</b> These have a definition that is usually based on other column values in the same row
						<ul>
							<li>The values in the computed column can be stored in the table by specifying the <b>PERSISTED</b> keyword in the column definition</li>
							<li>If the column does not specify <b>PERSISTED</b>, its value will be calculated each time it is accessed</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2010/DataInsertion.sql">DataInsertion</a></li>
</ol>

## Chapter 11: Writing Advanced Queries ##
### Advanced CTE Queries ###
<ol>
	<li><b>Effective Sequence</b>
		<ul>
			<li>This is a technique in which we define two CTEs and have one call the other for the purpose of keeping track of the most recent column value</li>
			<li>This allows us to determine the most recent record when the column being used to determine that has the same value for multiple records
				<ul>
					<li>An example would be a <b>Effective Date</b> column of type <b>DATE</b></li>
					<li>The system could insert multiple rows for the same person with the same data value</li>
					<li>How would you know which record is the most recent if a person had multiple records for the same date value?</li>
					<li>To display information valid on a particular date, you first have to figure out the latest effective date before the date in mind and then figure out the <b>effective sequence for that date.</b></li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2011/EffectiveSequence.sql">EffectiveSequence</a></li>
		</ul>
	</li>
	<li><b>Recursive CTEs</b>
		<ul>
			<li>Recursion via a CTE is possible using an <b>Anchor member</b> that is UNION ALL'ed to the <b>Recursive member</b>
				<ul>
					<li>The <b>anchor member</b>, which is a statement that returns to the top of your intended results, behaves as the root of the directory</li>
					<li>The <b>recursive member</b> actually joins the CTE that contains it to the same table used in the anchor member.</li>
					<li>The results of the anchor member and recursive member join in a UNION ALL</li>
				</ul>
			</li>
			<li>General syntax:
<p>

```SQL
WITH <cteName>(<col1>, <col2>, <col3>, level)
AS
(
	--Anchor member
	SELECT 
		<primaryKey>
		,<foreignKey>
		,<col3>
		,0 AS level
	FROM <table1>
	WHERE <foreignKey> = <startingValue>
	
	UNION ALL
	
	--Recursive member
	SELECT 
		a.<primaryKey>
		,a.<foreignKey>
		,a.<col3>
		,b.level + 1 AS level
	FROM <table1>
	JOIN <cteName> b ON a.<foreignKey> = b.<primaryKey>
)
SELECT 
	<col1>
	,<col2>
	,<col3>
	,level
FROM <cteName> [OPTION (MAXRECURSION <nubmer>)];
```
</p>				
			</li>			
			<li>See Exercise <a href="./Chapter%2011/RecursiveCTE.sql">RecursiveCTE</a></li>
		</ul>
	</li>
</ol>

### Isolating Aggregate Query Logic ###
<ol>
	<li>There are several techniques that allow you to separate an aggregate query from the rest of the statement
		<ul>
			<li>This is needed because the grouping levels and the columns that must be displayed are not compatible</li>
		</ul>
	</li>
	<li><b>Correlated sub-queries in the SELECT list</b>
		<ul>
			<li>It is best to avoid this technique because if the query contains more than one <b>correlated subquery</b>, performance will quickly deteriorate</li>
			<li>They syntax for this technique:
<p>

```SQL
SELECT
	<select list>,
	(SELECT <aggregate function>(<col1>)
	 FROM <table2> WHERE <col2> = <table1>.<col3>) AS <alias name>
FROM <table1>;
		
```
</p>
			</li>
			<li><b>IMPORTANT:</b> The subquery must produce only one row for each row of the outer query, and only one expression may be returned from the subquery
				<ul>
					<li>The subquery executes once for each row of the outer query</li>
				</ul>
			</li>					
			<li>See Exercise <a href="./Chapter%2011/IsolatingAggregateLogic.sql">IsolatingAggregateLogic</a></li>
		</ul>
	</li>
	<li><b>Using Derived Tables</b>
		<ul>
			<li>Derived tables are a way for you to treat the results of a query as a table itself in the context of the <b>JOIN</b> clause for the outer select statement of a query</li>
			<li>The syntax for a derived table:
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,<col3>
FROM <table1> a
JOIN (SELECT 
		<col3>
		,<aggregate function>(<col2>) AS <col4>
	  FROM <table2>
	  GROUP BY <col3>) AS <alias> ON a.<col1> = b.<col3>;
```
</p>				
			</li>
			<li>The derived table technique generally has much better performance than the same correlated subquery</li>			
			<li>See Exercise <a href="./Chapter%2011/IsolatingAggregateLogic.sql">IsolatingAggregateLogic</a></li>
		</ul>
	</li>
	<li><b>Using CROSS APPLY and OUTER APPLY</b>
		<ul>
			<li>The <b>CROSS APPLY</b> and <b>OUTER APPLY</b> were originally intended to enable joining to <b>table-valued functions</b>, but they can be used similarly to join to a derived table</li>
			<li>The function(or subquery) on the right will be called once for every row from the table on the left</li>
			<li>Use <b>OUTER APPLY</b> like a <b>LEFT JOIN</b> to return a row from the left even if there is nothing returned on the right.</li>
			<li>This technique generally does not perform well for large tables</li>
			<li>See Exercise <a href="./Chapter%2011/IsolatingAggregateLogic.sql">IsolatingAggregateLogic</a></li>
		</ul>
	</li>
</ol>

### The OUTPUT Clause ###
<ol>
	<li>The <b>OUTPUT</b> clause gives you access to special tables, <b>DELETED</b> and <b>INSERTED</b>
		<ul>
			<li>There is no <b>UPDATED</b> table, instead you will find the previous record values in <b>DELETED</b> and the new values within <b>INSERTED</b></li>
		</ul>
		<li>Here are some of the examples of using the OUTPUT CLAUSE
<p>

```SQL
--Update style 1 
UPDATE a
SET <col1> = <value>
OUTPUT deleted.<col1>, inserted.<col1>
FROM <table1> a;

--Update style 2
UPDATE <table1>
SET <col1> = <value>
OUTPUT deleted.<col1>, inserted.<col1>
WHERE <criteria>;

--Insert style 1
INSERT INTO <table1>(<col1>,<col2>)
OUTPUT inserted.<col1>, inserted.<col2>
SELECT
	<col1>
	,<col2>
FROM <table2>;

--Insert style 2
INSERT INTO <table1>(<col1>,<col2>)
OUPUT inserted.<col1>, inserted.<col2>
VALUES(<value1>,<value2>);

--Delete style 1
DELETE [FROM] <table1>
OUTPUT deleted.<col1>, deleted.<col2>
WHERE <criteria>;

--Delete style 2 
DELETE [FROM] a
OUTPUT deleted.<col1>, deleted.<col2>
FROM <table1> a;
```
</p>			
		</li>
		<li>Another use of the OUTPUT clause is to use it to insert data into a table:
<p>

```SQL
INSERT [INTO] <table1>(<col1>,<col2>)
OUTPUT inserted.<col1>, inserted.<col2>
INTO <table2>
SELECT
	<col3>
	,<col4>
FROM <table3>;
```
</p>			
		</li>
	</li>
</ol>

### The MERGE Statement ###
<ol>
	<li>The <b>MERGE</b> statement, also known as the <b>upsert</b>, allows you to bundle INSERT, UPDATE, and DELETE operations into a single statement 
		<ul>
			<li>This can be used to perform complex operations such as synchronizing the contents of one table with another</li>
			<li>Can also be used for Data Warehouse operations to sync one DB's tables with another's</li>
		</ul>
	</li>
	<li>The syntax <b>MERGE</b>
<p>

```SQL
MERGE <target table>
USING <source table name>|<query> AS alias [(column names)]
ON (<join criteria>)
WHEN MATCHED [AND <other criteria>]
THEN UPDATE SET <col1> = alias.<value>
WHEN NOT MATCHED BY TARGET [AND <other criteria>]
THEN INSERT (<column list>) VALUES (<values>) --rows inserted into the target
WHEN NOT MATCHED BY SOURCE [AND <other criteria>]
THEN DELETE --row is deleted from target
[OUTPUT $action, DELETED.*, INSERTED.*];
```
</p>	
		<ul>
			<li>The syntax (albeit a bit daunting), can be thought of in 3 parts
				<ul>
					<li><b>WHEN MATCHED</b>: Specifies the action to be performed if a row from the <b>source</b> table matches the <b>target</b> table</li>
					<li><b>WHEN NOT MATCHED BY TARGET</b>: Specifies the action to be performed when a row is missing in the <b>target</b> table but is present in the source table</li>
					<li><b>WHEN NOT MATCHED BY SOURCE</b>: Specifies the action to be performed when the row is in the <b>target</b> table but is missing in the <b>source</b> table</li>
				</ul>
			</li>
			<li>The <b>$action</b> option shows you which action is performed on each row (from the above 3 options).</li>
			<li><b>IMPORTANT:</b> when reading through the logic of a MERGE statement, remember that all INSERTS and DELETES are happening with respect to the <b>target</b> table</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2011/Merge.sql">Merge</a></li>
</ol>

### GROUPING SETS ###
<ol>
	<li>An alternative to combining multiple aggregate queries with a <b>UNION</b>, is to use <b>GROUPING SETS</b>
		<ul>
			<li>This allows you to combine different grouping levels within one statement</li>
			<li>Follows the syntax:
<p>

```SQL
SELECT
	<col1>
	,<col2>
	,<aggregate function>(<col3>)
FROM <table1>
WHERE <criteria>
GROUP BY GROUPING SETS(<col1>,<col2>);
```
</p>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2011/GroupingSets.sql">GroupingSets</a></li>
</ol>

### CUBE and ROLLUP ###
<ol>
	<li>These functions allow you to add subtotals to your aggregate queries within the GROUP BY
		<ul>
			<li><b>CUBE</b> will give subtotals for every possible combination of the grouping levels</li>
			<li><b>ROLLUP</b> will give subtotals for the hierarchy</li>
			<li>Example of the difference:
				<ul>
					<li>If you are grouping by three columns, CUBE will provide subtotals for every grouping column</li>
					<li>ROLLUP will provide subtotals for the first two columns but not the last column in the GROUP BY</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Syntax for CUBE and ROLLUP:
<p>

```SQL
SELECT 
	<col1>
	,<col2>
	,<aggregate expression>
FROM <table1>
GROUP BY <CUBE or ROLLUP>(<col1>,<col2>);
```
</p>	
	</li>	
	<li>See Exercise <a href="./Chapter%2011/CubeRollup.sql">CubeRollup</a></li>
</ol>

### Pivoted Queries ###
<ol>
	<li>A pivoted query displays the values of one column as column headers instead</li>
	<li><b>Pivoting Data with CASE</b>
		<ul>
			<li>Essentially you use sever CASE expressions in the query, one for each pivoted column header.</li>
			<li>The syntax:
<p>

```SQL
SELECT <col1>
	CASE <col1>
		,SUM(CASE <col3> WHEN <value1> THEN <col2> ELSE 0 END) AS <alias1>
		,SUM(CASE <col3> WHEN <value2> THEN <col2> ELSE 0 END) AS <alias2>
		,SUM(CASE <col3> WHEN <value3> THEN <col2> ELSE 0 END) AS <alias3>
FROM <table1>
GROUP BY <col1>
```
</p>
			</li>			
			<li>See Exercise <a href="./Chapter%2011/CasePivot.sql">CasePivot</a></li>
		</ul>
	</li>
	<li><b>Pivoting Data with Pivot function</b>
		<ul>
			<li>Introduced in SQL Server 2005, SSMS also has a Pivot function that can be used</li>
			<li>The syntax:
<p>

```SQL
SELECT 
	<groupingCol>
	,<pivotedValue1> [AS <alias1>]
	,<pivotedValue2> [AS <alias2>]
FROM (SELECT 
		<groupingCol1>
		,<value column>
		,<pivoted column>) AS <queryAlias>
PIVOT
(
	<aggregate function>(<value column>)
	FOR <pivoted column> 
	IN(<pivotedValue1>,<pivotedValue2>)
) AS <pivotAliasa>
[ORDER BY <groupingCol>];
```
</p>
			</li>
			<li>The SELECT part of the query lists any non-pivoted columns along with the values from pivoted columns</li>
			<li>The values from pivoted columns will become the column names in your query</li>
			<li>Honestly, I would rather use the CASE version of PIVOT because the function syntax is hard for me to wrap my head around</li>			
			<li>See Exercise <a href="./Chapter%2011/PivotFunction.sql">PivotFunction</a></li>
		</ul>
	</li>
</ol>

### Paging ###
<ol>
	<li><b>Paging</b> is a SQL technique that allows you to display a certain amount of data at a time</li>
	<li>Paging via <b>ROW_NUMBER</b>
		<ul>
			<li>This technique uses the window framing function to partition the data into frames based on the page size</li>
		</ul>
	</li>
	<li>Paging via <b>OFFSET/FETCH NEXT</b>
		<ul>
			<li><b>OFFSET</b> specifies how many rows to skip</li>
			<li><b>FETCH NEXT</b> specifies how many rows to return</li>
			<li>When used in conjunction, the two keywords tell the DB engine how many rows to skip over(previous pages) and then how many rows to return(current page size)</li>
			<li>A simple example
				<ul>
					<li>
<p>

```SQL
OFFSET @PageSize * (@PageNo -1) ROWS FETCH NEXT @PageSize ROWS ONLY
```
</p>
					</li>
					<li>Lets say <b>@PageSize = 5</b> and <b>@PageNo = 2</b>
						<ul>
							<li>This would evaluate to OFFSET (5 * 1) ROWS FETCH NEXT 5 ROWS ONLY</li>
							<li>This would give us records starting with record 6-10
								<ul>
									<li>5 rows skipped (1-5), 5 rows returned (6-10)</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2011/Paging.sql">Paging</a></li>
</ol>

## Chapter 12: Understanding T-SQL Logic ##
### Temporary Tables and Table Variables ###
<ol>
	<li>Temporary Tables
		<ul>
			<li>Local Temp Tables
				<ul>
					<li>Scope:
						<ul>								
							<li>When creating a <b>local</b> temp table, you limit access to the table to be only within the connection where it was created</li>
							<li>When the connection closes, the DB engine destroys the temp table</li>							
						</ul>
					</li>
					<li>Local temp tables live in <b>tempdb</b> instead of a user database like AdventureWorks</li>
					<li>To create local temp tables you place a <b>#</b> in front of the table name</li>
				</ul>
			</li>
			<li>Global Temp Tables
				<ul>
					<li>Scope:
						<ul>
							<li>When creating a <b>global</b> temp table, ANY connection can see the temp table</li>
							<li>When the <b>LAST</b> connection that can see the temp table closes (even if that connection did not create it), then the DB engine will destroy it.</li>
						</ul>
					</li>
					<li>To create local temp tables you place <b>##</b> in front of the table name</li>
				</ul>
			</li>
			<li>Syntax for temp tables:
<p>

```SQL
CREATE TABLE [#]#tableName(<col1> <datatype>, <col2> <datatype>)
```
</p>
			</li>
		</ul>
	</li>
	<li>Table Variables
		<ul>
			<li>A common misconception about table variables is that they live in memory instead of tempdb
				<ul>
					<li>This is not true, table variables also live in tempdb</li>
				</ul>
			</li>
			<li>Scope:
				<ul>
					<li>Table variables go out of scope at the end of the batch, not when the connection closes</li>
				</ul>
			</li>
			<li>Syntax for table variable:
<p>

```SQL
DECLARE [@]@tableName TABLE(<col1> <datatype> [PRIMARY KEY], <col2> <datatype>)
```
</p>				
			</li>
		</ul>
	</li>
	<li>Using a Temp Table or a Table Variable
		<ul>
			<li>Table variables do <b>NOT</b> contain statistics
				<ul>
					<li>Statistics help the optimizer come up with a good query plan</li>
				</ul>
			</li>
			<li><b>IMPORTANT:</b>Temp tables are a better choice for tables with large numbers of rows that could benefit from statistics or when you need the table after the batch is complete</li>
			<li>One area of table variable use vs temp tables is within a function
				<ul>
					<li>Since function only allow <b>idempotent</b> operations, temp tables are not allowed in a function</li>
					<li>This means that table variables are your construct of choice when writing logic for a function</li>
				</ul>
			</li>
			<li>Starting with SQL Server 2014, memory-optimized table variables are available with the new <b>In-Memory OLTP</b> (aka <b>Hekaton</b>) features
				<ul>
					<li>https://www.red-gate.com/simple-talk/sql/learn-sql-server/introducing-sql-server-in-memory-oltp/
						<ul>
							<li>Taken form the above article:

>As well as the “Durability” setting in the memory-optimized table definitions, you also need to take non-clustered indexes into consideration. Memory-optimized tables do not support clustered indexes but do however support non-clustered indexes (currently up to eight). Along with each index specification you will also need to specify the BUCKET_COUNT value. The recommended value for this, is to be between 1.5 and 2 times the estimated number of unique values (500 unique products in this example) for the column indexed by the non-clustered index. If you estimate that you are going to have large tables (i.e. with over 5 million unique values or more), then for saving up memory consumption you can set the Bucket_Count value to 1.5 times the number of unique values. In the opposite case you can set the Bucket_Count value to 2 times the number of unique values.
							</li>
						</ul>
					</li>
					<li>For configuration: https://www.sqlpassion.at/archive/2014/06/16/configuring-the-in-memory-oltp-file-group-for-high-performance/</li>					
					<li>See Exercise <a href="./Chapter%2012/Hekaton.sql">Hekaton</a></li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Using a Temp Table or Table Variable Like an Array
		<ul>			
			<li>See Exercise <a href="./Chapter%2012/TableVarAsArray.sql">TableVarAsArray</a></li>
		</ul>
	</li>
</ol>

### Cursors ###
<ol>
	<li>Cursors provide another way to loop through a result set
		<ul>
			<li>This concept is often overused and results in poorly performing code because it forces execution to be iterative (row by row) instead of set based</li>
			<li>When working with a cursor, you must declare a variable for each column the cursor returns for each row (based on the cursor definition)</li>
			<li>When you include the <b>FAST_FORWARD</b> option in the cursor declaration, it makes the cursor read-only and you can only go forward in the data
				<ul>
					<li>This helps improve cursor performance</li>
				</ul>
			</li>
			<li>An example of a cursor definition:
<p>

```SQL
DECLARE @ProductID INT
	   ,@Name VARCHAR(25)

DECLARE products CURSOR FAST_FORWARD FOR 
SELECT 
	ProductID
	,Name
FROM Production.Product;

OPEN products

FETCH NEXT FROM products INTO @ProductID, @Name;
```
</p>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2012/Cursor.sql">Cursor</a></li>
</ol>

## Chapter 13: Managing Transactions ##
### ACID Properties ###
<ol>
	<li>One of the most common questions asked during a interview for database developer jobs is to explain the ACID principals of a DB</li>
</ol>

| Property		| Purpose				   																												|
| --------------| ---------------------------------------------------------------------------------------------------------------------------------- 	|
| Atomicity		| 	A transaction is one unit of work																									|
| Consistency	| 	A transaction must leave the DB in a consistent state. A transaction must follow the rules, like constraints, defined in the DB  	|
| Isolation		| 	A transaction cannot affect other transactions																						|
| Durability	|	Once a transaction has been committed, it will not be lost, even after a reboot or power outage  									|

### Writing Explicit Transactions ###
<ol>
	<li>Once a transaction starts, the DB engine puts locks on rows or tables involved within the transaction so that rows usually may not be accessed by another query when the default settings are in place
		<ul>
			<li>Common syntax for a transaction:
<p>

```SQL
BEGIN TRAN|Transaction	
	<statement1>
	<statement2>
COMMIT [TRAN|TRANSACTION];
```
</p>
			</li>
		</ul>
	</li>
	<li>Rolling back a transaction
		<ul>
			<li>Before rolling back a transaction, you can also check the <b>@@TRANCOUNT</b> variable
				<ul>
					<li>This is a count of the BEGIN TRAN statements and it resets to 0 after a COMMIT or ROLLBACK</li>
				</ul>
			</li>
			<li>Common syntax for rolling back a transaction:
<p>

```SQL
BEGIN TRAN|Transaction
	<statement1>
	<statement2>
ROLLBACK [TRAN|TRANSACTION]
```
</p>
			</li>
			<li>You can also use the <b>XACT_ABORT</b> setting to automatically rollback a transaction should an error occurred
				<ul>
					<li>Enable the XACT_ABORT option with the following syntax:
<p>

```SQL
SET XACT_ABORT ON;
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>

### Error Handling ###
<ol>
	<li>T-SQL has two ways of dealing with errors
		<ul>
			<li>The legacy way was by checking the value of the <b>@@ERROR</b> function
				<ul>
					<li>This is typically messy and inefficient (hence the <b>legacy</b> designation)</li>
				</ul>
			</li>
			<li>TRY...CATCH blocks</li>
		</ul>
	</li>
</ol>

#### TRY...CATCH ####
<ol>
	<li>Using the <b>TRY...CATCH</b> approach
		<ul>
			<li>One benefit gained by this approach is that functions retain their values while in the CATCH block
				<ul>
					<li>These values can be accessed as many times as needed</li>
					<li>Once outside of the CATCH block, the values of the error functions will revert to NULL</li>
					<li>See the table below for common error functions that are accessible in the CATCH BLOCK</li>
				</ul>
			</li>
			<li>Syntax for the TRY...CATCH block
<p>

```SQL
BEGIN TRY
	<statements that may cause an error>
END TRY
BEGIN CATCH
	<statments to access error information and deal with error>
END CATCH
```
</p>
			</li>			
			<li>See Exercise <a href="./Chapter%2013/TryCatch.sql">TryCatch</a></li>
		</ul>
	</li>
</ol>

| Function			| Purpose				   																						|
| ------------------| ------------------------------------------------------------------------------------------------------------ 	|
| ERROR_NUMBER()	| Provides the error number. This was the only information you could get in previous SQL Server releases		|
| ERROR_SEVERITY()	| Provides the severity of the error. <b>The severity must exceed 10 in order to be trapped</b>	 				|
| ERROR_STATE()		| Provides the state code of the error. This refers to the cause of the error									|
| ERROR_PROCEDURE	| Returns the name of the stored procedure or trigger that caused the error										|
| ERROR_LINE()		| Returns the line number that caused the error																	|
| ERROR_MESSAGE()	| Returns the actual text message describing the error															|

#### Viewing Untrappable Errors ####
<ol>
	<li>Some errors are not caught within the context of a TRY...CATCH block
		<ul>
			<li>An example would be if a SQL batch has an incorrect table or column name or the DB is not available, then the entire batch will fail and the error will not be trapped</li>
			<li>An interesting workaround to see these untrappable errors is to encapsulate the logic within the offending stored procedure and then call the procedure
				<ul>
					<li>Essentially, go and add TRY...CATCH block to the potential error throwing parts of the stored procedure logic and then call the SP to see if the TRY...CATCH will then report the error.</li>
				</ul>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2013/UntrappableError.sql">UntrappableError</a></li>
</ol>

#### Using RAISEERROR ####
<ol>
	<li>Whenever you need to DB to fire an error even if the logic did not result in a database error, you will use the <b>RAISEERROR</b> function
		<ul>
			<li>This function allows you to check a logic condition and then create an error that will be raised back to the calling client application</li>
			<li>The syntax for RAISEERROR:
<p>

```SQL
RAISEERROR(<message>,<severity>,<state>)
```
</p>
			</li>
			<li>You can also create a reusable custom error message by using the <b>sp_addmessage</b> stored procedure
				<ul>
					<li>Alternatively, you can use a variable or hard-coded string with RAISEERROR</li>
				</ul>
			</li>
			<li>In terms of the <b>severity</b> indicated when invoking RAISEERROR, you will normally use <b>16</b> for errors correctable by the user</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2013/RaiseError.sql">RaiseError</a></li>
</ol>

#### Using THROW Instead of RAISEERROR ####
<ol>
	<li>Staring with SQL SERVER 2012, The THROW statement can also be used to generate errors
		<ul>
			<li>Using <b>THROW</b> is generally much simpler than using RAISEERROR</li>
			<li>The syntax for THROW:
<p>

```SQL
THROW [{error_number| message | state}] [;]
```
</p>
			</li>
			<li>Any error occurring in the THROW statement will cause the batch to end</li>
			<li>The THROW severity will always be <b>16</b></li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2013/Throw.sql">Throw</a></li>
</ol>

### Isolation Levels ###
<ol>
	<li>SQL SERVER has several <b>isolation levels</b> to control how transactions from one connection affect statements from another connection.
		<ul>
			<li>The default isolation level is <b>Read Committed</b>
				<ul>
					<li>This means that while a transaction happens, other connections cannot see the data that the transaction has locked</li>
				</ul>
			</li>
			<li>Some prefer to use the <b>Read Uncommitted</b> isolation level lock
				<ul>
					<li>This isolation level allows other connections to see data that another connection has modified but HAS NOT committed yet
						<ul>
							<li>This results in what is called a <b>dirty read</b>, in that the data being viewed by another connection is data that has yet to be committed to the DB</li>
						</ul>
					</li>
					<li>This is the least restrictive level available</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Starting with SQL SERVER 2005, Microsoft introduced a new type of isolation level called <b>Snapshot</b>
		<ul>
			<li>This isolation level creates copies of the data in tempdb before the data is changed
				<ul>
					<li>This is called <b>row versioning</b></li>
				</ul>
			</li>
			<li>Any reads of the data during the transaction comes from the row version copies</li>
			<li>That way updates to the data do not block reads of the data</li>
		</ul>
	</li>
</ol>

## Chapter 14: Implementing Logic in the Database ##
<ol>
	<li>Previous chapters worked with tables using <b>Data Manipulation Language (DML)</b>
		<ul>
			<li>DML based logic was seen when you insert/update/delete rows</li>
		</ul>
	</li>
	<li>This chapter focuses on <b>Data Definition Language (DDL)</b>
		<ul>
			<li>This type of SQL logic defines database objects and constraints that can then be interacted with via DML queries</li>
		</ul>
	</li>
</ol>

### Tables ###
<ol>
	<li>Adding Check Constraints on to a Table
		<ul>
			<li>A <b>CHECK</b> constraint allows you to ensure that a value inserted into a table column is within an acceptable defined range of values</li>
			<li>Syntax for a Check constraint:
<p>

```SQL
--Adding during Create Table
CREATE TABLE <table name>(<col1> <data type>, <col2> <data type>)
CONSTRAINT <constraint name> CHECK(<condition>);

--Adding during Alter Table
ALTER TABLE <table name> ADD CONSTRAINT <constraint name> CHECK(<condition>);
```
</p>
			</li>			
			<li>See Exercise <a href="./Chapter%2014/CheckConstraint.sql">CheckConstraint</a></li>
		</ul>
	</li>
	<li>Adding <b>UNIQUE</b> constraints
		<ul>
			<li><b>IMPORTANT:</b>Unlike primary keys, UNIQUE columns may contain <b>only one NULL value</b></li>
			<li>The syntax for adding UNIQUE Constraints:
<p>

```SQL
--Adding a unique constraint to individual columns
CREATE TABLE <table name> (<col1> <data type> UNIQUE, <col2> <data type> UNIQUE);

--Adding a unique constraint, but including a constraint name
CREATE TABLE <table name> (<col1> <data type>, <col2> <data type>,
	CONSTRAINT <constraint name1> UNIQUE (col1),
	CONSTRAINT <constraint name2> UNIQUE (col2));
	
--Adding a combination constraint
CREATE TABLE <table name> (<col1> <data type>, <col2> <data type>,
	CONSTRAINT <constraint name> UNIQUE (<col1>, <col2>));

--Add a constraint with ALTER table
CREATE TABLE  <table name> (<col1> <data type>, <col2> <data type>);-
ALTER TABLE [<table name>] 
ADD CONSTRAINT <constraint name> UNIQUE (<col1, <col2>);

```
</p>
			</li>
			<li>An interesting note about <b>UNIQUE</b> constraints is that they are listed under the <b>Indexes and Keys</b> sections within SSMS
				<ul>
					<li>This is a directory under the <b>Tables</b> directory</li>
					<li>They are under this section as opposed to the <b>Constraint</b> section</li>
					<li><b>IMPORTANT:</b> When you create a UNIQUE constraint, you are actually creating a unique <b>INDEX</b>
						<ul>
							<li>The below statement was take from <a href="https://docs.microsoft.com/en-us/sql/relational-databases/indexes/create-unique-indexes?view=sql-server-2017">here</a>
							
>When you create a UNIQUE constraint, a unique <b>nonclustered</b> index is created to enforce a UNIQUE constraint by default. You can specify a unique clustered index if a clustered index on the table does not already exist.
							</li>
						</ul>
					</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2014/UniqueConstraint.sql">UniqueConstraint</a></li>
		</ul>
	</li>
	<li>Adding Primary Key to a Table
		<ul>
			<li>A primary key for table must have the following traits:
				<ul>
					<li>Must be made of one column or multiple columns (called a composite key)</li>
					<li>A table can have only <b>ONE</b> primary key</li>
					<li>The values of the primary key must be <b>unique</b></li>
					<li>If the primary key is a composite key, the combination of values must be unique</li>
					<li>None of the columns contained within the primary key can have a value of NULL</li>
				</ul>
			</li>
			<li>The main purpose of a primary key is to ensure data consistency</li>
			<li>By default, if no clustered index already exists on the table, the primary key will become a clustered index
				<ul>
					<li>You will often see the clustered index composed of a smaller column, such as an single INT column</li>
					<li>This technique normally uses the <b>IDENTITY</b> keyword to make the INT column a surrogate key for the table</li>
					<li>Surrogate keys allow your primary keys to remain small and "narrow"
						<ul>
							<li>Remember the "wider" the index, the more reads SQL SERVER will have to perform to retrieve results</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Syntax for creating Primary keys:
<p>

```SQL
--Single column key
CREATE TABLE <table name> 
(
	<column1> <data type> NOT NULL PRIMARY KEY [CLUSTERED|NONCLUSTERED], 
	<column2> <data type>
);

--Single column key with name
CREATE TABLE <table name> 
(
	<column1> <data type> NOT NULL, 
	<column2> <data type>,
	CONSTRAINT <constraint name> PRIMARY KEY  [CLUSTERED|NONCLUSTERED] (<column1>)
);

--Composite key
CREATE TABLE <table name> 
(
	<column1> <data type> NOT NULL, 
	<column2> <data type> NOT NULL,
	<column3> <data type>,
	CONSTRAINT <constraint name> PRIMARY KEY  [CLUSTERED|NONCLUSTERED] (<column1>,<column2>)
);

--Using ALTER table
ALTER TABLE <table name> ADD CONSTRAINT <primary key name>
PRIMARY KEY [CLUSTERED|NONCLUSTERED](<column1>);
```
</p>				
			</li>			
			<li>See Exercise <a href="./Chapter%2014/PrimaryKey.sql">PrimaryKey</a></li>
		</ul>
	</li>
	<li>Defining Automatically Populated Columns
		<ul>
			<li><b>IDENTITY</b>
				<ul>
					<li>A table may contain only one <b>IDENTITY</b> column</li>
					<li>By default, IDENTITY columns begin with the value 1 and increment by 1</li>
					<li>You can specify different values by specifying seed and increment values</li>
					<li>You may not insert values into IDENTITY columns unless you use the IDENTITY_INSERT setting</li>
					<li>Syntax for Identity columns:
<p>

```SQL
--IDENTITY
CREATE TABLE <table name>
(
	<col1> INT NOT NULL IDENTITY[(<seed>,<increment>)]
	,<col2> <data type>
);
```
</p>
					</li>
				</ul>
			</li>
			<li><b>ROWVERSION</b>, originally TIMESTAMP
				<ul>
					<li>The ROWVERSION value will be unique within the database</li>
					<li>A table may contain only one ROWVERSION column</li>
					<li>You may not insert values into ROWVERSION columns</li>
					<li>Each time you update the row, the ROWVERSION value changes
						<ul>
							<li>This can be used by applications to check if a value has been updated since the last time they pulled data</li>
						</ul>
					</li>
					<li>Syntax for ROWVERSION:
<p>

```SQL
--ROWVERSION, originally TIMESTAMP
CREATE TABLE <table name>
(
	<col1> <data type>
	,<col2> ROWVERSION
);
```
</p>
					</li>
				</ul>
			</li>
			<li><b>COMPUTED</b>
				<ul>
					<li>A table may contain multiple COMPUTED columns</li>
					<li>Do not specify a data type for COMPUTED columns</li>
					<li>You may not insert values int COMPUTED columns</li>
					<li>By specifying the option PERSISTED, the database engine stores the value in the table</li>
					<li>You can define indexes on deterministic COMPUTED columns</li>
					<li>You an specify other non-Computed columns, literal values, and scalar functions in the COMPUTED column definition</li>
					<li>Syntax for COMPUTED columns:
<p>

```SQL
CREATE TABLE <table name>
(
	<col1> <data type>
	,<col2> AS <computed column definition> [PERSISTED]
);
```
</p>
					</li>
				</ul>
			</li>
			<li><b>DEFAULT</b>
				<ul>
					<li>When inserting rows, you do not need to specify a value for a column with a DEFAULT value defined</li>
					<li>You can use expressions with literal values and scalar functions, but not other column names with DEFAULT value columns</li>
					<li>If a column with a DEFAULT value specified allows NULL values, you can still specify NULL for the column</li>
					<li>You can use the new SEQUENCE object and the NEXT VALUE FOR function as a default to insert incrementing values</li>
					<li>Syntax for DEFAULT columns:
<p>

```SQL
CREATE TABLE <table name>
(
	<col1> <data type> DEFAULT <defualt value or function>
);
```
</p>
					</li>
				</ul>
			</li>
			<li>See Exercise <a href="./Chapter%2014/AutoPopulatingColumns.sql">AutoPopulatingColumns</a></li>
		</ul>
	</li>
</ol>

### Views ###
<ol>
	<li>Important notes on VIEWS
		<ul>
			<li>Vies do not store data, they are just saved query definitions</li>
			<li>You can use views as a security layer
				<ul>
					<li>You can give the end user permission to select from a view without giving permission to the underlying tables that the view pulls from</li>
				</ul>
			</li>
			<li>An <b>indexed view</b> (also known as a <b>materialized view</b>) actually does contain data
				<ul>
					<li>To create an indexed view, add a clustered index to the view</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Creating Views
		<ul>
			<li>To create a view you need only specify the name as well as the query that the view represents</li>
			<li>Syntax for working with Views:
<p>

```SQL
CREATE VIEW <view name> AS
SELECT 
	<col1>
	,<col2> 
FROM <table>;

ALTER VIEW <view name> As
SELECT 
	<col1>
	,<col2> 
FROM <table>;

DROP VIEW <view name>;
```
</p>				
			</li>
			<li><b>IMPORTANT:</b> Any time you create or alter a VIEW, the code must be contained within a batch that has not other code except for comments
				<ul>
					<li>If wish to include CREATE/ALTER statements for views within a larger script, put GO statements before and after the CREATE/ALTER statements</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2014/Views.sql">Views</a></li>
		</ul>
	</li>
	<li>Common problems with Views
		<ul>
			<li>While views provide a consolidated way to retrieve data from multiple tables, it is generally unwise to retrieve data through many layers of views
				<ul>
					<li>Meaning a view that calls a view that also calls a view and so on.</li>
					<li>Multiple layers of views can also make it difficult for SQL Server to come up with a good execution plan</li>
				</ul>
			</li>
			<li>If the underlying table structure changes, the views may produce strange results
				<ul>
					<li>To avoid this particular problem, you can define a view with the <b>SCHEMABINDING</b> option
						<ul>
							<li>This prevents the underlying table the view is dependent upon from changing</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Avoid adding an ORDER BY to the view definition
				<ul>
					<li>This is actually disallowed except under certain specific conditions and does not make sense because the ORDER BY can always be added to the outer query that referenced the view</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Manipulating data with Views
		<ul>
			<li>You can modify the data of a table by updating a view as long as the view meets the below criteria:
				<ul>
					<li>Modifying the data of a view by inserting or updating may affect only one base table</li>
					<li>You may not delete data from a view that consists of more than one table</li>
					<li>The columns updated must be directly linked to modifiable table columns
						<ul>
							<li>You a cannot update a view based on an expression or an otherwise non-modifiable column (like IDENTITY for instance)</li>
						</ul>
					</li>
					<li>Inserts into views are possible only if all columns that require a value are exposed through the view</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2014/ModifyDataViaView.sql">ModifyDataViaView</a></li>
		</ul>
	</li>
</ol>

### User-Defined Functions ###
<ol>
	<li>Important Notes on User-Defined Functions
		<ul>
			<li>By creating a User-Defined Function (UDF), you can reuse code to simplify development and hide complex logic</li>
			<li><b>CAUTION:</b> using a UDF can negatively impact performance due to the overhead of calling the function on each row</li>
		</ul>
	</li>
	<li>Creating User-Defined Functions
		<ul>
			<li>One type of UDF is the <b>scalar</b> UDF
				<ul>
					<li>The scalar UDF returns one parameter and may take one or more parameters</li>
					<li>Some useful facts about scalar UDFs to keep in mind:
						<ul>
							<li>They can be used almost anywhere in a T-SQL statement</li>
							<li>They can accept one or more parameters</li>
							<li>The return <b>one</b> value</li>
							<li>They can use logic such as IF blocks and WHILE loops</li>
							<li>They can access data, though this is sometimes not a good idea
								<ul>
									<li>Scalar UDFs should generally not be dependent on the tables in a particular database</li>
								</ul>
							</li>
							<li>They <b>cannot</b> update data</li>
							<li>They can call other functions</li>
							<li>Their definition must include a return value3</li>
						</ul>
					</li>
					<li>Syntax for scalar UDF:
<p>

```SQL
CREATE FUNCTION <scalar function name> (<@param1> <data type>, <@param2> <data type>)
RETURNS <data type> AS
BEGIN
	<statements>
	RETURN <value>
END;


ALTER FUNCTION <scalar function name> ([<@param1> <data type>, <@param2> <data type>])
RETURNS <data type> AS
BEGIN
	<statements>
	RETURN <value>
END;

DROP FUNCTION <scalar function name>;
```
</p>
					</li>					
					<li>See Exercise <a href="./Chapter%2014/ScalarUDF.sql">ScalarUDF</a></li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Using Table-Valued User-Defined Functions
		<ul>
			<li>The second type of UDF is the <b>table-valued</b>UDF</li>
			<li>You cannot use this UDF in the SELECT statement of a query, but you can use it in place of a table within the JOIN logic</li>
			<li>There are two types of table-valued UDFs
				<ul>
					<li>The <b>inline table-valued UDF</b> contains only a SELECT statement</li>
					<li>The other type contains multiple statements</li>
				</ul>
			</li>
			<li>The sample AdventureWorks DB has one example of this type of UDF (<b>dbo.ufnGetContactInformation</b>)</li>
			<li>Look at <b>Chapter14/TabledValuedUDF</b> for this UDF's create logic</li>
		</ul>
	</li>
</ol>

### Stored Procedures ###
<ol>
	<li>Using Default Values with Parameters
		<ul>
			<li>SQL Server requires that you supply a value for each parameter unless you define a default value for the parameter</li>
			<li>Whenever the parameter has a default value, you can skip sending that value when making the SP call</li>
		</ul>
	</li>
	<li>Using the OUTPUT parameter
		<ul>
			<li>You can use the OUPUT parameter to get back a value form a stored procedure directly into a variable</li>
			<li>This is one of those grey areas where you may decided to use a scalar UDF unless the SP has other logic that is not possible in a scalar UDF</li>
			<li><b>IMPORTANT:</b> If the logic is not portable to any database, use a stored procedure
				<ul>
					<li>Scalar UDFs are for database agnostic functionality</li>
				</ul>
			</li>
			<li>Syntax for creating a SP with an OUTPUT clause:
<p>

```SQL
CREATE PROC[EDURE] <proc name> <@param> <data type> OUTPUT 
AS
<statements>
[<return value>];
GO

--Sample call to OUTPUT based SP
DECLARE <@variable> <data type>
EXEC <proc name> [<param> =] <@variable> Output --@variable will hold the value returned from the SP OUPUT logic
PRINT <variable>;
```
</p>				
			</li>			
			<li>See Exercise <a href="./Chapter%2014/ProcOutput.sql">ProcOutput</a></li>
		</ul>
	</li>
	<li>Saving the Results of a SP to a Table
		<ul>
			<li>One use of calling a stored procedure is to save the results in a temp table to work with latter in the batch</li>
			<li>In order for this to work, the column data types of the temp table must match <b>EXACTLY</b> what is being returned from the SP
				<ul>
					<li>This means the columns must match in column numbers, Order, and Type or else it will generate an error</li>
				</ul>
			</li>
			<li>To me (Dennis not the author), this is a very brittle solution
				<ul>
					<li>If the SELECT of the SP changes in anyway, you will break any logic that is saving calls to that SP into temp tables.</li>
					<li>I personally will use a tabled-valued UDF since you can choose to insert only what you want from the returned data of the UDF and ignore other parts returned.</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2014/ProcTableInsert.sql">ProcTableInsert</a></li>
		</ul>
	</li>
</ol>

### Key Differences of Views, UDFs, and Stored Procedures ###

| Feature 										| SP 	|	Scalar UDF	|	Table UDF	|	View	|
| --------------------------------------------- | -----	| ------------- | ------------- | --------- |
| Return Tabular Data							| Yes	|	No			|	Yes			|	Yes		|	
| Return multiple sets of data					| Yes	|	N/A			|	No			|	No		|	
| Update data									| Yes	|	No			|	No			|	No		|	
| Create other objects							| Yes	|	No			|	No			|	No		|	
| Call from a procedure							| Yes	|	Yes			|	Yes			|	Yes		|	
| Can call a procedure							| Yes	|	No			|	Yes			|	Yes		|	
| Can call a function							| Yes	|	Yes			|	Yes			|	Yes		|	
| Can call within a SELECT list					| No	|	Yes			|	No			|	No		|	
| Use to populate multiple columns in a table	| Yes	|	No			|	Yes			|	Yes		|	
| Return value required							| No	|	Yes			|	Yes (table)	|	N/A		|	
| Return value optional							| Yes	|	No			|	No			|	No		|	
| Takes parameters								| Yes	|	Yes			|	Yes			|	No		|	
| Output parameters								| Yes	|	No			|	No			|	No		|	

### User-Defined Data Types ###
<ol>
	<li>A <b>User-Defined data type</b> (UDTs), are nothing more that native data types that have been given a specific name or alias
		<ul>
			<li>This ability enables you to make sure that a particular type of column is consistently defined throughout the database</li>
			<li>In reality, UDTs are not used very often</li>
			<li>Syntax for a UDT:
<p>

```SQL
CREATE TYPE <type name> FROM <native type and size> [NULL|NOT NULL];
```
</p>
			</li>
			<li>Checking for custom UDTs:
<p>

```SQL
IF EXISTS
(
	SELECT NULL 
	FROM sys.types st
	JOIN sys.schemas ss ON st.schema_id = ss.schema_id
	WHERE st.name = N'CustomerID'
	  AND ss.name = 'dbo'
)
BEGIN
	DROP TYPE dbo.CustomerID;
END;
```
</p>
			</li>
		</ul>
	</li>
</ol>

### User-Defined Types ###
<ol>
	<li>This type of object is not a <b>data</b> type, in that it defines its own type using the .NET language's CLR data type
		<ul>
			<li>These CLR types can contain multiple properties and can contain methods</li>
		</ul>
	</li>
</ol>

#### Table Types ####
<ol>
	<li>A table type allows you to pass tabular data to a stored procedure in the form of a table variable
		<ul>
			<li>Starting with 2008, the table type is available to enable stored procedures to accept multiple rows at once and treat the variable inside the procedure as a table
				<ul>
					<li>This can be leveraged to join to other tables, insert rows, or update existing data</li>
					<li>When a table variable is used to pass data to a stored procedure that is of a User-defined table type, that variable is referred to as a <b>table-valued parameter</b>
						<ul>
							<li><b>IMPORTANT:</b> When calling a SP with a table-valued parameter, the SP definition must define the table-valued parameter as <b>READONLY</b></li>
						</ul>
					</li>
				</ul>
			</li>
			<li>As part of the In-Memory OLTP (Hekaton) feature in 2014, the table types can be configured to reside only in memory
				<ul>
					<li>Traditional table variables are actually created on disk in tempdb</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Syntax for creating a table type:
<p>

```SQL
CREATE TYPE <schema>.<tableName> 
AS TABLE
(
	<col1> <data type>,
	<col2> <data type>
);
```
</p>
	</li>	
	<li>See Exercise <a href="./Chapter%2014/CreateTableType.sql">CreateTableType</a></li>
</ol>

## Chapter 15: Working with XML ##
### Converting XML using OPENXML ###
<ol>
	<li>There are two primary reasons for handling XML in SQL
		<ul>
			<li>You want to convert an XML document into a rowset(table)
				<ul>
					<li>Converting an XML document into a rowset is called <b>shredding</b></li>
				</ul>
			</li>
			<li>You have a row set and want to convert it to XML</li>
		</ul>
	</li>
	<li><b>OPENXML</b> is a tool that allows you to shred XML documents
		<ul>
			<li>You use OPENXML in conjunction with two other built in SQL Server commands
				<ul>
					<li><b>sp_xml_preparedocument</b>
						<ul>
							<li>This loads the XML document into memory</li>
							<li>This process is expensive and takes up to one-eighth of the SQL Server's total memory</li>
						</ul>
					</li>
					<li><b>sp_xml_removedocument</b>
						<ul>
							<li>This removes the XML document from memory and should be run at the end of the script.</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>When OPENXML is used, SQL server will predefine the columns of no column specifications are used
		<ul>
			<li>These column names are based on the XML <b>edge table format</b>
				<ul>
					<li>This format is the default structure for XML represented int table format</li>
				</ul>
			</li>			
			<li>See Exercise <a href="./Chapter%2015/DefaultOpenXML.sql">DefaultOpenXML</a></li>
		</ul>
	</li>
	<li>If you want to specify your own column definitions during the shredding, you can use the <b>WITH</b> clause
		<ul>			
			<li>See Exercise <a href="./Chapter%2015/CustomOpenXML.sql">CustomOpenXML</a></li>
		</ul>
	</li>
</ol>

### Formatting Data as XML using FOR XML ###

| Mode 		| Description	|
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RAW		| Easiest to use but provides the least flexibility, Each row creates a single element.																									  |
| AUTO		| Similar to <b>RAW</b> but provides more flexibility. Each column returned is an element and each referenced table with a column in the SELECT clause is an element.					  |
| EXPLICIT	| Difficult to use but provides improved granularity for creating complex XML documents. Allows you to mix attributes and elements but requires specific syntax structure in the SELECT clause |
| PATH		| It is recommended that PATH mode is used instead of EXPLICIT. This mode provides similar functionality but with less complexity.														  |

#### FOR XML RAW ####
<ol>
	<li><b>RAW</b> is the simplest mode but provides the least flexibility when generating XML from rowsets.
		<ul>
			<li><b>RAW</b> mode produces a single node "row" for each row returned and each element has a column-based attribute</li>
			<li>By default, <b>RAW</b> mode produces an attribute-centric XML document</li>
			<li>Sample call syntax for <b>FOR XML RAW</b>
<p>

```SQL
SELECT TOP(5) 
	FirstName
	,LastName
FROM Person.Person
FOR XML RAW ('NAME'), ELEMENTS;
```
</p>
				<ul>
					<li>This would produce:
						<ul>
							<li>
<p>

```XML
<NAME>
  <FirstName>Syed</FirstName>
  <LastName>Abbas</LastName>
</NAME>
<NAME>
  <FirstName>Catherine</FirstName>
  <LastName>Abel</LastName>
</NAME>
<NAME>
  <FirstName>Kim</FirstName>
  <LastName>Abercrombie</LastName>
</NAME>
<NAME>
  <FirstName>Kim</FirstName>
  <LastName>Abercrombie</LastName>
</NAME>
<NAME>
  <FirstName>Kim</FirstName>
  <LastName>Abercrombie</LastName>
</NAME>
```
</p>
							</li>
						</ul>
					</li>
					<li>The <b>ELEMENTS</b> option converts the columns from attributes to elements within the NAME node</li>
				</ul>
			</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2015/ForXmlAuto.sql">ForXmlAuto</a></li>
</ol>

#### FOR XML AUTO ####
<ol>
	<li><b>AUTO</b> creates an element for each table in the FROM clause that has a column in the SELECT clause
		<ul>
			<li>Each column in the SELECT clause is represented as an attribute in the XML document</li>
		</ul>
	</li>
	<li>Sample call for <b>FOR XML AUTO</b>
<p>

```SQL
SELECT TOP(5) 
	Customer.CustomerID
	,Person.LastName
	,Person.FirstName
	,Person.MiddleName
FROM Person.Person Person
JOIN Sales.Customer Customer ON Person.BusinessEntityID = Customer.PersonID
ORDER BY Customer.CustomerID
FOR XML AUTO;

```
</p>
		<ul>
			<li>Produces:
				<ul>
					<li>
<p>

```XML
<Customer CustomerID="11000">
  <Person LastName="Yang" FirstName="Jon" MiddleName="V" />
</Customer>
<Customer CustomerID="11001">
  <Person LastName="Huang" FirstName="Eugene" MiddleName="L" />
</Customer>
<Customer CustomerID="11002">
  <Person LastName="Torres" FirstName="Ruben" />
</Customer>
<Customer CustomerID="11003">
  <Person LastName="Zhu" FirstName="Christy" />
</Customer>
<Customer CustomerID="11004">
  <Person LastName="Johnson" FirstName="Elizabeth" />
</Customer>
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>You can also add the <b>ELEMENTS</b> option to display columns as elements for each node instead of attributes
		<ul>
			<li>One difference of the result using ELEMENTS within AUTO from RAW is that the ElementName exclusion (where RAW would note this as: RAW('NAME'))</li>
			<li>This is because AUTO mode automatically names the nodes after the name of each table</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2015/ForXmlAuto.sql">ForXmlAuto</a></li>
</ol>

#### FOR XML EXPLICIT ####
<ol>
	<li>This mode is the most complicated of the approaches to convert rowsets into XML
		<ul>
			<li>The complexity lies in the rigorous requirement that you structure your SELECT clause so the output forms a <b>universal table</b></li>
			<li>This is done by creating two columns: <b>Tag</b> and <b>Parent</b>
				<ul>
					<li>The relationship between <b>Tag</b> and <b>Parent</b> can be thought in the same terms of Manager and Employee</li>
					<li>The manager would have a tag ID of 1, and the employee would have a tag ID of 2</li>
					<li>The manager would have a parent ID value of 0 but the employee would have a parent ID of 1 (the manager)</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Sample call for <b>FOR XML EXPLICIT</b>
<p>

```SQL
SELECT TOP(5) 
	   1		  AS Tag,
       NULL       AS Parent,
       CustomerID AS [Customer!1!CustomerID],
       NULL       AS [Name!2!FName],
       NULL       AS [Name!2!LName]
FROM Sales.Customer AS C
INNER JOIN Person.Person AS P
ON  P.BusinessEntityID = C.PersonID
UNION 
SELECT TOP(5) 
	   2 AS Tag,
       1 AS Parent,
       CustomerID,
       FirstName,
       LastName
FROM Person.Person P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY [Customer!1!CustomerID], [Name!2!FName]
FOR XML EXPLICIT;
```
</p>
		<ul>
			<li>Would produce:
				<ul>
					<li>
<p>

```XML
<Customer CustomerID="11000">
  <Name FName="Jon" LName="Yang" />
</Customer>
<Customer CustomerID="11001">
  <Name FName="Eugene" LName="Huang" />
</Customer>
<Customer CustomerID="11002">
  <Name FName="Ruben" LName="Torres" />
</Customer>
<Customer CustomerID="11003">
  <Name FName="Christy" LName="Zhu" />
</Customer>
<Customer CustomerID="11004">
  <Name FName="Elizabeth" LName="Johnson" />
</Customer>
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>In addition to the <b>Tag</b> and <b>Parent</b> values, the universal table also defines where values exist in the hierarchy using the <b>ElementName!TagNumber!Attribute</b> notation.</li>
	<li>There is also an optional <b>Directive</b> value when creating the universal table
		<ul>
			<li>The format is: <b>ElementName!TagNumber!Attribute!Directive</b></li>
			<li>This allows you to control how to encode values (ID, IDREF, IDREFS) and how to map string data into XML(hide, element, elementxsinil, xml, xmltext, and cdata)</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2015/ForXmlExplicit.sql">ForXmlExplicit</a></li>
</ol>

#### FOR XML PATH ####
<ol>
	<li>This option represents the best approach if you need to develop complex XML documents
		<ul>
			<li><b>PATH</b> simplifies the task of creating complex XML document by taking advantage of the <b>XPath</b> standard
				<ul>
					<li><b>XPath</b> is a W3C standard for navigating XML hierarchies</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Sample call for <b>FOR XML PATH</b>:
<p>

```SQL
SELECT TOP(3) 
	p.FirstName
    ,p.LastName 
    ,s.Bonus
    ,s.SalesYTD
FROM Person.Person p
JOIN Sales.SalesPerson s ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY SalesYTD DESC
FOR XML PATH;
```
</p>
		<ul>
			<li>Would produce:
				<ul>
					<li>
<p>

```XML
<row>
  <FirstName>Linda</FirstName>
  <LastName>Mitchell</LastName>
  <Bonus>2000.0000</Bonus>
  <SalesYTD>4251368.5497</SalesYTD>
</row>
<row>
  <FirstName>Jae</FirstName>
  <LastName>Pak</LastName>
  <Bonus>5150.0000</Bonus>
  <SalesYTD>4116871.2277</SalesYTD>
</row>
<row>
  <FirstName>Michael</FirstName>
  <LastName>Blythe</LastName>
  <Bonus>4100.0000</Bonus>
  <SalesYTD>3763178.1787</SalesYTD>
</row>
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Without any modification, the XML PATH mode will create simple element-centric XML documents
		<ul>
			<li>Producing an element for each row</li>
		</ul>
	</li>
	<li>If you want to enhance the format, you can easily mix and match element and attribute centric XML document styles
		<ul>
			<li><b>IMPORTANT:</b>When mapping columns to an XML document:
				<ul>
					<li>Any column defined with an at (@) sign becomes an attribute of the node</li>
					<li>Any column defined with a forward slash (/) becomes a separate element</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/ForXmlPath.sql">ForXmlPath</a></li>
</ol>


### XML Data Type ###
<ol>
	<li>Since SQL Server 2005, you can define a column to have a data type of <b>XML</b>
		<ul>
			<li>It cannot be used as a primary or foreign key</li>
			<li>You cannot convert or cast the column to a <b>text</b> or <b>ntext</b> data type
				<ul>
					<li>Use <b>VARCHAR(max)</b> and <b>NVARCHAR(MAX)</b></li>
				</ul>
			</li>
			<li>Column cannot be used in a GROUP BY statement</li>
			<li>The data cannot exceed 2GB</li>
		</ul>
	</li>	
	<li>See Exercise <a href="./Chapter%2015/XmlDataType.sql">XmlDataType</a></li>
</ol>

### XML Methods ###
<ol>
	<li>XML methods provide ways to handle XML in the XML Data type
		<ul>
			<li>They allow you to update the XML, convert the XML to rowsets (shred), check whether the XML has nodes, and so on</li>
		</ul>
	</li>
</ol>

| Methods					|	Description																		|
|-------------------------- | --------------------------------------------------------------------------------- |
| query(xquery)				|	Executes an XQuery against the XML data type. Returns an XML type 				|
| value(xquery, sqltype)	|	Executes an XQuery against the XML data type and returns an SQL scalar value 	|				
| exist(xquery)				|	Executes an XQuery against the XML data type and returns a bit value representing a criteria of 1 if there is at least one node, 0 if there are no nodes, and NULL if the XML data type in the XQuery is NULL 																		  |
| modify(xml_dml)			|	Used to update XML stored as the XML data type									|
| nodes()					|	Used to convert(shred) an XML data type into a rowset(table). If you want to convert XML into a relational form, use this method|

#### The QUERY method ####
<ol>
	<li>The <b>QUERY</b> method will extract elements form an XML column or variable
		<ul>
			<li>When the query method is used, its return value is still of the XML type(element and value)</li>
			<li>Sample syntax:
<p>

```SQL
CREATE TABLE #Bikes(ProductID INT, ProductDescription XML);

--The Query method is invoked on the XML column and returns all rows in which the sought after node matches the query predicate
--The returned node is also of the XML data type
SELECT 
	ProductID
	,ProductDescription.query('Product/ListPrice') AS ListPrice
FROM #Bikes;

```
</p>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/XmlQueryMethod.sql">XmlQueryMethod</a></li>
</ol>

#### The VALUE Method ####
<ol>
	<li>The <b>VALUE</b> method allows you to extract just the sought after element's value
		<ul>
			<li>This means you do not return the element tag (like in the <b>QUERY</b>method)</li>
			<li>The value is returned as a <b>scalar</b> value</li>
			<li>The Value method takes a second argument that will specify the data type of the returned value
				<ul>
					<li>Because this is a scalar function, if you want the first occurrence you will have to specify an index of [1]</li>
				</ul>
			</li>
			<li>If you are working with an XML document that contains <b>attributes</b> instead of nested elements, you can specify the attribute using the <b>@</b> symbol</li>
			<li>Sample Syntax:
<p>

```SQL
CREATE TABLE #Bikes(ProductID INT, ProductDescription XML);

SELECT 
	ProductID
	,ProductDescription.query(('Product/ListPrice')[1], 'Money') AS ListPrice
FROM #Bikes;
```
</p>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/XmlValueMethod.sql">XmlValueMethod</a></li>
</ol>

#### The EXISTS Method ####
<ol>
	<li>The <b>EXISTS</b> method will allow you to search fro specific values in the XML
		<ul>
			<li>The method will return a <b>1</b> if the value is found or a <b>0</b> if it is not present within the XML</li>
			<li>Similar to the <b>Value</b> method, you must specify the particular instance of the element you are looking for
				<ul>
					<li>Denoted with the index designation, [#]</li>
				</ul>
			</li>
			<li>When working with dates in XML along with EXIST, you must cast the XML value to a date</li>
			<li>Sample Syntax:
<p>

```SQL
CREATE TABLE #Bikes(ProductID INT, ProductDescription XML);

--Using exist to filter down the elements that match its predicate statement and then return those elements values
SELECT ProductID, 
    ProductDescription.value('(/Product/ListPrice)[1]', 'MONEY') AS ListPrice
FROM #Bikes
WHERE ProductDescription.exist('/Product/ListPrice[text()[1] lt 3000]') = 1;
```
</p>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/XmlExistsMethod.sql">XmlExistsMethod</a></li>
</ol>

#### The MODIFY Method ####
<ol>
	<li>The <b>MODIFY</b> will modify the data stored as an XML Data type
		<ul>
			<li>The <b>MODIFY</b> is similar to using update, insert, and delete commands
				<ul>
					<li>The primary difference is that the <b>MODIFY</b> method can only be used in a <b>SET</b> clause of an UPDATE statement or the SET statement</li>
				</ul>
			</li>
			<li>Sample syntax:
<p>

```SQL
DECLARE @x xml =
'<Product ProductID = "521487">
  <ProductType>Paper Towels</ProductType>
  <Price>15</Price>
  <Vendor>Johnson Paper</Vendor>
  <VendorID>47</VendorID>
  <QuantityOnHand>500</QuantityOnHand>
</Product>';

--Inserting data into xml with the modify method 
SET @x.modify('
INSERT <WarehouseID>77</WarehouseID>
INTO (/Product)[1]');
```
</p>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/XmlModifyMethod.sql">XmlModifyMethod</a></li>
</ol>

#### The NODES Method ####
<ol>
	<li>The <b>NODES</b> method can be used in conjunction with the VALUES method to <b>shred</b> XML documents
		<ul>
			<li>An example of using NODES with VALUE:
<p>

```SQL
DECLARE @XML XML = '
<Product>
	<ProductID>749</ProductID>
	<ProductID>749</ProductID>
	<ProductID>750</ProductID>
	<ProductID>751</ProductID>
	<ProductID>752</ProductID>
	<ProductID>753</ProductID>
	<ProductID>754</ProductID>
	<ProductID>755</ProductID>
	<ProductID>756</ProductID>
	<ProductID>757</ProductID>
	<ProductID>758</ProductID>
</Product>';

--Shred the document by parsing each ProductID into a 'node' and then extracting its value via the VALUE method
SELECT P.ProdID.value('.', 'INT') as ProductID
FROM @XML.nodes('/Product/ProductID') P(ProdID);
```
</p>
				<ul>
					<li>This would produce a record set with a single column named <b>ProductID</b> and each row containing the associated value of the current ProductID node</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/XmlNodesMethod.sql">XmlNodesMethod</a></li>
</ol>

#### Namespaces ####
<ol>
	<li>XML uses namespaces to uniquely define an element and attribute names in an XML document
		<ul>
			<li>XML data can be typed (lacks namespace) or typed (elements are namespaced)</li>
			<li>XML data that is <b>typed</b> is associated with a schema
				<ul>
					<li>The schema represents the explicit definition for that document</li>
				</ul>
			</li>
			<li><b>IMPORTANT:</b> If you use one of the XML methods on a column in which the data is typed (element is namespaced), you <b>MUST</b> include the namespace in you XML method query</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2015/Namespaces.sql">Namespaces</a></li>
</ol>

## Chapter 16: Expanding on Data Type Concepts ##
### FILESTREAM ###
<ol>
	<li><b>FILESTREAM</b> is SQL Server's method of large document storage
		<ul>
			<li>This technique stores the file on a file system (network share) and creating a link to it via the filestream data type settings</li>
			<li>SQL Server recommends using the <b>FILESTREAM</b> type if files are over 1MB ins size</li>
		</ul>
	</li>
	<li>Steps for setting up a FILESTREAM
		<ul>
			<li>Launch the SQL Server Configuration Manager
				<ul>
					<li>I had to path to this and launch it from <b>C:\Windows\SysWOW64\SQLServerManager14.msc</b></li>
				</ul>
			</li>
			<li>Select SQL Server Services and locate the SQL Server instance</li>
			<li>Click the instance and select the FILESTREAM tab
				<ul>
					<li>Make sure all of the options are enabled</li>
					<li>By checking <b>Enable FILESTREAM for I/O access</b>, you will turn on the FileTable functionality
						<ul>
							<li>This allows remote access to users from other systems to access the file</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Click OK, restart SQL Server</li>
			<li><b>NOTE:</b> SQL Server Databases have a minimum of two files: the data file and the log file.
				<ul>
					<li>To use FILESTREAM functionality in a database, you will add a special <b>filegroup</b> and add a file to the filegroup</li>
				</ul>
			</li>
			<li>Right click the database in the Object Explorer and select Properties
				<ul>
					<li><b>NOTE:</b> This is not the top-level icon representing the DB server, you have to expand that and then find the DB name and right click that for the pages you need</li>
				</ul>
			</li>
			<li>Select <b>FileGroups</b></li>
			<li>In the FILESTREAM section, click Add FileGroup</li>
			<li>Type the name you want for the new Filestream.</li>
			<li>Select the Files page</li>
			<li>Click Add, and then type the name you want for the logical file of the file steam</li>
			<li>Under <b>File Type</b> select FILESTREAM Data </li>
			<li>Find the <b>Path</b> property of the File you logical file row
				<ul>
					<li>Click the ellipsis button to set the location of the new file</li>
					<li>Make note of this Path property as it will be where data is saved.</li>
				</ul>
			</li>
			<li>Once this is finished and you click OK, your database is now setup to work with FILESTREAM data</li>
			</ul>
		</ol>
	</li>
</ol>

### Enhanced Date and Time ###
#### DATE, TIME, DATETIME2 ####
<ol>
	<li>These data types allow you to store either just the DATE or TIME component of a date value
		<ul>
			<li>TIME and DATETIME2 allow you to specify the precision of the TIME component from 0 to 7 decimal places</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2016/DateTimeAndDatetime2.sql">DateTimeAndDatetime2</a></li>
</ol>

#### DATETIMEOFFSET ####
<ol>
	<li>The <b>DATETIMEOFFSET</b> contains the Date and Time components but also the ability to work with time zone offsets 
		<ul>
			<li>This represents the difference between UTC date/time and the stored date</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2016/DateTimeOffset.sql">DateTimeOffset</a></li>
</ol>

### Spatial Data Types ###
<ol>
	<li>SQL Server has two CLR data types, GEOMETRY and GEOGRAPHY, that fall into the category of <b>spatial</b> data types</li>
</ol>

#### GEOMETRY ####
<ol>
	<li>This CLR data type can store points, lines and polygons
		<ul>
			<li>You can then use this data to calculate the difference between two shapes, determine where they intersect and much more</li>
			<li>The database engine will store the data as a binary value</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2016/Geometry.sql">Geometry</a></li>
</ol>

#### GEOGRAPHY ####
<ol>
	<li>Using <b>GEOGRAPHY</b>, you can store longitude and latitude values for actual locations or areas
		<ul>
			<li>You can use the built in SQL Server function to then calculate distance between stored locations</li>
		</ul>
	</li>
	<li>See Exercise <a href="./Chapter%2016/Geography.sql">Geography</a></li>
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

# Appendix B: Default Query template #
<ol>
	<li>In order for SQL Server to launch a new query window with default code (such as common comments), we have to modify the base template file
	<li>Navigate to the directory:
		<ul>
			<li><b>C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\SqlWorkbenchProjectItems\Sql</b></li>
			<li>Open the file named <b>SQLFile.sql</b>
				<ul>
					<li><b>NOTE:</b> You need to open the editor this launches in (such as notepad++) in Admin mode</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Once the file is opened, enter the default SQL you want in any file launched in SSMS using the <b>New Query</b> toolbar option.</li>
	<li>For more information, see this article: https://sqlstudies.com/2015/06/11/modifying-the-new-query-template </li>
</ol>






