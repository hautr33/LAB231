USE [YellowMoonShop]
GO
ALTER TABLE [dbo].[tblUsers] DROP CONSTRAINT [FK_tblUsers_tblRoles]
GO
ALTER TABLE [dbo].[tblOrders] DROP CONSTRAINT [FK_tblOrders_tblUsers]
GO
ALTER TABLE [dbo].[tblOrderDetails] DROP CONSTRAINT [FK_tblOrderDetails_tblOrders]
GO
ALTER TABLE [dbo].[tblOrderDetails] DROP CONSTRAINT [FK_tblOrderDetails_tblCakes]
GO
ALTER TABLE [dbo].[tblCakes] DROP CONSTRAINT [FK_tblCakes_tblUsers]
GO
ALTER TABLE [dbo].[tblCakes] DROP CONSTRAINT [FK_tblCakes_tblCategories]
GO
ALTER TABLE [dbo].[tblUsers] DROP CONSTRAINT [DF_tblUsers_userID]
GO
ALTER TABLE [dbo].[tblOrders] DROP CONSTRAINT [DF_tblOrders_orderID]
GO
ALTER TABLE [dbo].[tblOrderDetails] DROP CONSTRAINT [DF_tblOrderDetails_id]
GO
ALTER TABLE [dbo].[tblCakes] DROP CONSTRAINT [DF__tblCakes__cakeID__37A5467C]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND type in (N'U'))
DROP TABLE [dbo].[tblUsers]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblRoles]') AND type in (N'U'))
DROP TABLE [dbo].[tblRoles]
GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblOrders]') AND type in (N'U'))
DROP TABLE [dbo].[tblOrders]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblOrderDetails]') AND type in (N'U'))
DROP TABLE [dbo].[tblOrderDetails]
GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCategories]') AND type in (N'U'))
DROP TABLE [dbo].[tblCategories]
GO
/****** Object:  Table [dbo].[tblCakes]    Script Date: 12/07/2020 01:31:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCakes]') AND type in (N'U'))
DROP TABLE [dbo].[tblCakes]
GO
USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 12/07/2020 01:31:56 ******/
DROP DATABASE [YellowMoonShop]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 12/07/2020 01:31:56 ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY FULL 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'YellowMoonShop', N'ON'
GO
ALTER DATABASE [YellowMoonShop] SET QUERY_STORE = OFF
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[tblCakes]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCakes](
	[cakeID] [uniqueidentifier] NOT NULL,
	[cakeName] [varchar](50) NULL,
	[description] [varchar](500) NULL,
	[imageURL] [varchar](200) NULL,
	[price] [float] NULL,
	[categoryID] [varchar](10) NULL,
	[quantity] [int] NULL,
	[createDate] [date] NULL,
	[expirationDate] [date] NULL,
	[status] [varchar](10) NULL,
	[lastUpdateDate] [datetime] NULL,
	[lastUpdateUser] [uniqueidentifier] NULL,
 CONSTRAINT [PK__tblCakes__D0BF606BF7EC4BEE] PRIMARY KEY CLUSTERED 
(
	[cakeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategories](
	[categoryID] [varchar](10) NOT NULL,
	[categoryName] [varchar](20) NULL,
	[description] [varchar](50) NULL,
 CONSTRAINT [PK_tblCategories] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetails](
	[id] [uniqueidentifier] NOT NULL,
	[orderID] [uniqueidentifier] NULL,
	[cakeID] [uniqueidentifier] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
	[total] [float] NULL,
 CONSTRAINT [PK_tblOrderDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrders](
	[orderID] [uniqueidentifier] NOT NULL,
	[userID] [uniqueidentifier] NULL,
	[name] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[phone] [nchar](10) NULL,
	[note] [varchar](50) NULL,
	[orderDate] [datetime] NULL,
	[arrivalDate] [datetime] NULL,
	[payment] [varchar](10) NULL,
	[totalAmount] [float] NULL,
	[status] [varchar](10) NULL,
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [varchar](10) NOT NULL,
	[roleName] [varchar](50) NOT NULL,
	[description] [varchar](50) NULL,
 CONSTRAINT [PK_tblRoles] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 12/07/2020 01:31:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[userID] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [varchar](50) NULL,
	[facebookID] [varchar](50) NULL,
	[name] [nvarchar](50) NOT NULL,
	[phone] [varchar](10) NULL,
	[address] [nvarchar](100) NULL,
	[roleID] [varchar](10) NOT NULL,
	[status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'8578370f-d30f-eb11-bf02-88d7f68ec75d', N'Matcha Mooncake', N'Matcha (Japanese Green Tea)', N'images/cakes/20201018_163420.177.jpg', 2.9, N'GTC', 10, CAST(N'2020-10-17' AS Date), CAST(N'2020-11-01' AS Date), N'Expired', CAST(N'2020-10-18T21:52:23.430' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'610de2df-2811-eb11-bf03-88d7f68ec75d', N'Lotus Seed Paste Mooncake', N'Mooncake filled with lotus seed paste', N'images/cakes/20201018_170122.459.jpg', 2.49, N'LSC', 5, CAST(N'2020-10-01' AS Date), CAST(N'2020-11-12' AS Date), N'Active', CAST(N'2020-10-18T23:28:26.963' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'580c99fb-2811-eb11-bf03-88d7f68ec75d', N'Green Beans Mooncake', N'Mooncake filled with green bean', N'images/cakes/20201018_170652.792.jpg', 2, N'BC', 5, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-23' AS Date), N'Expired', CAST(N'2020-10-18T21:51:57.370' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'8c5c621c-2a11-eb11-bf03-88d7f68ec75d', N'Lava Salted Egg Yolk Mooncake', N'Lava salted egg', N'images/cakes/20201018_171013.452.jpg', 3.4, N'SEYC', 30, CAST(N'2020-10-15' AS Date), CAST(N'2020-11-01' AS Date), N'Expired', CAST(N'2020-10-18T21:52:17.763' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'9dba53f4-2a11-eb11-bf03-88d7f68ec75d', N'Salted Egg Yolk Mooncake', N'Salted Egg Yolk Mooncake', N'images/cakes/20201018_171616.008.jpg', 2.9, N'SEYC', 14, CAST(N'2020-10-15' AS Date), CAST(N'2020-10-31' AS Date), N'Expired', CAST(N'2020-10-18T21:52:10.513' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'90942f30-5f11-eb11-bf06-88d7f68ec75d', N'Salt Egg', N'asd', N'images/cakes/20201018_233010.276.jpg', 3, N'BC', 0, CAST(N'2020-10-01' AS Date), CAST(N'2020-10-31' AS Date), N'Expired', CAST(N'2020-10-18T23:31:03.987' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'b0cf8b41-1718-eb11-bf0a-88d7f68ec75d', N'Banh Trung Thu', N'Banh Trung Thu Thap Cam', N'images/cakes/20201027_124253.456.jpg', 100, N'MC', 20, CAST(N'2020-10-13' AS Date), CAST(N'2020-11-28' AS Date), N'Active', CAST(N'2020-10-27T12:42:53.457' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
INSERT [dbo].[tblCakes] ([cakeID], [cakeName], [description], [imageURL], [price], [categoryID], [quantity], [createDate], [expirationDate], [status], [lastUpdateDate], [lastUpdateUser]) VALUES (N'07dacdb0-2d0d-eb11-bf01-ae92f6b3ffc4', N'Mixed Nut Mooncake', N'Mooncake filled with five seeds', N'images/cakes/20201018_170720.034.jpg', 1.99, N'MC', 21, CAST(N'2020-09-28' AS Date), CAST(N'2020-11-08' AS Date), N'Active', CAST(N'2020-10-18T21:52:26.927' AS DateTime), N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d')
GO
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'BC', N'Bean', NULL)
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'GTC', N'Green Tea', NULL)
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'LSC', N'Lotus Seed', NULL)
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'MC', N'Mixed', NULL)
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'SEYC', N'Salted Egg Yolk', NULL)
INSERT [dbo].[tblCategories] ([categoryID], [categoryName], [description]) VALUES (N'SSC', N'Snow Skin', NULL)
GO
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'adf37d45-6211-eb11-bf03-88d7f68ec75d', N'acf37d45-6211-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'00f158ec-6211-eb11-bf03-88d7f68ec75d', N'fff058ec-6211-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'7d5a4fb9-6311-eb11-bf03-88d7f68ec75d', N'7c5a4fb9-6311-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'3b5be0e9-6311-eb11-bf03-88d7f68ec75d', N'3a5be0e9-6311-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'6343941e-6411-eb11-bf03-88d7f68ec75d', N'6243941e-6411-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'4a4e6f35-6411-eb11-bf03-88d7f68ec75d', N'494e6f35-6411-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'e410d2b0-6411-eb11-bf03-88d7f68ec75d', N'e310d2b0-6411-eb11-bf03-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 2, 2, 4)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'b958da16-5d11-eb11-bf06-88d7f68ec75d', N'b858da16-5d11-eb11-bf06-88d7f68ec75d', N'580c99fb-2811-eb11-bf03-88d7f68ec75d', 1, 2, 2)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'87cef54f-5d11-eb11-bf06-88d7f68ec75d', N'86cef54f-5d11-eb11-bf06-88d7f68ec75d', N'9dba53f4-2a11-eb11-bf03-88d7f68ec75d', 1, 2.9, 2.9)
INSERT [dbo].[tblOrderDetails] ([id], [orderID], [cakeID], [quantity], [price], [total]) VALUES (N'91a8662a-1718-eb11-bf0a-88d7f68ec75d', N'90a8662a-1718-eb11-bf0a-88d7f68ec75d', N'90942f30-5f11-eb11-bf06-88d7f68ec75d', 5, 3, 15)
GO
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'acf37d45-6211-eb11-bf03-88d7f68ec75d', N'f9083c44-6111-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0231231231', N'', CAST(N'2020-10-18T23:52:14.000' AS DateTime), CAST(N'2020-10-25T23:52:14.537' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'fff058ec-6211-eb11-bf03-88d7f68ec75d', N'fef058ec-6211-eb11-bf03-88d7f68ec75d', N'asdasd', N'asdasd', N'0123212312', N'', CAST(N'2020-10-18T23:56:54.000' AS DateTime), CAST(N'2020-10-25T23:56:54.467' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'7c5a4fb9-6311-eb11-bf03-88d7f68ec75d', N'7b5a4fb9-6311-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0111111111', N'', CAST(N'2020-10-19T00:02:38.000' AS DateTime), CAST(N'2020-10-26T00:02:38.340' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'3a5be0e9-6311-eb11-bf03-88d7f68ec75d', N'10be3ae6-6111-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0123432123', N'', CAST(N'2020-10-19T00:03:59.000' AS DateTime), CAST(N'2020-10-26T00:03:59.820' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'6243941e-6411-eb11-bf03-88d7f68ec75d', N'10be3ae6-6111-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0123432123', N'', CAST(N'2020-10-19T00:05:28.000' AS DateTime), CAST(N'2020-10-26T00:05:28.240' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'494e6f35-6411-eb11-bf03-88d7f68ec75d', N'10be3ae6-6111-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0123432123', N'', CAST(N'2020-10-19T00:06:06.000' AS DateTime), CAST(N'2020-10-26T00:06:06.587' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'e310d2b0-6411-eb11-bf03-88d7f68ec75d', N'e395dacc-5011-eb11-bf03-88d7f68ec75d', N'Hậu Tr ', N'010/H, tổ 1, khu phố 6', N'0387698743', N'', CAST(N'2020-10-19T00:09:33.000' AS DateTime), CAST(N'2020-10-26T00:09:33.583' AS DateTime), N'COD', 4, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'b858da16-5d11-eb11-bf06-88d7f68ec75d', N'7b5a4fb9-6311-eb11-bf03-88d7f68ec75d', N'asd', N'asd', N'0111111111', N'', CAST(N'2020-10-18T23:15:08.000' AS DateTime), CAST(N'2020-10-25T23:15:08.803' AS DateTime), N'COD', 2, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'86cef54f-5d11-eb11-bf06-88d7f68ec75d', N'85cef54f-5d11-eb11-bf06-88d7f68ec75d', N'asd', N'asd', N'0121212121', N'', CAST(N'2020-10-18T23:16:44.000' AS DateTime), CAST(N'2020-10-25T23:16:44.613' AS DateTime), N'COD', 2.9, N'Shipping')
INSERT [dbo].[tblOrders] ([orderID], [userID], [name], [address], [phone], [note], [orderDate], [arrivalDate], [payment], [totalAmount], [status]) VALUES (N'90a8662a-1718-eb11-bf0a-88d7f68ec75d', N'e395dacc-5011-eb11-bf03-88d7f68ec75d', N'Hậu Tr ', N'010/H, tổ 1, khu phố 6', N'0387698743', N'', CAST(N'2020-10-27T12:42:14.000' AS DateTime), CAST(N'2020-11-03T12:42:14.940' AS DateTime), N'COD', 15, N'Shipping')
GO
INSERT [dbo].[tblRoles] ([roleID], [roleName], [description]) VALUES (N'AD', N'Admin', NULL)
INSERT [dbo].[tblRoles] ([roleID], [roleName], [description]) VALUES (N'MB', N'Member', NULL)
GO
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'30ec6e97-4f11-eb11-bf03-88d7f68ec75d', N'admin', N'admin', NULL, N'Admin Hau', NULL, NULL, N'AD', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'5056c4a9-4f11-eb11-bf03-88d7f68ec75d', N'admin1', N'admin', NULL, N'Admin', NULL, NULL, N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'e395dacc-5011-eb11-bf03-88d7f68ec75d', NULL, NULL, N'1100465133732756', N'Hậu Tr ', N'0387698743', N'010/H, tổ 1, khu phố 6', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'f9083c44-6111-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0231231231', N'asd', N'MB', N'Inactive')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'10be3ae6-6111-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0123432123', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'09c05c2b-6211-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'1231231231', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'abf37d45-6211-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'1231231231', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'fef058ec-6211-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asdasd', N'0123212312', N'asdasd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'7b5a4fb9-6311-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0111111111', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'86dd5c09-9612-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asdads', N'0231231231', N'asdasd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'b8b69819-c913-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'a', N'0111111111', N'a', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'c5da3852-cb13-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'Hau Dep Trai', N'0123456789', N'ahihi', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'e7b8dac0-cb13-eb11-bf03-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0123456789', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'8fee9d0c-5d11-eb11-bf06-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0111111111', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'b758da16-5d11-eb11-bf06-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0111111111', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'073e0b2d-5d11-eb11-bf06-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0111111111', N'asd', N'MB', N'Active')
INSERT [dbo].[tblUsers] ([userID], [username], [password], [facebookID], [name], [phone], [address], [roleID], [status]) VALUES (N'85cef54f-5d11-eb11-bf06-88d7f68ec75d', NULL, NULL, NULL, N'asd', N'0121212121', N'asd', N'MB', N'Active')
GO
ALTER TABLE [dbo].[tblCakes] ADD  CONSTRAINT [DF__tblCakes__cakeID__37A5467C]  DEFAULT (newsequentialid()) FOR [cakeID]
GO
ALTER TABLE [dbo].[tblOrderDetails] ADD  CONSTRAINT [DF_tblOrderDetails_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[tblOrders] ADD  CONSTRAINT [DF_tblOrders_orderID]  DEFAULT (newsequentialid()) FOR [orderID]
GO
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [DF_tblUsers_userID]  DEFAULT (newsequentialid()) FOR [userID]
GO
ALTER TABLE [dbo].[tblCakes]  WITH CHECK ADD  CONSTRAINT [FK_tblCakes_tblCategories] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategories] ([categoryID])
GO
ALTER TABLE [dbo].[tblCakes] CHECK CONSTRAINT [FK_tblCakes_tblCategories]
GO
ALTER TABLE [dbo].[tblCakes]  WITH CHECK ADD  CONSTRAINT [FK_tblCakes_tblUsers] FOREIGN KEY([lastUpdateUser])
REFERENCES [dbo].[tblUsers] ([userID])
GO
ALTER TABLE [dbo].[tblCakes] CHECK CONSTRAINT [FK_tblCakes_tblUsers]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetails_tblCakes] FOREIGN KEY([cakeID])
REFERENCES [dbo].[tblCakes] ([cakeID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_tblOrderDetails_tblCakes]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetails_tblOrders] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrders] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_tblOrderDetails_tblOrders]
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD  CONSTRAINT [FK_tblOrders_tblUsers] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUsers] ([userID])
GO
ALTER TABLE [dbo].[tblOrders] CHECK CONSTRAINT [FK_tblOrders_tblUsers]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblRoles] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRoles] ([roleID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblRoles]
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
