use [TWS Security];

select * from Permits;

select * from Solutions;

select * from Profiles;

select * from Profiles_Permits;

insert into Solutions(Name, Sign, Description)
	values('TWS Guard', 'TWSMG', 'Solution exclusive to Guard members, used to log yard truck movements');

insert into Profiles(Name, Description)
	values('Guard', 'Specifies permits for yard guards');

insert into Permits(Name, Description, Solution, Reference)
	select 'Login', 'Permit to login into TWS Guard solution', id, 'TWSMG001' 
		from Solutions where Sign = 'TWSMG';

insert into Profiles_Permits (Permit, Profile)
	select p.id, pr.id
		from Permits p
			join Solutions s on p.Solution = s.id
			join Profiles pr ON pr.Name = 'Guard'
		where s.Sign = 'TWSMG';