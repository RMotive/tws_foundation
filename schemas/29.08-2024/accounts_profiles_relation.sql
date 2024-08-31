use [TWS Security];

create table Accounts_Profiles(
	Account int not null,
	Profile int not null,

	constraint FK_Account foreign key (Account) references Accounts(id),
	constraint FK_Profile foreign key (Profile) references Profiles(id),
);