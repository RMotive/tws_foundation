
use [TWS Security];

	-- Regenerating [Solutions] --
	drop table if Exists Solutions;
	IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Solutions')
	BEGIN
		CREATE TABLE Solutions (
			Id bigint not null primary key identity(1, 1),
			[Name] varchar(100) not null unique,
			[Description] nvarchar(300),
			[Sign] char(5),
			[Timestamp] datetime not null default current_timestamp,
		);
	END
	
	-- Regenerating [Contacts] -- 
	drop table if Exists Contacts;
	IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Contacts')
	BEGIN
		CREATE TABLE Contacts (
			Id bigint not null primary key identity(1, 1),
			[Name] varchar(100) not null, -- Stored different names split by " " --
			Lastname varchar(100) not null,-- Stored different lastnames split by " " --
			EMail nvarchar(100) not null unique,
			Phone varchar(14) not null unique,
			[Sign] char(5),
			[Timestamp] datetime not null default current_timestamp,
		);
	END

	-- Regenerating [Accounts] --
	drop table if Exists Accounts;
	IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Accounts')
	BEGIN
		CREATE TABLE Accounts (
			Id bigint not null primary key identity(1, 1),

		);
	END