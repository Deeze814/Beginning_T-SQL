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
SELECT * FROM Person.Address where intPersonID = 5;
```
</p>
					</li>
				</ul>
			</li>
		</ul>
	</li>
</ol>


