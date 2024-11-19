select a.[User], p.Reference from Accounts a
	inner join Accounts_Permits ap on ap.Account = a.id
	inner join Permits p on p.id = ap.Permit