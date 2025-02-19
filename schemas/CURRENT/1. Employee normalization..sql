

-- [18.02-2025] Normalizing Employees Table -- 

use [TWS Business];

alter table Drivers drop constraint FK_Drivers_Employees;

drop table Employees;

create table Employees_Dates(
	[Id] bigint not null primary key identity(1, 1),
	[Timestamp] datetime not null default getutcdate(),

	CNAP date,
	IMSS date,
	Hire date,
	Termination date,
);

create table Employees(
	[Id] bigint not null primary key identity(1, 1),
	[Timestamp] datetime not null default getutcdate(),

	CURP nvarchar(18),
	RFC nvarchar(13),
	NSS nvarchar(11),

	Identification int not null,
	[Status] int not null,
	Dates bigint not null,
	[Address] int,
	Approach int,

	constraint FK_Employees_Identifications foreign key (Identification) references Identifications(Id),
	constraint FK_Employees_Statuses foreign key ([Status]) references Statuses(Id),
	constraint FK_Employees_Employees_Dates foreign key (Dates) references Employees_Dates(Id),
	constraint FK_Employees_Addresses foreign key ([Address]) references Addresses(Id),
	constraint FK_Employees_Approaches foreign key (Approach) references Approaches(Id),
);

alter table Drivers 
	alter column Employee bigint not null;
alter table Drivers
	add constraint FK_Drivers_Employees foreign key (Employee) references Employees(Id);


