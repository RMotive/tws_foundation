USE [TWS Business]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 03/11/2024 12:01:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [varchar](3) NOT NULL,
	[State] [varchar](4) NULL,
	[Street] [varchar](100) NULL,
	[AltStreet] [varchar](100) NULL,
	[City] [varchar](30) NULL,
	[ZIP] [varchar](5) NULL,
	[Colonia] [varchar](30) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Approaches]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Approaches](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Email] [varchar](64) NOT NULL,
	[Enterprise] [varchar](14) NULL,
	[Personal] [varchar](13) NULL,
	[Alternative] [varchar](30) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Approaches_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Approaches_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Enterprise] [varchar](13) NULL,
	[Personal] [varchar](13) NULL,
	[Alternative] [varchar](30) NULL,
	[Email] [varchar](30) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carriers]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carriers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Approach] [int] NOT NULL,
	[Address] [int] NOT NULL,
	[USDOT] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carriers_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carriers_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[ApproachH] [int] NULL,
	[Address] [int] NOT NULL,
	[USDOTH] [int] NULL,
	[SCTH] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Employee] [int] NOT NULL,
	[Common] [int] NOT NULL,
	[DriverType] [varchar](16) NULL,
	[LicenseExpiration] [date] NULL,
	[DrugalcRegistrationDate] [date] NULL,
	[PullnoticeRegistrationDate] [date] NULL,
	[TWIC] [varchar](12) NULL,
	[TWICExpiration] [date] NULL,
	[VISA] [varchar](12) NULL,
	[VISAExpiration] [date] NULL,
	[FAST] [varchar](14) NULL,
	[FASTExpiration] [date] NULL,
	[ANAM] [varchar](24) NULL,
	[ANAMExpiration] [date] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers_Commons]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers_Commons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Situation] [int] NULL,
	[License] [varchar](12) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[License] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers_Externals]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers_Externals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Common] [int] NOT NULL,
	[Identification] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Identification] [int] NOT NULL,
	[Address] [int] NULL,
	[Approach] [int] NULL,
	[CURP] [varchar](18) NULL,
	[AntecedentesNoPenaleseExp] [date] NULL,
	[RFC] [varchar](12) NULL,
	[NSS] [varchar](11) NULL,
	[IMSSRegistrationDate] [date] NULL,
	[HiringDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Identifications]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Identifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[FatherLastname] [varchar](32) NOT NULL,
	[MotherLastName] [varchar](32) NOT NULL,
	[Birthday] [date] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Insurances]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Insurances](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Policy] [varchar](20) NOT NULL,
	[Expiration] [date] NOT NULL,
	[Country] [varchar](3) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Insurances_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Insurances_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Policy] [varchar](20) NOT NULL,
	[Expiration] [date] NOT NULL,
	[Country] [varchar](3) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Load_Types]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Load_Types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[Description] [varchar](100) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Address] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maintenances]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maintenances](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Anual] [date] NOT NULL,
	[Trimestral] [date] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maintenances_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maintenances_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Anual] [date] NOT NULL,
	[Trimestral] [date] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Description] [varchar](100) NULL,
	[Name] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plates]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Identifier] [varchar](12) NOT NULL,
	[State] [varchar](4) NULL,
	[Country] [varchar](3) NOT NULL,
	[Expiration] [date] NULL,
	[Truck] [int] NULL,
	[Trailer] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plates_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plates_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Identifier] [varchar](12) NOT NULL,
	[State] [varchar](4) NOT NULL,
	[Country] [varchar](3) NOT NULL,
	[Expiration] [date] NOT NULL,
	[Truck] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlatesTrucksH]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatesTrucksH](
	[Plateid] [int] NOT NULL,
	[Truckhid] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCT]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SCT](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Type] [varchar](6) NOT NULL,
	[Number] [varchar](25) NOT NULL,
	[Configuration] [varchar](10) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCT_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SCT_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[Type] [varchar](6) NOT NULL,
	[Number] [varchar](25) NOT NULL,
	[Configuration] [varchar](10) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sections]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sections](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Yard] [int] NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Ocupancy] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Situations]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Situations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailer_Classes]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailer_Classes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Description] [varchar](100) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailers]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Common] [int] NOT NULL,
	[Carrier] [int] NOT NULL,
	[Maintenance] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
	[SCT] [int] NULL,
	[Model] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailers_Commons]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailers_Commons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Economic] [varchar](16) NOT NULL,
	[Situation] [int] NULL,
	[Location] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
	[Type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailers_Externals]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailers_Externals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Common] [int] NOT NULL,
	[Carrier] [varchar](100) NOT NULL,
	[MxPlate] [varchar](12) NULL,
	[UsaPlate] [varchar](12) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailers_Inventories]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailers_Inventories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDate] [datetime2](7) NOT NULL,
	[section] [int] NOT NULL,
	[trailer] [int] NULL,
	[trailerExternal] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trailers_Types]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trailers_Types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Size] [varchar](16) NOT NULL,
	[TrailerClass] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trucks]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trucks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[VIN] [varchar](17) NOT NULL,
	[Common] [int] NOT NULL,
	[Motor] [varchar](16) NULL,
	[Carrier] [int] NOT NULL,
	[Maintenance] [int] NULL,
	[Insurance] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
	[SCT] [int] NULL,
	[Model] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trucks_Commons]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trucks_Commons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Economic] [varchar](16) NOT NULL,
	[Situation] [int] NULL,
	[Location] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trucks_Externals]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trucks_Externals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Common] [int] NOT NULL,
	[Carrier] [varchar](100) NOT NULL,
	[MxPlate] [varchar](12) NULL,
	[UsaPlate] [varchar](12) NULL,
	[VIN] [varchar](17) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trucks_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trucks_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[VIN] [varchar](17) NOT NULL,
	[Motor] [varchar](16) NULL,
	[Economic] [varchar](16) NOT NULL,
	[Manufacturer] [int] NOT NULL,
	[Situation] [int] NULL,
	[MaintenanceH] [int] NULL,
	[InsuranceH] [int] NULL,
	[CarrierH] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trucks_Inventories]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trucks_Inventories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDate] [datetime2](7) NOT NULL,
	[section] [int] NOT NULL,
	[truck] [int] NULL,
	[truckExternal] [int] NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USDOT]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USDOT](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[MC] [varchar](7) NULL,
	[SCAC] [varchar](4) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USDOT_H]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USDOT_H](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Timemark] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[Entity] [int] NOT NULL,
	[MC] [varchar](7) NULL,
	[SCAC] [varchar](4) NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicules_Models]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicules_Models](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[Year] [date] NOT NULL,
	[Manufacturer] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yard_Logs]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yard_Logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Entry] [bit] NOT NULL,
	[Timestamp] [datetime2](7) NULL,
	[Truck] [int] NULL,
	[TruckExternal] [int] NULL,
	[Trailer] [int] NULL,
	[TrailerExternal] [int] NULL,
	[LoadType] [int] NOT NULL,
	[Guard] [int] NOT NULL,
	[Gname] [varchar](100) NOT NULL,
	[Section] [int] NULL,
	[Seal] [varchar](64) NULL,
	[FromTo] [varchar](100) NOT NULL,
	[Damage] [bit] NOT NULL,
	[TTPicture] [varchar](max) NOT NULL,
	[DmgEvidence] [varchar](max) NULL,
	[Driver] [int] NULL,
	[DriverExternal] [int] NULL,
	[SealAlt] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Approaches] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Approaches_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Approaches_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Carriers] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Carriers_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Carriers_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Drivers] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Drivers_Commons] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Drivers_Externals] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Identifications] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Insurances] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Insurances_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Insurances_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Load_Types] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Locations] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Maintenances] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Maintenances_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Maintenances_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Manufacturers] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Plates] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Plates_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Plates_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[PlatesTrucksH] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[SCT] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[SCT_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[SCT_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Sections] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Situations] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Statuses] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trailer_Classes] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trailers] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trailers_Commons] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trailers_Externals] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trailers_Inventories] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trucks] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trucks_Commons] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trucks_Externals] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trucks_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[Trucks_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Trucks_Inventories] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[USDOT] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[USDOT_H] ADD  DEFAULT ((1)) FOR [Sequence]
