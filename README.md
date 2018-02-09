# Beginning T-SQL, 3rd Edition - Kathi Kellenberger and Scott Shaw (Apress, 2014)
Repository to hold notes/exercises from the book

## Chapter 1: Getting Started ##
### SQL Server Setup ###

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
