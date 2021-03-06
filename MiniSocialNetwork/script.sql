USE [MiniSocialNetwork]
GO
ALTER TABLE [dbo].[tblUsers] DROP CONSTRAINT [FK_tblUsers_tblRoles]
GO
ALTER TABLE [dbo].[tblEmotions] DROP CONSTRAINT [FK_tblEmotions_tblUsers]
GO
ALTER TABLE [dbo].[tblEmotions] DROP CONSTRAINT [FK_tblEmotions_tblArticles]
GO
ALTER TABLE [dbo].[tblArticles] DROP CONSTRAINT [FK_tblArticles_tblUsers]
GO
ALTER TABLE [dbo].[tblArticles] DROP CONSTRAINT [DF_tblArticles_numDislike]
GO
ALTER TABLE [dbo].[tblArticles] DROP CONSTRAINT [DF_tblArticles_numLike]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 10/01/2020 05:39:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND type in (N'U'))
DROP TABLE [dbo].[tblUsers]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 10/01/2020 05:39:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblRoles]') AND type in (N'U'))
DROP TABLE [dbo].[tblRoles]
GO
/****** Object:  Table [dbo].[tblEmotions]    Script Date: 10/01/2020 05:39:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEmotions]') AND type in (N'U'))
DROP TABLE [dbo].[tblEmotions]
GO
/****** Object:  Table [dbo].[tblArticles]    Script Date: 10/01/2020 05:39:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblArticles]') AND type in (N'U'))
DROP TABLE [dbo].[tblArticles]
GO
USE [master]
GO
/****** Object:  Database [MiniSocialNetwork]    Script Date: 10/01/2020 05:39:42 ******/
DROP DATABASE [MiniSocialNetwork]
GO
/****** Object:  Database [MiniSocialNetwork]    Script Date: 10/01/2020 05:39:42 ******/
CREATE DATABASE [MiniSocialNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MiniSocialNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MiniSocialNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MiniSocialNetwork] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MiniSocialNetwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MiniSocialNetwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MiniSocialNetwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECOVERY FULL 
GO
ALTER DATABASE [MiniSocialNetwork] SET  MULTI_USER 
GO
ALTER DATABASE [MiniSocialNetwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MiniSocialNetwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MiniSocialNetwork] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MiniSocialNetwork] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MiniSocialNetwork', N'ON'
GO
ALTER DATABASE [MiniSocialNetwork] SET QUERY_STORE = OFF
GO
USE [MiniSocialNetwork]
GO
/****** Object:  Table [dbo].[tblArticles]    Script Date: 10/01/2020 05:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArticles](
	[articleID] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[image] [varchar](100) NOT NULL,
	[date] [datetime] NOT NULL,
	[status] [varchar](10) NOT NULL,
	[numLike] [int] NULL,
	[numDislike] [int] NULL,
 CONSTRAINT [PK_tblArticles] PRIMARY KEY CLUSTERED 
(
	[articleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEmotions]    Script Date: 10/01/2020 05:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmotions](
	[articleID] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblEmotions] PRIMARY KEY CLUSTERED 
(
	[articleID] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 10/01/2020 05:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [varchar](10) NOT NULL,
	[roleName] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tblRoles] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 10/01/2020 05:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[email] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [varchar](200) NOT NULL,
	[roleID] [varchar](10) NOT NULL,
	[status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tblAccount] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025428.549', N'2s2svenus2s2s@gmail.com', N'fdsa', N'asdasd', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025428.549.jpg', CAST(N'2020-10-01T02:54:28.550' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025430.853', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasd', N'', CAST(N'2020-10-01T02:54:30.853' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025433.361', N'2s2svenus2s2s@gmail.com', N'adasdqwe', N'qweqwe', N'', CAST(N'2020-10-01T02:54:33.360' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025435.834', N'2s2svenus2s2s@gmail.com', N'xcx', N'cxcxc', N'', CAST(N'2020-10-01T02:54:35.833' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025443.645', N'2s2svenus2s2s@gmail.com', N'xcxc', N'fdgdfg', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025443.645.jpg', CAST(N'2020-10-01T02:54:43.647' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025449.101', N'2s2svenus2s2s@gmail.com', N'dfgdfg', N'dfgdfgdfg', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025449.101.jpg', CAST(N'2020-10-01T02:54:49.100' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025452.554', N'2s2svenus2s2s@gmail.com', N'dfgdfg', N'dertertert', N'', CAST(N'2020-10-01T02:54:52.553' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025509.098', N'2s2svenus2s2s@gmail.com', N'asdasdqwe', N'qweretgxdf', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025509.098.jpg', CAST(N'2020-10-01T02:55:09.097' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025546.304', N'2s2svenus2s2s@gmail.com', N'Hello World!!', N'Ahihi
Ahihi', N'', CAST(N'2020-10-01T02:55:46.303' AS DateTime), N'Active', 0, 1)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025628.669', N'2s2svenus2s2s@gmail.com', N'My name''s Hau', N'Hau', N'', CAST(N'2020-10-01T02:56:28.670' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025636.991', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasdas', N'', CAST(N'2020-10-01T02:56:36.990' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025638.654', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasd', N'', CAST(N'2020-10-01T02:56:38.653' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025640.473', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasd', N'', CAST(N'2020-10-01T02:56:40.473' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025642.306', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasd', N'', CAST(N'2020-10-01T02:56:42.307' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025648.049', N'2s2svenus2s2s@gmail.com', N'asdas', N'dasd', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025648.049.jpg', CAST(N'2020-10-01T02:56:48.050' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025652.321', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdas', N'images/articles/2s2svenus2s2s@gmail.com_20201001_025652.321.png', CAST(N'2020-10-01T02:56:52.320' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025654.593', N'2s2svenus2s2s@gmail.com', N'asdasd', N'asdasdasd', N'', CAST(N'2020-10-01T02:56:54.593' AS DateTime), N'Active', 1, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025656.404', N'2s2svenus2s2s@gmail.com', N'qweqwe', N'qweqwe', N'', CAST(N'2020-10-01T02:56:56.403' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025658.579', N'2s2svenus2s2s@gmail.com', N'qweqwe', N'qweqweqw', N'', CAST(N'2020-10-01T02:56:58.580' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025700.701', N'2s2svenus2s2s@gmail.com', N'werwer', N'werwerwer', N'', CAST(N'2020-10-01T02:57:00.700' AS DateTime), N'Active', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025702.692', N'2s2svenus2s2s@gmail.com', N'rwer', N'werwerwe', N'', CAST(N'2020-10-01T02:57:02.693' AS DateTime), N'Active', 2, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025736.541', N'2s2svenus2s2s@gmail.com', N'Hello world!', N'Xin chao!', N'', CAST(N'2020-10-01T02:57:36.540' AS DateTime), N'Active', 2, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_030259.964', N'hautr33@gmail.com', N'Tui la Heo', N'Tui la heo do nha', N'images/articles/hautr33@gmail.com_20201001_030259.964.png', CAST(N'2020-10-01T03:02:59.963' AS DateTime), N'Deleted', 1, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_030348.113', N'hautr33@gmail.com', N'Ahihi do ngoc', N'roi sao ne', N'images/articles/hautr33@gmail.com_20201001_030348.113.jpg', CAST(N'2020-10-01T03:03:48.113' AS DateTime), N'Active', 1, 2)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_031250.601', N'hautr33@gmail.com', N'asd', N'asd', N'', CAST(N'2020-10-01T03:12:50.600' AS DateTime), N'Deleted', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_034550.938', N'hautr33@gmail.com', N'asd', N'asd', N'images/articles/hautr33@gmail.com_20201001_034550.938.jfif', CAST(N'2020-10-01T03:45:50.937' AS DateTime), N'Active', 1, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_034553.85', N'hautr33@gmail.com', N'asd', N'asd', N'', CAST(N'2020-10-01T03:45:53.850' AS DateTime), N'Deleted', 1, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautr33@gmail.com_20201001_052253.826', N'hautr33@gmail.com', N'asd', N'asd', N'', CAST(N'2020-10-01T05:22:53.827' AS DateTime), N'Deleted', 0, 0)
INSERT [dbo].[tblArticles] ([articleID], [email], [title], [description], [image], [date], [status], [numLike], [numDislike]) VALUES (N'hautt3399@gmail.com_20201001_042916.375', N'hautt3399@gmail.com', N'asd', N'asd', N'', CAST(N'2020-10-01T04:29:16.377' AS DateTime), N'Active', 1, 0)
GO
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025546.304', N'hautr33@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025654.593', N'hautr33@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025702.692', N'2s2svenus2s2s@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025702.692', N'hautr33@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025736.541', N'2s2svenus2s2s@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'2s2svenus2s2s@gmail.com_20201001_025736.541', N'hautr33@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_030259.964', N'hautr33@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_030348.113', N'2s2svenus2s2s@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_030348.113', N'hautr33@gmail.com', N'Dislike')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_030348.113', N'hautt3399@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_034550.938', N'hautr33@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautr33@gmail.com_20201001_034553.85', N'hautt3399@gmail.com', N'Like')
INSERT [dbo].[tblEmotions] ([articleID], [email], [status]) VALUES (N'hautt3399@gmail.com_20201001_042916.375', N'hautr33@gmail.com', N'Like')
GO
INSERT [dbo].[tblRoles] ([roleID], [roleName]) VALUES (N'MB', N'Member')
GO
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'2s2svenus2s2s@gmail.com', N'Hau Dep Trai', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'MB', N'Verified')
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'asdas@asdasd.asd', N'asd', N'688787d8ff144c502c7f5cffaafe2cc588d86079f9de88304c26b0cb99ce91c6', N'MB', N'New')
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'asdasd@asd.asd', N'1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'MB', N'New')
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'asdasd@qweqw.asd', N'1', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'MB', N'New')
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'hautr33@gmail.com', N'Hau Tran', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'MB', N'Verified')
INSERT [dbo].[tblUsers] ([email], [name], [password], [roleID], [status]) VALUES (N'hautt3399@gmail.com', N'Hau', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'MB', N'Verified')
GO
ALTER TABLE [dbo].[tblArticles] ADD  CONSTRAINT [DF_tblArticles_numLike]  DEFAULT ((0)) FOR [numLike]
GO
ALTER TABLE [dbo].[tblArticles] ADD  CONSTRAINT [DF_tblArticles_numDislike]  DEFAULT ((0)) FOR [numDislike]
GO
ALTER TABLE [dbo].[tblArticles]  WITH CHECK ADD  CONSTRAINT [FK_tblArticles_tblUsers] FOREIGN KEY([email])
REFERENCES [dbo].[tblUsers] ([email])
GO
ALTER TABLE [dbo].[tblArticles] CHECK CONSTRAINT [FK_tblArticles_tblUsers]
GO
ALTER TABLE [dbo].[tblEmotions]  WITH CHECK ADD  CONSTRAINT [FK_tblEmotions_tblArticles] FOREIGN KEY([articleID])
REFERENCES [dbo].[tblArticles] ([articleID])
GO
ALTER TABLE [dbo].[tblEmotions] CHECK CONSTRAINT [FK_tblEmotions_tblArticles]
GO
ALTER TABLE [dbo].[tblEmotions]  WITH CHECK ADD  CONSTRAINT [FK_tblEmotions_tblUsers] FOREIGN KEY([email])
REFERENCES [dbo].[tblUsers] ([email])
GO
ALTER TABLE [dbo].[tblEmotions] CHECK CONSTRAINT [FK_tblEmotions_tblUsers]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblRoles] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRoles] ([roleID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblRoles]
GO
USE [master]
GO
ALTER DATABASE [MiniSocialNetwork] SET  READ_WRITE 
GO
