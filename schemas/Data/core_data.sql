USE [TWS Security]
begin	
	
	insert into Solutions(Name, Sign, Description, Timestamp)
	values
		( 'TWS Foundation' , 'TWSMF' , 'Solution to serve over a centralize way the business data through security mechanisms' , GETUTCDATE() );

	insert into Solutions(Name, Sign, Description, Timestamp)
	values
		( 'TWS Guard' , 'TWSMG', 'Solution exclusive to Guard members, used to log yard truck movements', GETUTCDATE() );

	insert into Solutions(Name, Sign, Description, Timestamp)
	values
		( 'TWS Administration' , 'TWSMA', 'Solution to manage the whole suit of business solutions and data, for management and administration', GETUTCDATE() );
	
	insert into Features(Name, Description) 
	values
		( 'Access', 'Access to solutions feature.' );

	insert into Actions(Name, Description)
	values
		('Login', 'Login action into solutions.');

	insert into Profiles(Name, Description)
	values
		('Guard', 'Specifies permits for yard guards');

	insert into Permits(Action, Feature, Solution, Reference)
	values(
		( select id from Actions where Name = 'Login' ),
		( select id from Features where Name = 'Access' ),
		( select id from Solutions where Sign = 'TWSMG' ),
		'TWSMG001'
	);

	insert into Profiles_Permits (Permit, Profile)
	values(
		( select id from Permits where Reference = 'TWSMG001' ),
		( select id from Profiles where name = 'Guard' )
	);
end
go