USE [TWS Security]
GO
/****** Object:  Table [dbo].[Solutions]    Script Date: 08/04/2024 09:39:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solutions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[sign] [varchar](5) NOT NULL,
	[description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Solutions] ON 

INSERT [dbo].[Solutions] ([id], [name], [sign], [description]) VALUES (1, N'TWS Admin', N'TWSA', N'Solution that handles all administrative business operations')
SET IDENTITY_INSERT [dbo].[Solutions] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Solution__2F82F0C89DFAB179]    Script Date: 08/04/2024 09:39:28 p. m. ******/
ALTER TABLE [dbo].[Solutions] ADD UNIQUE NONCLUSTERED 
(
	[sign] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Solution__72E12F1B81AEDEF1]    Script Date: 08/04/2024 09:39:28 p. m. ******/
ALTER TABLE [dbo].[Solutions] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
