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
					<li>Click the <b>FILESTREAM</b> tab and check all 3 checkboxes</li>
				</ul>				
			</li>
		</ul>
	</li>
	<li><b>SSMS Installation</b>
		<ul>
			<li>Once installed, I pinned the SSMS 2017 icon to the taskbar and started the application.</li>
			<li>Once started, I clicked the <b>Server name</b> dropdown
				<ul>
					<li>Selected <b>browse for more</b></li>
					<li>Expanded <b>Database Engine</b></li>
					<li>I selected the entry that matched the <b>Instance Name</b> from the <b>Sql Server Installation</b> process above (<b>BEGINNING_TSQL</b>)</li>	
					<li><b>NOTE:</b> This step initially did not work for me, I had to do the following
						<ul>
							<li>In the start menu, I typed <b>Sql Server</b> and opened the <b>Sql Server Configuration Manager</b></li>
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
			<li>For an example see <b>Chapter 3/Seek_Vs_Scan.sql</b></li>
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
		<ul>Both of these functions serve as a means to return the number of characters in a sring
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
			<li>See Exercise <b>Chpater4/Choose</b></li>
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
			<li>The values for the <b>Date Part</b> parameter</li>
			
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

			<li><b>NOTE:</b> T-SQL does not have a <b>DATESUBTRACT</b> but you can use a negative number to achieve the same effect.</li>
		</ul>
	</li>
</ol>

