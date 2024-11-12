use [TWS Security]
begin
	-- dropping deprecated tables ---
	drop table if exists 
		Accounts_Permits,
		Profiles_Permits,
		Permits,
		Actions,
		Features; 

	create table Actions(
		id integer not null primary key identity(1, 1),
		Name varchar(25) not null,
		Description text,
		Timestamp DateTime not null,
		Enabled bit not null default 1,

		constraint UC_Action_Name unique (Name),
	);

	create table Features(
		id integer not null primary key identity(1, 1),
		Name varchar(25) not null,
		Description text,
		Timestamp DateTime not null,
		Enabled bit not null default 1,

		constraint UC_Feature_Name unique (Name),
	);

	create table Permits(
		id integer not null primary key identity(1, 1),
		Solution int not null,
		Feature int not null,
		Action int not null,
		Reference nvarchar(8) not null,
		Timestamp datetime not null,
		Enabled bit not null default 1,

		constraint FK_Permits_Solutions foreign key (Solution) references Solutions(id),
		constraint FK_Permits_Features foreign key (Feature) references Features(id),
		constraint FK_Permits_Action foreign key (Action) references Actions(id),

		constraint UC_Permit unique (Solution, Feature, Action),
		constraint LC_Permit_Reference check (len(Reference) = 8),
	);

	create table Accounts_Permits(
		Account integer not null,
		Permit integer not null,

		constraint UC_Account_Permit unique (Account, Permit),
		constraint FK_Accounts_Permits_Account foreign key (Account) references Accounts(id),
		constraint FK_Accounts_Permits_Permit foreign key (Permit) references Permits(id),
	);

	create table Profiles_Permits(
		Profile integer not null,
		Permit integer not null,

		constraint UC_Profile_Permit unique (Profile, Permit),
		constraint FK_Profiles_Permits_Account foreign key (Profile) references Profiles(id),
		constraint FK_Profiles_Permits_Permit foreign key (Permit) references Permits(id),
	);
end;
go