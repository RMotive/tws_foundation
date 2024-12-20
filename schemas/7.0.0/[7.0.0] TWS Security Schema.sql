USE [TWS Security]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 18/11/2024 04:18:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[User] [varchar](50) NOT NULL,
	[Password] [varbinary](max) NOT NULL,
	[Wildcard] [bit] NOT NULL,
	[Contact] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Contact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts_Permits]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts_Permits](
	[Account] [int] NOT NULL,
	[Permit] [int] NOT NULL,
 CONSTRAINT [UC_Account_Permit] UNIQUE NONCLUSTERED 
(
	[Account] ASC,
	[Permit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts_Profiles]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts_Profiles](
	[Account] [int] NOT NULL,
	[Profile] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Description] [text] NULL,
	[Timestamp] [datetime] NOT NULL,
	[Enabled] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Action_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Lastname] [varchar](50) NOT NULL,
	[Email] [varchar](30) NOT NULL,
	[Phone] [varchar](14) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Description] [text] NULL,
	[Timestamp] [datetime] NOT NULL,
	[Enabled] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Feature_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permits]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permits](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Solution] [int] NOT NULL,
	[Feature] [int] NOT NULL,
	[Action] [int] NOT NULL,
	[Reference] [nvarchar](8) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Enabled] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_Permit] UNIQUE NONCLUSTERED 
(
	[Solution] ASC,
	[Feature] ASC,
	[Action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](max) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profiles_Permits]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profiles_Permits](
	[Profile] [int] NOT NULL,
	[Permit] [int] NOT NULL,
 CONSTRAINT [UC_Profile_Permit] UNIQUE NONCLUSTERED 
(
	[Profile] ASC,
	[Permit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solutions]    Script Date: 18/11/2024 04:18:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solutions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Sign] [varchar](5) NOT NULL,
	[Description] [varchar](max) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [U_Sign] UNIQUE NONCLUSTERED 
(
	[Sign] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Sign] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Accounts] ADD  DEFAULT ((0)) FOR [Wildcard]
GO
ALTER TABLE [dbo].[Accounts] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Accounts_Profiles] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Actions] ADD  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Contacts] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Features] ADD  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Permits] ADD  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Profiles] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Solutions] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Contact] FOREIGN KEY([Contact])
REFERENCES [dbo].[Contacts] ([id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Contact]
GO
ALTER TABLE [dbo].[Accounts_Permits]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Permits_Account] FOREIGN KEY([Account])
REFERENCES [dbo].[Accounts] ([id])
GO
ALTER TABLE [dbo].[Accounts_Permits] CHECK CONSTRAINT [FK_Accounts_Permits_Account]
GO
ALTER TABLE [dbo].[Accounts_Permits]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Permits_Permit] FOREIGN KEY([Permit])
REFERENCES [dbo].[Permits] ([id])
GO
ALTER TABLE [dbo].[Accounts_Permits] CHECK CONSTRAINT [FK_Accounts_Permits_Permit]
GO
ALTER TABLE [dbo].[Accounts_Profiles]  WITH CHECK ADD  CONSTRAINT [FK_Account] FOREIGN KEY([Account])
REFERENCES [dbo].[Accounts] ([id])
GO
ALTER TABLE [dbo].[Accounts_Profiles] CHECK CONSTRAINT [FK_Account]
GO
ALTER TABLE [dbo].[Accounts_Profiles]  WITH CHECK ADD  CONSTRAINT [FK_Profile] FOREIGN KEY([Profile])
REFERENCES [dbo].[Profiles] ([id])
GO
ALTER TABLE [dbo].[Accounts_Profiles] CHECK CONSTRAINT [FK_Profile]
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD  CONSTRAINT [FK_Permits_Action] FOREIGN KEY([Action])
REFERENCES [dbo].[Actions] ([id])
GO
ALTER TABLE [dbo].[Permits] CHECK CONSTRAINT [FK_Permits_Action]
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD  CONSTRAINT [FK_Permits_Features] FOREIGN KEY([Feature])
REFERENCES [dbo].[Features] ([id])
GO
ALTER TABLE [dbo].[Permits] CHECK CONSTRAINT [FK_Permits_Features]
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD  CONSTRAINT [FK_Permits_Solutions] FOREIGN KEY([Solution])
REFERENCES [dbo].[Solutions] ([id])
GO
ALTER TABLE [dbo].[Permits] CHECK CONSTRAINT [FK_Permits_Solutions]
GO
ALTER TABLE [dbo].[Profiles_Permits]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Permits_Account] FOREIGN KEY([Profile])
REFERENCES [dbo].[Profiles] ([id])
GO
ALTER TABLE [dbo].[Profiles_Permits] CHECK CONSTRAINT [FK_Profiles_Permits_Account]
GO
ALTER TABLE [dbo].[Profiles_Permits]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Permits_Permit] FOREIGN KEY([Permit])
REFERENCES [dbo].[Permits] ([id])
GO
ALTER TABLE [dbo].[Profiles_Permits] CHECK CONSTRAINT [FK_Profiles_Permits_Permit]
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD  CONSTRAINT [LC_Permit_Reference] CHECK  ((len([Reference])=(8)))
GO
ALTER TABLE [dbo].[Permits] CHECK CONSTRAINT [LC_Permit_Reference]
GO
