



use [TWS Security];
begin
	insert into Features(Name, Description, Timestamp)
	values
		('Development', 'Suit of application details only available under development contexts and runtime', GETUTCDATE() );

	insert into Actions(Name, Description, Timestamp)
	values
		('Qualify', 'Describes the action of running quality suits of solutions at development time', GETUTCDATE() );

	insert into Permits(Solution, Feature, Action, Reference, Timestamp)
	values
		( (select id from Solutions where Sign = 'TWSMF'), (select id from Features where Name = 'Development' ), (select id from Actions where Name = 'Qualify'), 'TWSMFD01', GETUTCDATE() );
	

	-- Inserting development contacts --
	insert into Contacts(Name, Lastname, Email, Phone) 
	VALUES 
		('dev', 'runner', 'dev_runner@tws.com', '0000000000'), 
		('qly', 'runner', 'qly_runner@tws.com', '0000000001');

	insert into Accounts([User],Password,Wildcard,Contact) 
	VALUES 
		('dev_runner', convert(varbinary, 'devrunner$2024'), 1, (select Id from Contacts where Name = 'dev')), 
		('qly_runner', convert(varbinary, 'qlyrunner$2024'), 1, (select Id from Contacts where Name = 'qly'));
	
	insert into Accounts_Permits(Account,Permit) 
	VALUES 
		( (select id from Accounts where [User] = 'qly_runner') , (select id from Permits where Reference = 'TWSMFD01') );
end;
go