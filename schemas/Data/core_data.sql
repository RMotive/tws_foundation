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
		( '', '' );


	insert into Profiles(Name, Description)
	values
		('Guard', 'Specifies permits for yard guards');

	insert into Permits(A)
		select 'Login', 'Permit to login into TWS Guard solution', id, 'TWSMG001' 
			from Solutions where Sign = 'TWSMG';

	insert into Profiles_Permits (Permit, Profile)
		select p.id, pr.id
			from Permits p
				join Solutions s on p.Solution = s.id
				join Profiles pr ON pr.Name = 'Guard'
			where s.Sign = 'TWSMG';
end
go