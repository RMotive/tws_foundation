USE [TWS Security]
GO
/****** Object:  Table [dbo].[Permits]    Script Date: 08/04/2024 09:39:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permits](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](max) NULL,
	[solution] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Permits] ON 

INSERT [dbo].[Permits] ([id], [name], [description], [solution]) VALUES (1, N'Login', N'Allows the account to login into TWS Admin', 1)
INSERT [dbo].[Permits] ([id], [name], [description], [solution]) VALUES (2, N'Wildcard', N'Allows the account full access into TWS Admin', 1)
SET IDENTITY_INSERT [dbo].[Permits] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Permits__72E12F1BAEA504F0]    Script Date: 08/04/2024 09:39:28 p. m. ******/
ALTER TABLE [dbo].[Permits] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD FOREIGN KEY([solution])
REFERENCES [dbo].[Solutions] ([id])
GO
ALTER TABLE [dbo].[Permits]  WITH CHECK ADD FOREIGN KEY([solution])
REFERENCES [dbo].[Solutions] ([id])
GO