GO
ALTER TABLE [dbo].[USDOT_H] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Approaches]  WITH CHECK ADD  CONSTRAINT [FK_Approaches_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Approaches] CHECK CONSTRAINT [FK_Approaches_Statuses]
GO
ALTER TABLE [dbo].[Approaches_H]  WITH CHECK ADD  CONSTRAINT [FK_ApproachesH_Approaches] FOREIGN KEY([Entity])
REFERENCES [dbo].[Approaches] ([id])
GO
ALTER TABLE [dbo].[Approaches_H] CHECK CONSTRAINT [FK_ApproachesH_Approaches]
GO
ALTER TABLE [dbo].[Approaches_H]  WITH CHECK ADD  CONSTRAINT [FK_ApproachesH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Approaches_H] CHECK CONSTRAINT [FK_ApproachesH_Statuses]
GO
ALTER TABLE [dbo].[Carriers]  WITH CHECK ADD  CONSTRAINT [FK_Carriers_Addresses] FOREIGN KEY([Address])
REFERENCES [dbo].[Addresses] ([id])
GO
ALTER TABLE [dbo].[Carriers] CHECK CONSTRAINT [FK_Carriers_Addresses]
GO
ALTER TABLE [dbo].[Carriers]  WITH CHECK ADD  CONSTRAINT [FK_Carriers_Approaches] FOREIGN KEY([Approach])
REFERENCES [dbo].[Approaches] ([id])
GO
ALTER TABLE [dbo].[Carriers] CHECK CONSTRAINT [FK_Carriers_Approaches]
GO
ALTER TABLE [dbo].[Carriers]  WITH CHECK ADD  CONSTRAINT [FK_Carriers_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Carriers] CHECK CONSTRAINT [FK_Carriers_Statuses]
GO
ALTER TABLE [dbo].[Carriers]  WITH CHECK ADD  CONSTRAINT [FK_Carriers_USDOT] FOREIGN KEY([USDOT])
REFERENCES [dbo].[USDOT] ([id])
GO
ALTER TABLE [dbo].[Carriers] CHECK CONSTRAINT [FK_Carriers_USDOT]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_Address] FOREIGN KEY([Address])
REFERENCES [dbo].[Addresses] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_Address]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_ApproachesH] FOREIGN KEY([ApproachH])
REFERENCES [dbo].[Approaches_H] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_ApproachesH]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_Carrier] FOREIGN KEY([Entity])
REFERENCES [dbo].[Carriers] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_Carrier]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_SCTH] FOREIGN KEY([SCTH])
REFERENCES [dbo].[SCT_H] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_SCTH]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_Statuses]
GO
ALTER TABLE [dbo].[Carriers_H]  WITH CHECK ADD  CONSTRAINT [FK_CarrierH_USDOTH] FOREIGN KEY([USDOTH])
REFERENCES [dbo].[USDOT_H] ([id])
GO
ALTER TABLE [dbo].[Carriers_H] CHECK CONSTRAINT [FK_CarrierH_USDOTH]
GO
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_DriversCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Drivers_Commons] ([id])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_DriversCommons]
GO
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_Employees] FOREIGN KEY([Employee])
REFERENCES [dbo].[Employees] ([id])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_Employees]
GO
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_Statuses]
GO
ALTER TABLE [dbo].[Drivers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_DriversCommons_Situations] FOREIGN KEY([Situation])
REFERENCES [dbo].[Situations] ([id])
GO
ALTER TABLE [dbo].[Drivers_Commons] CHECK CONSTRAINT [FK_DriversCommons_Situations]
GO
ALTER TABLE [dbo].[Drivers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_DriversCommons_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Drivers_Commons] CHECK CONSTRAINT [FK_DriversCommons_Statuses]
GO
ALTER TABLE [dbo].[Drivers_Externals]  WITH CHECK ADD  CONSTRAINT [FK_DriversExternal_Identifications] FOREIGN KEY([Identification])
REFERENCES [dbo].[Identifications] ([id])
GO
ALTER TABLE [dbo].[Drivers_Externals] CHECK CONSTRAINT [FK_DriversExternal_Identifications]
GO
ALTER TABLE [dbo].[Drivers_Externals]  WITH CHECK ADD  CONSTRAINT [FK_DriversExternals_DriversCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Drivers_Commons] ([id])
GO
ALTER TABLE [dbo].[Drivers_Externals] CHECK CONSTRAINT [FK_DriversExternals_DriversCommons]
GO
ALTER TABLE [dbo].[Drivers_Externals]  WITH CHECK ADD  CONSTRAINT [FK_DriversExternals_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Drivers_Externals] CHECK CONSTRAINT [FK_DriversExternals_Statuses]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Addresses] FOREIGN KEY([Address])
REFERENCES [dbo].[Addresses] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Addresses]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Approaches] FOREIGN KEY([Approach])
REFERENCES [dbo].[Approaches] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Approaches]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Identifications] FOREIGN KEY([Identification])
REFERENCES [dbo].[Identifications] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Identifications]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Statuses]
GO
ALTER TABLE [dbo].[Identifications]  WITH CHECK ADD  CONSTRAINT [FK_Identifications_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Identifications] CHECK CONSTRAINT [FK_Identifications_Statuses]
GO
ALTER TABLE [dbo].[Insurances]  WITH CHECK ADD  CONSTRAINT [FK_Insurances_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Insurances] CHECK CONSTRAINT [FK_Insurances_Statuses]
GO
ALTER TABLE [dbo].[Insurances_H]  WITH CHECK ADD  CONSTRAINT [FK_InsurancesH_Insurances] FOREIGN KEY([Entity])
REFERENCES [dbo].[Insurances] ([id])
GO
ALTER TABLE [dbo].[Insurances_H] CHECK CONSTRAINT [FK_InsurancesH_Insurances]
GO
ALTER TABLE [dbo].[Insurances_H]  WITH CHECK ADD  CONSTRAINT [FK_InsurancesH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Insurances_H] CHECK CONSTRAINT [FK_InsurancesH_Statuses]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_Addresses] FOREIGN KEY([Address])
REFERENCES [dbo].[Addresses] ([id])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_Addresses]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_Statuses]
GO
ALTER TABLE [dbo].[Maintenances]  WITH CHECK ADD  CONSTRAINT [FK_Maintenances_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Maintenances] CHECK CONSTRAINT [FK_Maintenances_Statuses]
GO
ALTER TABLE [dbo].[Maintenances_H]  WITH CHECK ADD  CONSTRAINT [FK_MaintenancesH_Maintenances] FOREIGN KEY([Entity])
REFERENCES [dbo].[Maintenances] ([id])
GO
ALTER TABLE [dbo].[Maintenances_H] CHECK CONSTRAINT [FK_MaintenancesH_Maintenances]
GO
ALTER TABLE [dbo].[Maintenances_H]  WITH CHECK ADD  CONSTRAINT [FK_MaintenancesH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Maintenances_H] CHECK CONSTRAINT [FK_MaintenancesH_Statuses]
GO
ALTER TABLE [dbo].[Plates]  WITH CHECK ADD  CONSTRAINT [FK_Plates_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Plates] CHECK CONSTRAINT [FK_Plates_Statuses]
GO
ALTER TABLE [dbo].[Plates]  WITH CHECK ADD  CONSTRAINT [FK_Plates_Trailers] FOREIGN KEY([Trailer])
REFERENCES [dbo].[Trailers] ([id])
GO
ALTER TABLE [dbo].[Plates] CHECK CONSTRAINT [FK_Plates_Trailers]
GO
ALTER TABLE [dbo].[Plates]  WITH CHECK ADD  CONSTRAINT [FK_Plates_Trucks] FOREIGN KEY([Truck])
REFERENCES [dbo].[Trucks] ([id])
GO
ALTER TABLE [dbo].[Plates] CHECK CONSTRAINT [FK_Plates_Trucks]
GO
ALTER TABLE [dbo].[Plates_H]  WITH CHECK ADD  CONSTRAINT [FK_PlatesH_Plates] FOREIGN KEY([Entity])
REFERENCES [dbo].[Plates] ([id])
GO
ALTER TABLE [dbo].[Plates_H] CHECK CONSTRAINT [FK_PlatesH_Plates]
GO
ALTER TABLE [dbo].[Plates_H]  WITH CHECK ADD  CONSTRAINT [FK_PlatesH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Plates_H] CHECK CONSTRAINT [FK_PlatesH_Statuses]
GO
ALTER TABLE [dbo].[Plates_H]  WITH CHECK ADD  CONSTRAINT [FK_PlatesH_Trucks] FOREIGN KEY([Truck])
REFERENCES [dbo].[Trucks] ([id])
GO
ALTER TABLE [dbo].[Plates_H] CHECK CONSTRAINT [FK_PlatesH_Trucks]
GO
ALTER TABLE [dbo].[PlatesTrucksH]  WITH CHECK ADD  CONSTRAINT [FK_PlatesTrucksH_Plates] FOREIGN KEY([Plateid])
REFERENCES [dbo].[Plates_H] ([id])
GO
ALTER TABLE [dbo].[PlatesTrucksH] CHECK CONSTRAINT [FK_PlatesTrucksH_Plates]
GO
ALTER TABLE [dbo].[PlatesTrucksH]  WITH CHECK ADD  CONSTRAINT [FK_PlatesTrucksH_TrucksH] FOREIGN KEY([Truckhid])
REFERENCES [dbo].[Trucks_H] ([id])
GO
ALTER TABLE [dbo].[PlatesTrucksH] CHECK CONSTRAINT [FK_PlatesTrucksH_TrucksH]
GO
ALTER TABLE [dbo].[SCT]  WITH CHECK ADD  CONSTRAINT [FK_SCT_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[SCT] CHECK CONSTRAINT [FK_SCT_Statuses]
GO
ALTER TABLE [dbo].[SCT_H]  WITH CHECK ADD  CONSTRAINT [FK_SCTH_SCT] FOREIGN KEY([Entity])
REFERENCES [dbo].[SCT] ([id])
GO
ALTER TABLE [dbo].[SCT_H] CHECK CONSTRAINT [FK_SCTH_SCT]
GO
ALTER TABLE [dbo].[SCT_H]  WITH CHECK ADD  CONSTRAINT [FK_SCTH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[SCT_H] CHECK CONSTRAINT [FK_SCTH_Statuses]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Locations] FOREIGN KEY([Yard])
REFERENCES [dbo].[Locations] ([id])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Locations]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Statuses]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_Carriers] FOREIGN KEY([Carrier])
REFERENCES [dbo].[Carriers] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_Carriers]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_Maintenances] FOREIGN KEY([Maintenance])
REFERENCES [dbo].[Maintenances] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_Maintenances]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_SCT] FOREIGN KEY([SCT])
REFERENCES [dbo].[SCT] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_SCT]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_Statuses]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_TrailersCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Trailers_Commons] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_TrailersCommons]
GO
ALTER TABLE [dbo].[Trailers]  WITH CHECK ADD  CONSTRAINT [FK_Trailers_VehiculesModels] FOREIGN KEY([Model])
REFERENCES [dbo].[Vehicules_Models] ([id])
GO
ALTER TABLE [dbo].[Trailers] CHECK CONSTRAINT [FK_Trailers_VehiculesModels]
GO
ALTER TABLE [dbo].[Trailers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrailerCommons_TrailersTypes] FOREIGN KEY([Type])
REFERENCES [dbo].[Trailers_Types] ([id])
GO
ALTER TABLE [dbo].[Trailers_Commons] CHECK CONSTRAINT [FK_TrailerCommons_TrailersTypes]
GO
ALTER TABLE [dbo].[Trailers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrailersCommons_Locations] FOREIGN KEY([Location])
REFERENCES [dbo].[Locations] ([id])
GO
ALTER TABLE [dbo].[Trailers_Commons] CHECK CONSTRAINT [FK_TrailersCommons_Locations]
GO
ALTER TABLE [dbo].[Trailers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrailersCommons_Situations] FOREIGN KEY([Situation])
REFERENCES [dbo].[Situations] ([id])
GO
ALTER TABLE [dbo].[Trailers_Commons] CHECK CONSTRAINT [FK_TrailersCommons_Situations]
GO
ALTER TABLE [dbo].[Trailers_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrailersCommons_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trailers_Commons] CHECK CONSTRAINT [FK_TrailersCommons_Statuses]
GO
ALTER TABLE [dbo].[Trailers_Externals]  WITH CHECK ADD  CONSTRAINT [FK_TrailersExternals_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trailers_Externals] CHECK CONSTRAINT [FK_TrailersExternals_Statuses]
GO
ALTER TABLE [dbo].[Trailers_Externals]  WITH CHECK ADD  CONSTRAINT [FK_TrailersExternals_TrailersCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Trailers_Commons] ([id])
GO
ALTER TABLE [dbo].[Trailers_Externals] CHECK CONSTRAINT [FK_TrailersExternals_TrailersCommons]
GO
ALTER TABLE [dbo].[Trailers_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrailerInventory_Trucks] FOREIGN KEY([trailer])
REFERENCES [dbo].[Trailers] ([id])
GO
ALTER TABLE [dbo].[Trailers_Inventories] CHECK CONSTRAINT [FK_TrailerInventory_Trucks]
GO
ALTER TABLE [dbo].[Trailers_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrailerInventory_TrucksExternal] FOREIGN KEY([trailerExternal])
REFERENCES [dbo].[Trailers_Externals] ([id])
GO
ALTER TABLE [dbo].[Trailers_Inventories] CHECK CONSTRAINT [FK_TrailerInventory_TrucksExternal]
GO
ALTER TABLE [dbo].[Trailers_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrailersInventory_Sections] FOREIGN KEY([section])
REFERENCES [dbo].[Sections] ([id])
GO
ALTER TABLE [dbo].[Trailers_Inventories] CHECK CONSTRAINT [FK_TrailersInventory_Sections]
GO
ALTER TABLE [dbo].[Trailers_Types]  WITH CHECK ADD  CONSTRAINT [FK_TrailersTypes_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trailers_Types] CHECK CONSTRAINT [FK_TrailersTypes_Statuses]
GO
ALTER TABLE [dbo].[Trailers_Types]  WITH CHECK ADD  CONSTRAINT [FK_TrailersTypes_TrailerClasses] FOREIGN KEY([TrailerClass])
REFERENCES [dbo].[Trailer_Classes] ([id])
GO
ALTER TABLE [dbo].[Trailers_Types] CHECK CONSTRAINT [FK_TrailersTypes_TrailerClasses]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_Carriers] FOREIGN KEY([Carrier])
REFERENCES [dbo].[Carriers] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_Carriers]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_Insurances] FOREIGN KEY([Insurance])
REFERENCES [dbo].[Insurances] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_Insurances]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_Maintenances] FOREIGN KEY([Maintenance])
REFERENCES [dbo].[Maintenances] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_Maintenances]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_SCT] FOREIGN KEY([SCT])
REFERENCES [dbo].[SCT] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_SCT]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_Statuses]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_TrucksCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Trucks_Commons] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_TrucksCommons]
GO
ALTER TABLE [dbo].[Trucks]  WITH CHECK ADD  CONSTRAINT [FK_Trucks_VehiculesModels] FOREIGN KEY([Model])
REFERENCES [dbo].[Vehicules_Models] ([id])
GO
ALTER TABLE [dbo].[Trucks] CHECK CONSTRAINT [FK_Trucks_VehiculesModels]
GO
ALTER TABLE [dbo].[Trucks_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrucksCommons_Locations] FOREIGN KEY([Location])
REFERENCES [dbo].[Locations] ([id])
GO
ALTER TABLE [dbo].[Trucks_Commons] CHECK CONSTRAINT [FK_TrucksCommons_Locations]
GO
ALTER TABLE [dbo].[Trucks_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrucksCommons_Situations] FOREIGN KEY([Situation])
REFERENCES [dbo].[Situations] ([id])
GO
ALTER TABLE [dbo].[Trucks_Commons] CHECK CONSTRAINT [FK_TrucksCommons_Situations]
GO
ALTER TABLE [dbo].[Trucks_Commons]  WITH CHECK ADD  CONSTRAINT [FK_TrucksCommons_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trucks_Commons] CHECK CONSTRAINT [FK_TrucksCommons_Statuses]
GO
ALTER TABLE [dbo].[Trucks_Externals]  WITH CHECK ADD  CONSTRAINT [FK_TrucksExternals_TrucksCommons] FOREIGN KEY([Common])
REFERENCES [dbo].[Trucks_Commons] ([id])
GO
ALTER TABLE [dbo].[Trucks_Externals] CHECK CONSTRAINT [FK_TrucksExternals_TrucksCommons]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TruckH_Trucks] FOREIGN KEY([Entity])
REFERENCES [dbo].[Trucks] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TruckH_Trucks]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_CarriersH] FOREIGN KEY([CarrierH])
REFERENCES [dbo].[Carriers_H] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_CarriersH]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_InsurancesH] FOREIGN KEY([InsuranceH])
REFERENCES [dbo].[Insurances_H] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_InsurancesH]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_MaintenancesH] FOREIGN KEY([MaintenanceH])
REFERENCES [dbo].[Maintenances_H] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_MaintenancesH]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_Manufacturers] FOREIGN KEY([Manufacturer])
REFERENCES [dbo].[Manufacturers] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_Manufacturers]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_Situations] FOREIGN KEY([Situation])
REFERENCES [dbo].[Situations] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_Situations]
GO
ALTER TABLE [dbo].[Trucks_H]  WITH CHECK ADD  CONSTRAINT [FK_TrucksH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Trucks_H] CHECK CONSTRAINT [FK_TrucksH_Statuses]
GO
ALTER TABLE [dbo].[Trucks_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrucksInventory_Sections] FOREIGN KEY([section])
REFERENCES [dbo].[Sections] ([id])
GO
ALTER TABLE [dbo].[Trucks_Inventories] CHECK CONSTRAINT [FK_TrucksInventory_Sections]
GO
ALTER TABLE [dbo].[Trucks_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrucksInventory_Trucks] FOREIGN KEY([truck])
REFERENCES [dbo].[Trucks] ([id])
GO
ALTER TABLE [dbo].[Trucks_Inventories] CHECK CONSTRAINT [FK_TrucksInventory_Trucks]
GO
ALTER TABLE [dbo].[Trucks_Inventories]  WITH CHECK ADD  CONSTRAINT [FK_TrucksInventory_TrucksExternal] FOREIGN KEY([truckExternal])
REFERENCES [dbo].[Trucks_Externals] ([id])
GO
ALTER TABLE [dbo].[Trucks_Inventories] CHECK CONSTRAINT [FK_TrucksInventory_TrucksExternal]
GO
ALTER TABLE [dbo].[USDOT]  WITH CHECK ADD  CONSTRAINT [FK_USDOT_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[USDOT] CHECK CONSTRAINT [FK_USDOT_Statuses]
GO
ALTER TABLE [dbo].[USDOT_H]  WITH CHECK ADD  CONSTRAINT [FK_USDOTH_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[USDOT_H] CHECK CONSTRAINT [FK_USDOTH_Statuses]
GO
ALTER TABLE [dbo].[USDOT_H]  WITH CHECK ADD  CONSTRAINT [FK_USDOTH_USDOT] FOREIGN KEY([Entity])
REFERENCES [dbo].[USDOT] ([id])
GO
ALTER TABLE [dbo].[USDOT_H] CHECK CONSTRAINT [FK_USDOTH_USDOT]
GO
ALTER TABLE [dbo].[Vehicules_Models]  WITH CHECK ADD  CONSTRAINT [FK_VehiculesModels_Manufacturers] FOREIGN KEY([Manufacturer])
REFERENCES [dbo].[Manufacturers] ([id])
GO
ALTER TABLE [dbo].[Vehicules_Models] CHECK CONSTRAINT [FK_VehiculesModels_Manufacturers]
GO
ALTER TABLE [dbo].[Vehicules_Models]  WITH CHECK ADD  CONSTRAINT [FK_VehiculesModels_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Vehicules_Models] CHECK CONSTRAINT [FK_VehiculesModels_Statuses]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_Drivers] FOREIGN KEY([Driver])
REFERENCES [dbo].[Drivers] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_Drivers]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_DriversExternals] FOREIGN KEY([DriverExternal])
REFERENCES [dbo].[Drivers_Externals] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_DriversExternals]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_LoadType] FOREIGN KEY([LoadType])
REFERENCES [dbo].[Load_Types] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_LoadType]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_Sections] FOREIGN KEY([Section])
REFERENCES [dbo].[Sections] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_Sections]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_Trailer] FOREIGN KEY([Trailer])
REFERENCES [dbo].[Trailers] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_Trailer]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_TrailerExternals] FOREIGN KEY([TrailerExternal])
REFERENCES [dbo].[Trailers_Externals] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_TrailerExternals]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_Truck] FOREIGN KEY([Truck])
REFERENCES [dbo].[Trucks] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_Truck]
GO
ALTER TABLE [dbo].[Yard_Logs]  WITH CHECK ADD  CONSTRAINT [FK_YardLogs_TruckExternals] FOREIGN KEY([TruckExternal])
REFERENCES [dbo].[Trucks_Externals] ([id])
GO
ALTER TABLE [dbo].[Yard_Logs] CHECK CONSTRAINT [FK_YardLogs_TruckExternals]
GO
/****** Object:  StoredProcedure [dbo].[Set_Location]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Set_Location]
	@sectionID INT,
	--@truckID INT,
	@vehiculeID INT,
	@vehiculeTableName varchar(max),
	@commonTableName varchar(max)
AS BEGIN
	DECLARE @locationID INT;
	DECLARE @truckCommonID INT;
	SELECT @locationID = Yard From Sections where id = @sectionID;
	DECLARE @Query NVARCHAR(MAX);
    DECLARE @ConditionalQuery NVARCHAR(MAX);
    DECLARE @updateQuery NVARCHAR(MAX);
	DECLARE @commonID INT;
	
	 SET @Query = N'SELECT @commonID = common 
                   FROM ' + QUOTENAME(@vehiculeTableName) + ' 
                   WHERE id = @vehiculeID';

    EXEC sp_executesql @Query, 
                       N'@vehiculeID INT, @commonID INT OUTPUT', 
                       @vehiculeID = @vehiculeID, 
                       @commonID = @commonID OUTPUT;

	DECLARE @exist INT = 1;

	SET @ConditionalQuery = N'SELECT @exist = 1 FROM ' + @commonTableName + ' WHERE id = @commonID AND (
		([Location] <> @locationID)
		OR ([Location] IS NULL AND @locationID IS NOT NULL)
		OR ([Location] IS NOT NULL AND @locationID IS NULL)
	)';

	EXEC sp_executesql @ConditionalQuery, 
        N'@commonID INT, @locationID INT, @exist INT OUTPUT', 
        @commonID = @commonID, 
        @locationID = @locationID, 
        @exist = @exist OUTPUT;

IF (@exist IS NULL) SET @exist = 0;

	IF (@exist = 1)
	BEGIN
		IF (@sectionID = null)
		BEGIN 
		
			SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
				SET [Location] = NULL 
				WHERE id = @commonID';

            EXEC sp_executesql @updateQuery, 
				N'@commonID INT', 
				@commonID = @commonID;

		END 
		ELSE BEGIN
	
			SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
				SET [Location] = @locationID 
				WHERE id = @commonID';

            EXEC sp_executesql @updateQuery, 
				N'@commonID INT, @locationID INT', 
				@commonID = @commonID, 
				@locationID = @locationID;
			
		END
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[Set_SectionOcupancy]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Set_SectionOcupancy]
	@sectionID INT,
	@added Bit
	AS BEGIN
	-- Check id add or substract value;
	IF @added = 1
	BEGIN
		UPDATE Sections 
		SET Ocupancy = Ocupancy + 1 WHERE id = @sectionID;
	END
	ELSE BEGIN
		UPDATE Sections 
		SET Ocupancy = Ocupancy - 1 WHERE id = @sectionID;
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[Set_Situation]    Script Date: 03/11/2024 12:01:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Set_Situation]
	@vehiculeID INT,
	@vehiculeTableName varchar(max),
	@commonTableName varchar(max),
	@situationName varchar(max)
AS BEGIN
	DECLARE @situationID INT; 
	DECLARE @commonID INT;
	SELECT @situationID = id FROM Situations where [Name] = @SituationName;
	
	DECLARE @Query NVARCHAR(max);
	SET @Query = N'SELECT @commonID = common 
		FROM ' + QUOTENAME(@vehiculeTableName) + ' 
		WHERE id = @vehiculeID';

    EXEC sp_executesql @Query, 
		N'@vehiculeID INT, @commonID INT OUTPUT', 
		@vehiculeID = @vehiculeID, 
		@commonID = @commonID OUTPUT;

	
	DECLARE @updateQuery NVARCHAR(max);
	SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
		SET Situation = @situationID 
		WHERE id = @commonID';

    EXEC sp_executesql @updateQuery, 
		N'@situationID INT, @commonID INT', 
		@situationID = @situationID, 
		@commonID = @commonID;
END;
GO
