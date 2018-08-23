/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4223)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [EquipmentManageSystem]    Script Date: 8/21/2018 1:57:43 PM ******/
CREATE DATABASE [EquipmentManageSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EquipmentManageSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\EquipmentManageSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EquipmentManageSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\EquipmentManageSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EquipmentManageSystem] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EquipmentManageSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EquipmentManageSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET ANSI_NULLS ON 
GO
ALTER DATABASE [EquipmentManageSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EquipmentManageSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EquipmentManageSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EquipmentManageSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EquipmentManageSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EquipmentManageSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EquipmentManageSystem] SET  MULTI_USER 
GO
ALTER DATABASE [EquipmentManageSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EquipmentManageSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EquipmentManageSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EquipmentManageSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EquipmentManageSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EquipmentManageSystem] SET QUERY_STORE = OFF
GO
USE [EquipmentManageSystem]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [EquipmentManageSystem]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[Fullname] [nvarchar](250) NULL,
	[Phone] [varchar](20) NULL,
	[IsActive] [bit] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[RoleID] [int] NULL,
	[AvatarImage] [nvarchar](250) NULL,
 CONSTRAINT [PK__Account__3214EC071D6B67D7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountNotification]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NULL,
	[NotificationId] [int] NULL,
	[NotificationStatus] [bit] NULL,
 CONSTRAINT [PK_AccountNotification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Block]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LocationID] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[TotalFloor] [int] NULL,
	[TotalBasementFloor] [int] NULL,
 CONSTRAINT [PK_Block] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedById] [nchar](10) NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK__Departme__3214EC07656E7313] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[VendorID] [int] NULL,
	[Image] [nvarchar](250) NULL,
	[MadeIn] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[UnitID] [int] NULL,
	[CategoryID] [int] NULL,
	[MaintenanceDurationID] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK__Equipmen__3214EC0703B82630] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NULL,
	[SerialNumber] [nvarchar](50) NULL,
	[WarehouseID] [int] NULL,
	[WarrantyDuration] [int] NULL,
	[RuntimeDays] [int] NULL,
	[TileID] [int] NULL,
	[Price] [float] NULL,
	[ImportDate] [datetime] NULL,
	[LastMaintainDate] [datetime] NULL,
	[NextMaintainDate] [datetime] NULL,
	[StatusId] [int] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK__Equipmen__3214EC07D8BED705] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentItemHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentItemID] [int] NULL,
	[ByUserID] [int] NULL,
	[OldStatusID] [int] NULL,
	[NewStatusID] [int] NULL,
	[Date] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_EquipmentItemHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_EquipmentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Floor]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Floor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BlockID] [int] NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Floor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__Location__3214EC0780403FED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceDuration]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaintenanceDuration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Months] [int] NOT NULL,
 CONSTRAINT [PK_MaintenanceDuration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[Metadata] [nvarchar](max) NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [nvarchar](250) NULL,
	[Block] [nvarchar](50) NULL,
	[Floor] [nvarchar](50) NULL,
	[Tile] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Priority]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Priority](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[TagHexColor] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[LocationID] [int] NULL,
	[StartDate] [datetime] NULL,
	[FinishedDate] [datetime] NULL,
	[CreatedById] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTeams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[TeamID] [int] NULL,
	[JoinDate] [datetime] NULL,
	[OutDate] [datetime] NULL,
 CONSTRAINT [PK_ProjectTeams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK__Role__3214EC073B5B43B8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamID] [int] NULL,
	[AccountID] [int] NULL,
	[TeamRoleID] [int] NULL,
 CONSTRAINT [PK_TeamAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[TeamID] [int] NULL,
	[StartDate] [datetime] NULL,
	[OutDate] [datetime] NULL,
 CONSTRAINT [PK_TeamLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamRole] [nvarchar](50) NULL,
 CONSTRAINT [PK_TeamRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tile]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[FloorID] [int] NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Tile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessName] [nvarchar](250) NULL,
	[BusinessAddress] [nvarchar](250) NULL,
	[Website] [nvarchar](250) NULL,
	[ContactName] [nvarchar](250) NULL,
	[ContactEmail] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Status] [bit] NULL,
	[Phone] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorType]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[RequestUserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[ExpectingStartDate] [datetime] NULL,
	[ExpectingCloseDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
	[PriorityID] [int] NULL,
	[StatusID] [int] NULL,
	[CategoryID] [int] NULL,
	[TeamLocationID] [int] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK__WorkOrde__3214EC07627B479A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentItemID] [int] NULL,
	[WorkOrderID] [int] NULL,
	[ClosedDate] [datetime] NULL,
	[MaintainceCost] [float] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_WorkOrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetailReturn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderDetailID] [int] NOT NULL,
	[ByUserID] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[ReturnedStatusID] [int] NULL,
	[OldRuntimeDays] [int] NULL,
 CONSTRAINT [PK_WorkOrderDetailRecord_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderID] [int] NULL,
	[ModifiedByUserID] [int] NULL,
	[ModifiedByDateTime] [datetime] NULL,
	[OldStatusID] [int] NULL,
	[NewStatusID] [int] NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 8/21/2018 1:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (2, N'admin', N'123456', NULL, N'Huy  Hung', NULL, 1, CAST(N'2018-06-03T14:20:49.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', NULL, N'Tran Minh Hung', NULL, 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'TienNT', N'123456', NULL, N'Nguyen Thanh Tien', NULL, 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'KhanhPM', N'123456', NULL, N'Minh Khanh', NULL, 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'teamleader2', N'123456', N'teamleader2@gmail.com', N'Nguyen Minh Hai', N'0927234925', 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', NULL, N'Quoc Viet', NULL, 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'teamleader', N'123456', NULL, N'Bùi Quang Nhật Châu', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', N'nhatchau@gmail.com', N'Thanh Hau', N'0927234923', 0, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534476847/lake_motosu_and_mount_fuji-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'estaff', N'123456', N'nhatchau.bq249@gmail.com', N'Huy Hoang', N'0927234924', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534442948/mount_fuji_landscapes-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (11, N'DienDTL', N'123456', NULL, N'Lam Dien', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (12, N'ThanhNT', N'123456', NULL, N'Ngoc Thanh', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (13, N'HungNT', N'123456', NULL, N'Thanh Hung', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (14, N'NgocHT', N'123456', NULL, N'Tuan Ngoc', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'maintainer', N'123456', NULL, N'Nhat Huy', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (16, N'admin2', N'123456', NULL, N'bao chau', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (18, N'ChauBQN', N'123456', N'nhatchau.bq@gmail.com', N'Bui Quang Nhat Chau', N'0927234234', 1, CAST(N'2018-07-19T00:19:04.537' AS DateTime), NULL, 3, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[AccountNotification] ON 

INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (138, 5, 52, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (139, 10, 52, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (140, 16, 52, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (141, 3, 53, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (142, 3, 54, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (143, 5, 55, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (144, 10, 55, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (145, 16, 55, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (146, 5, 56, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (147, 10, 56, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (148, 16, 56, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (149, 3, 57, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (150, 5, 58, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (151, 3, 59, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (152, 10, 58, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (153, 16, 58, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (154, 5, 60, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (155, 10, 60, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (156, 16, 60, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (157, 6, 62, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (158, 3, 61, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (159, 6, 63, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (160, 5, 64, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (161, 3, 65, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (162, 10, 64, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (163, 16, 64, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (164, 6, 67, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (165, 3, 66, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (166, 6, 68, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (167, 3, 70, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (168, 5, 69, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (169, 10, 69, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (170, 16, 69, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (171, 3, 71, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (172, 6, 72, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (173, 6, 73, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (174, 5, 74, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (175, 10, 74, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (176, 16, 74, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (177, 3, 75, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (178, 3, 76, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (179, 6, 77, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (180, 6, 78, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (181, 3, 80, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (182, 5, 79, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (183, 10, 79, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (184, 16, 79, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (185, 8, 81, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (186, 3, 82, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (187, 8, 83, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (188, 5, 84, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (189, 10, 84, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (190, 16, 84, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (191, 3, 85, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (192, 3, 86, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (193, 8, 87, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (194, 8, 88, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (195, 5, 89, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (196, 10, 89, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (197, 16, 89, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (198, 3, 90, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (199, 3, 91, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (200, 8, 92, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (201, 8, 93, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (202, 3, 95, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (203, 5, 94, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (204, 10, 94, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (205, 16, 94, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (206, 5, 96, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (207, 10, 96, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (208, 16, 96, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (209, 3, 97, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (210, 3, 98, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (211, 5, 99, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (212, 10, 99, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (213, 16, 99, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (214, 8, 101, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (215, 3, 100, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (216, 5, 102, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (217, 10, 102, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (218, 16, 102, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (219, 3, 103, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (220, 5, 104, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (221, 3, 105, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (222, 10, 104, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (223, 16, 104, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (224, 3, 106, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (225, 5, 107, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (226, 10, 107, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (227, 16, 107, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (228, 5, 108, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (229, 3, 109, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (230, 10, 108, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (231, 16, 108, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (232, 8, 110, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (233, 8, 111, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (234, 8, 113, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (235, 3, 112, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (236, 8, 114, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (237, 8, 115, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (238, 3, 116, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (239, 5, 117, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (240, 10, 117, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (241, 16, 117, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (242, 8, 118, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (243, 3, 119, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (244, 8, 120, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (245, 8, 121, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (246, 3, 122, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (247, 5, 123, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (248, 10, 123, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (249, 16, 123, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (250, 8, 124, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (251, 3, 125, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (252, 8, 126, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (253, 8, 127, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (254, 5, 128, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (255, 3, 129, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (256, 10, 128, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (257, 16, 128, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (258, 6, 130, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (259, 3, 131, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (260, 6, 132, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (261, 6, 133, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (262, 5, 135, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (263, 10, 135, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (264, 16, 135, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (265, 3, 134, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (266, 5, 136, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (267, 3, 137, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (268, 10, 136, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (269, 16, 136, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (270, 3, 138, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (271, 5, 139, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (272, 10, 139, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (273, 16, 139, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (274, 3, 141, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (275, 5, 140, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (276, 10, 140, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (277, 16, 140, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (278, 6, 142, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (279, 3, 143, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (280, 6, 144, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (281, 6, 145, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (282, 3, 146, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (283, 6, 147, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (284, 6, 148, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (285, 6, 149, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (286, 5, 150, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (287, 10, 150, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (288, 16, 150, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (289, 3, 151, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (290, 6, 152, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (291, 3, 153, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (292, 6, 154, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (293, 6, 155, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (294, 5, 156, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (295, 10, 156, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (296, 16, 156, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (297, 3, 157, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (298, 6, 158, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (299, 3, 159, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (300, 6, 160, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (301, 6, 161, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (302, 5, 162, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (303, 10, 162, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (304, 16, 162, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (305, 3, 163, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (306, 8, 164, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (307, 3, 165, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (308, 8, 166, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (309, 8, 167, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (310, 5, 168, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (311, 10, 168, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (312, 16, 168, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (313, 3, 169, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (314, 5, 170, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (315, 3, 171, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (316, 10, 170, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (317, 16, 170, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (318, 6, 172, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (319, 3, 173, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (320, 6, 174, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (321, 6, 175, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (322, 3, 176, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (323, 6, 177, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (324, 5, 178, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (325, 10, 178, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (326, 16, 178, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (327, 3, 179, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (328, 3, 180, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (329, 8, 181, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (330, 8, 182, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (331, 5, 183, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (332, 10, 183, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (333, 16, 183, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (334, 3, 184, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (335, 3, 185, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (336, 6, 186, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (337, 6, 187, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (338, 6, 188, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (339, 5, 189, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (340, 10, 189, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (341, 16, 189, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (342, 3, 190, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (343, 5, 191, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (344, 10, 191, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (345, 16, 191, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (346, 3, 192, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (347, 5, 193, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (348, 10, 193, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (349, 16, 193, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (350, 3, 194, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (351, 3, 195, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (352, 8, 196, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (353, 3, 197, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (354, 15, 198, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (355, 5, 199, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (356, 10, 199, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (357, 16, 199, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (358, 3, 200, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (359, 3, 201, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (360, 8, 202, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (361, 8, 203, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (362, 5, 204, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (363, 10, 204, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (364, 16, 204, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (365, 3, 205, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (366, 3, 206, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (367, 8, 207, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (368, 8, 208, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (369, 5, 209, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (370, 10, 209, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (371, 16, 209, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (372, 3, 210, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (373, 5, 211, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (374, 10, 211, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (375, 16, 211, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (376, 3, 212, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (377, 5, 213, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (378, 10, 213, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (379, 16, 213, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (380, 3, 214, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (381, 5, 215, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (382, 10, 215, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (383, 16, 215, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (384, 3, 216, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (385, 5, 217, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (386, 10, 217, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (387, 16, 217, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (388, 3, 218, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (389, 5, 219, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (390, 10, 219, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (391, 16, 219, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (392, 3, 220, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (393, 5, 221, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (394, 10, 221, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (395, 16, 221, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (396, 3, 222, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (397, 6, 223, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (398, 6, 224, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (399, 3, 225, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (400, 6, 226, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (401, 5, 227, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (402, 10, 227, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (403, 16, 227, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (404, 3, 228, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (405, 3, 229, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (406, 6, 230, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (407, 6, 231, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (408, 5, 232, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (409, 10, 232, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (410, 16, 232, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (411, 3, 233, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (412, 3, 234, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (413, 6, 235, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (414, 6, 236, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (415, 5, 237, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (416, 10, 237, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (417, 16, 237, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (418, 3, 238, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (419, 3, 239, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (420, 6, 240, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (421, 6, 241, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (422, 5, 242, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (423, 10, 242, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (424, 16, 242, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (425, 3, 243, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (426, 3, 244, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (427, 6, 245, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (428, 5, 246, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (429, 10, 246, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (430, 16, 246, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (431, 3, 247, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (432, 3, 248, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (433, 6, 249, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (434, 6, 250, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (435, 5, 251, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (436, 10, 251, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (437, 16, 251, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (438, 3, 252, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (439, 3, 253, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (440, 6, 254, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (441, 6, 255, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (442, 5, 256, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (443, 10, 256, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (444, 16, 256, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (445, 3, 257, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (446, 3, 258, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (447, 6, 259, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (448, 6, 260, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (449, 5, 261, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (450, 10, 261, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (451, 16, 261, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (452, 3, 262, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (453, 3, 263, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (454, 6, 264, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (455, 5, 265, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (456, 10, 265, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (457, 16, 265, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (458, 3, 266, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (459, 3, 267, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (460, 6, 268, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (461, 6, 269, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (462, 5, 270, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (463, 10, 270, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (464, 16, 270, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (465, 3, 271, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (466, 3, 272, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (467, 6, 273, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (468, 6, 274, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (469, 5, 275, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (470, 10, 275, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (471, 16, 275, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (472, 3, 276, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (473, 3, 277, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (474, 6, 278, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (475, 6, 279, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (476, 5, 280, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (477, 10, 280, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (478, 16, 280, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (479, 3, 281, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (480, 3, 282, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (481, 6, 283, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (482, 6, 284, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (483, 3, 285, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (484, 15, 286, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (485, 6, 287, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (486, 15, 288, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (487, 15, 289, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (488, 5, 290, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (489, 10, 290, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (490, 16, 290, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (491, 3, 291, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (492, 3, 292, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (493, 15, 293, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (494, 15, 294, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (495, 15, 295, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (496, 5, 296, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (497, 10, 296, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (498, 16, 296, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (499, 3, 297, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (500, 3, 298, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (501, 15, 299, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (502, 15, 300, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (503, 5, 301, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (504, 10, 301, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (505, 16, 301, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (506, 3, 302, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (507, 3, 303, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (508, 6, 304, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (509, 6, 305, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (510, 5, 306, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (511, 10, 306, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (512, 16, 306, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (513, 3, 307, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (514, 3, 308, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (515, 6, 309, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (516, 6, 310, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (517, 5, 311, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (518, 10, 311, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (519, 16, 311, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (520, 3, 312, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (521, 3, 313, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (522, 15, 314, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (523, 15, 315, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (524, 5, 316, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (525, 10, 316, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (526, 16, 316, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (527, 3, 317, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (528, 3, 318, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (529, 6, 319, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (530, 6, 320, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (531, 6, 321, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (532, 5, 322, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (533, 10, 322, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (534, 3, 323, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (535, 5, 324, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (536, 10, 324, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (537, 3, 325, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (538, 5, 326, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (539, 10, 326, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (540, 3, 327, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (541, 3, 328, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (542, 15, 329, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (543, 15, 330, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (544, 3, 331, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (545, 8, 332, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (546, 8, 333, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (547, 8, 334, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (548, 3, 335, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (549, 8, 336, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (550, 8, 337, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (551, 5, 338, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (552, 10, 338, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (553, 3, 339, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (554, 5, 340, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (555, 10, 340, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (556, 3, 341, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (557, 3, 342, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (558, 8, 343, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (559, 5, 344, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (560, 10, 344, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (561, 3, 345, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (562, 3, 346, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (563, 6, 347, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (564, 6, 348, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (565, 5, 349, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (566, 10, 349, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (567, 3, 350, 1)
SET IDENTITY_INSERT [dbo].[AccountNotification] OFF
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (1, N'Block A', 1, NULL, 1, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (2, N'Block B', 1, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (3, N'Block A1', 3, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (4, N'Block A2', 3, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (5, N'Block A3', 3, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (6, N'Block A', 2, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (33, N'1', 7, NULL, 2, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (34, N'Nha anh Chau', 9, NULL, 5, 1)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (35, N'Block A', 11, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Block] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (1, NULL, N'Marketing')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (2, NULL, N'IT')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (3, NULL, N'Thi công công trình')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (4, NULL, N'Administrator')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (5, NULL, N'Construction')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (6, NULL, N'Office')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', N'Japan', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', N'China', NULL, 1, 3, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/35553276_1397515960392211_9183626838994321408_n.jpg?_nc_cat=0&oh=ce5ff292839ea9d2409a8590d39ed08e&oe=5BB5BACF', N'Hàn Quốc', N'Update', 1, 2, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', N'Puma', NULL, 1, 4, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (5, N'Panasonic Laser Fax KX-FLB882', 2, N'http://www.mucinhanoi.vn/images/201204/goods_img/612_G_1334278634575.jpg', N'Japan', NULL, 1, 5, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (15, N'Búa hơi đục bê tông G10', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg', N'China', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (16, N'Máy đo khoảng cách laser Bosch GLM30 (30m)
', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/08/Bosch-GML30-400x400.jpg', N'Malaysia', NULL, 1, 10, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (19, N'Máy trộn bê tông cam 250L', 1, N'http://dienmaysaoviet.vn//app/webroot/upload/image/images/M%C3%A1y%20tr%E1%BB%99n%20b%C3%AA%20t%C3%B4ng%20250L.jpg', N'VietNam', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (1039, N'Máy duỗi sắt cắt sắt tự động GT4-10', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531271427/may_duoi_sat_gt2-5-400x400.jpg.jpg', N'China', N'', 1, 2, 3, 1)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentCategory] ON 

INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (1, N'Máy xây dựng', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (2, N'Máy cơ khí', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (3, N'Máy hàn', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (4, N'Máy nén khí', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (5, N'Máy bơm', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (6, N'Máy FAX', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (7, N'Crane', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (8, N'Excavator', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (9, N'Forklift', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (10, N'Dụng cụ đo', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (11, N'Dụng cụ điện', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (12, N'Máy bay', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (13, N'Văn phòng phẩm', NULL, 1)
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (1, 4, N'10101012', 1, 6, 12, 71, 2950000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (2, 4, N'10101013', 1, 6, 19, NULL, 2950000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 7, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (3, 4, N'10101014', 1, 6, 6, 72, 2950000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (7, 5, N'109021101', 1, 12, 18, 71, 8290000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 6, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (8, 5, N'109021109', 1, 12, 75, 72, 8290000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (9, 16, N'1110245222311', 1, 18, 0, 71, 1980000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 4, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (10, 16, N'1110242566178', 1, 18, 0, 71, 1980000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'3000-01-24T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (11, 15, N'2020154022532', 1, 6, 0, NULL, 1650000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), CAST(N'2019-01-24T16:14:44.183' AS DateTime), 7, N'Mới update')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (12, 15, N'2020154322210', 1, 6666, 6666, 71, 6666, CAST(N'2017-10-01T00:00:00.000' AS DateTime), CAST(N'2018-04-19T00:00:00.000' AS DateTime), CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, N'ahihi')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (16, 19, N'1134578122221', 1, 6, 36, 71, 2700000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (17, 19, N'1134578122652', 1, 6, 47, 71, 2700000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (18, 19, N'1134578122543', 1, 6, 78, 71, 2700000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (35, 15, N'0001661890628', 1, 24, 0, 71, 2450000, CAST(N'2018-06-16T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (36, 15, N'0001927576168', 1, 24, 0, NULL, 2450000, CAST(N'2017-01-20T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), CAST(N'2019-01-24T16:14:44.183' AS DateTime), 7, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (49, 2, N'0003955455318', 9, 1, 8, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (50, 2, N'0003451880969', 1, 1, 8, 71, 50000, CAST(N'2018-02-19T00:00:00.000' AS DateTime), NULL, CAST(N'2019-01-24T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (51, 2, N'0003851085400', 1, 1, 145, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), CAST(N'2018-08-04T15:14:32.000' AS DateTime), CAST(N'2019-02-04T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (52, 2, N'0003596282370', 9, 1, 140, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2018-09-02T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (53, 2, N'0003620918939', 1, 1, 5, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2018-09-02T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (54, 2, N'0003883962445', 9, 1, 4, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2018-10-10T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (55, 2, N'0003149026463', 1, 1, 88, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), CAST(N'2018-08-14T08:42:24.170' AS DateTime), CAST(N'2019-02-14T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (56, 4, N'0004314802245', 1, 1, 44, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2018-10-10T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (57, 4, N'0004472303781', 9, 1, 34, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (58, 4, N'0004818617048', 9, 1, 26, 71, 50000, CAST(N'2018-02-19T00:08:52.553' AS DateTime), NULL, CAST(N'2019-01-24T16:14:44.183' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (59, 1, N'0001568862689', 1, 1, 0, 71, 60000, CAST(N'2018-07-26T08:56:29.860' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (60, 1, N'0001874846183', 1, 1, 0, 71, 60000, CAST(N'2018-07-26T08:56:29.860' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (61, 1, N'0001356022890', 1, 999, 0, 71, 60000, CAST(N'2018-07-26T00:00:00.000' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (62, 1, N'0001618851241', 1, 1, 0, 71, 60000, CAST(N'2018-07-26T08:56:29.883' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (63, 1, N'0001906583628', 1, 1, 0, 71, 60000, CAST(N'2018-07-26T08:56:29.893' AS DateTime), NULL, NULL, 4, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (64, 1039, N'0021039206763', 1, 12, 0, 71, 1050000, CAST(N'2018-08-20T15:22:34.020' AS DateTime), CAST(N'2018-08-20T15:22:34.020' AS DateTime), NULL, 2, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (65, 1039, N'0021039798770', 1, 12, 0, 71, 1050000, CAST(N'2018-08-20T15:22:34.020' AS DateTime), CAST(N'2018-08-20T15:22:34.020' AS DateTime), NULL, 2, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (66, 1039, N'0021039716303', 1, 12, 0, 71, 1050000, CAST(N'2018-08-20T15:22:34.043' AS DateTime), CAST(N'2018-08-20T15:22:34.043' AS DateTime), NULL, 1, N'No description')
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItemHistory] ON 

INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (153, 50, 3, 1, 2, CAST(N'2018-07-23T12:17:49.810' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (154, 49, 3, 1, 2, CAST(N'2018-07-23T12:17:49.830' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (155, 50, 10, 2, 3, CAST(N'2018-07-23T12:18:04.310' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (156, 49, 10, 2, 3, CAST(N'2018-07-23T12:18:04.310' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (157, 50, 10, 3, 1, CAST(N'2018-07-23T12:42:24.727' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (158, 49, 10, 3, 1, CAST(N'2018-07-23T12:42:24.827' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (159, 7, 3, 1, 2, CAST(N'2018-07-23T13:09:45.803' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (160, 7, 10, 2, 3, CAST(N'2018-07-23T13:09:53.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (161, 7, 10, 3, 1, CAST(N'2018-07-23T13:28:01.607' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (162, 51, 3, 1, 2, CAST(N'2018-07-23T13:39:52.437' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (163, 50, 3, 1, 2, CAST(N'2018-07-23T13:39:52.437' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (164, 49, 3, 1, 2, CAST(N'2018-07-23T13:39:52.467' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (165, 49, 10, 2, 3, CAST(N'2018-07-23T13:39:59.030' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (166, 50, 10, 2, 3, CAST(N'2018-07-23T13:39:59.050' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (167, 51, 10, 2, 3, CAST(N'2018-07-23T13:39:59.083' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (168, 50, 10, 3, 1, CAST(N'2018-07-23T13:41:01.217' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (169, 51, 10, 3, 1, CAST(N'2018-07-23T13:41:01.227' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (170, 49, 10, 3, 1, CAST(N'2018-07-23T13:41:01.230' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (171, 49, 3, 1, 2, CAST(N'2018-07-24T13:44:46.813' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (172, 50, 3, 1, 2, CAST(N'2018-07-24T13:44:46.867' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (173, 50, 10, 2, 3, CAST(N'2018-07-24T13:45:03.910' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (174, 49, 10, 2, 3, CAST(N'2018-07-24T13:45:03.917' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (175, 49, 10, 3, 1, CAST(N'2018-07-24T13:45:29.790' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (176, 50, 10, 3, 1, CAST(N'2018-07-24T13:45:57.543' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (177, 49, 3, 1, 2, CAST(N'2018-07-24T14:43:05.773' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (178, 50, 3, 1, 2, CAST(N'2018-07-24T14:43:05.777' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (179, 49, 10, 2, 3, CAST(N'2018-07-24T14:43:23.020' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (180, 50, 10, 2, 3, CAST(N'2018-07-24T14:43:23.037' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (181, 50, 10, 3, 1, CAST(N'2018-07-28T14:44:27.110' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (182, 49, 10, 3, 1, CAST(N'2018-07-28T14:44:27.170' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (183, 8, 3, 1, 2, CAST(N'2018-07-29T01:15:13.723' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (184, 7, 3, 1, 2, CAST(N'2018-07-29T01:15:13.777' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (185, 7, 10, 2, 3, CAST(N'2018-07-29T01:15:19.933' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (186, 8, 10, 2, 3, CAST(N'2018-07-29T01:15:19.943' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (187, 7, 10, 3, 1, CAST(N'2018-07-29T01:16:57.217' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (188, 8, 10, 3, 1, CAST(N'2018-07-29T01:17:20.197' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (189, 3, 3, 1, 2, CAST(N'2018-07-29T01:27:25.667' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (190, 3, 10, 2, 3, CAST(N'2018-07-29T01:27:35.963' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (191, 3, 10, 3, 1, CAST(N'2018-07-29T01:28:22.030' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (192, 51, 3, 1, 2, CAST(N'2018-07-24T02:05:26.817' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (193, 52, 3, 1, 2, CAST(N'2018-07-24T02:05:26.830' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (194, 51, 10, 2, 3, CAST(N'2018-07-24T02:07:19.020' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (195, 52, 10, 2, 3, CAST(N'2018-07-24T02:07:19.027' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (196, 51, 10, 3, 1, CAST(N'2018-07-24T02:07:42.520' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (197, 52, 10, 3, 1, CAST(N'2018-07-24T02:07:42.533' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (198, 51, 3, 1, 2, CAST(N'2018-07-24T02:25:35.370' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (199, 52, 3, 1, 2, CAST(N'2018-07-24T02:25:35.420' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (200, 53, 3, 1, 2, CAST(N'2018-07-24T02:25:35.433' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (201, 52, 10, 2, 3, CAST(N'2018-07-24T02:25:51.540' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (202, 51, 10, 2, 3, CAST(N'2018-07-24T02:25:51.550' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (203, 53, 10, 2, 3, CAST(N'2018-07-24T02:25:51.567' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (204, 51, 10, 3, 1, CAST(N'2018-07-24T02:26:30.360' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (205, 52, 10, 3, 1, CAST(N'2018-07-24T02:26:47.140' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (206, 53, 10, 3, 1, CAST(N'2018-07-24T02:26:47.150' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (207, 52, 3, 1, 2, CAST(N'2018-07-24T03:11:56.313' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (208, 53, 3, 1, 2, CAST(N'2018-07-24T03:11:56.317' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (209, 51, 3, 1, 2, CAST(N'2018-07-24T03:11:56.330' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (210, 54, 3, 1, 2, CAST(N'2018-07-24T03:11:56.343' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (211, 52, 10, 2, 3, CAST(N'2018-07-24T03:12:26.767' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (212, 51, 10, 2, 3, CAST(N'2018-07-24T03:12:26.787' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (213, 54, 10, 2, 3, CAST(N'2018-07-24T03:12:26.847' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (214, 53, 10, 2, 3, CAST(N'2018-07-24T03:12:26.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (215, 53, 10, 3, 1, CAST(N'2018-07-24T03:15:43.157' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (216, 51, 10, 3, 1, CAST(N'2018-07-24T03:15:43.160' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (217, 54, 10, 3, 1, CAST(N'2018-07-24T03:15:43.173' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (218, 52, 10, 3, 1, CAST(N'2018-07-24T03:15:43.173' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (219, 3, 3, 1, 2, CAST(N'2018-07-25T11:42:16.393' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (220, 3, 10, 2, 3, CAST(N'2018-07-25T11:42:34.703' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (221, 53, 3, 1, 2, CAST(N'2018-07-26T08:46:21.050' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (222, 55, 3, 1, 2, CAST(N'2018-07-26T08:46:21.227' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (223, 16, 3, 1, 2, CAST(N'2018-07-26T08:46:21.297' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (224, 17, 3, 1, 2, CAST(N'2018-07-26T08:46:21.487' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (225, 18, 3, 1, 2, CAST(N'2018-07-26T08:46:21.540' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (226, 1, 3, 1, 2, CAST(N'2018-07-26T08:46:21.590' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (227, 2, 3, 1, 2, CAST(N'2018-07-26T08:46:21.640' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (228, 58, 3, 1, 2, CAST(N'2018-07-26T08:46:21.743' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (229, 7, 3, 1, 2, CAST(N'2018-07-26T08:46:21.783' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (230, 53, 10, 2, 3, CAST(N'2018-07-26T08:47:42.687' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (231, 55, 10, 2, 3, CAST(N'2018-07-26T08:47:42.737' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (232, 16, 10, 2, 3, CAST(N'2018-07-26T08:47:42.780' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (233, 17, 10, 2, 3, CAST(N'2018-07-26T08:47:42.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (234, 18, 10, 2, 3, CAST(N'2018-07-26T08:47:42.987' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (235, 1, 10, 2, 3, CAST(N'2018-07-26T08:47:43.020' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (236, 2, 10, 2, 3, CAST(N'2018-07-26T08:47:43.057' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (237, 58, 10, 2, 3, CAST(N'2018-07-26T08:47:43.100' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (238, 7, 10, 2, 3, CAST(N'2018-07-26T08:47:43.223' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (239, 53, 10, 3, 7, CAST(N'2018-07-26T14:58:06.587' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (240, 1, 10, 3, 1, CAST(N'2018-07-26T14:59:27.447' AS DateTime), N'ok')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (241, 53, 8, 7, 1, CAST(N'2018-07-26T15:11:29.227' AS DateTime), N'tim thay roi')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (242, 3, 10, 3, 1, CAST(N'2018-07-31T13:50:59.020' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (243, 49, 3, 1, 2, CAST(N'2018-08-02T15:33:47.500' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (244, 50, 3, 1, 2, CAST(N'2018-08-02T15:33:47.550' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (245, 51, 3, 1, 2, CAST(N'2018-08-02T15:33:47.593' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (246, 49, 10, 2, 3, CAST(N'2018-08-02T15:57:13.533' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (247, 50, 10, 2, 3, CAST(N'2018-08-02T15:57:13.573' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (248, 51, 10, 2, 3, CAST(N'2018-08-02T15:57:13.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (249, 11, 3, 1, 2, CAST(N'2018-08-03T11:47:06.833' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (250, 35, 3, 1, 2, CAST(N'2018-08-03T11:47:06.870' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (251, 36, 3, 1, 2, CAST(N'2018-08-03T11:47:06.987' AS DateTime), NULL)
GO
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (252, 11, 10, 2, 3, CAST(N'2018-08-03T12:07:00.893' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (253, 35, 10, 2, 3, CAST(N'2018-08-03T12:07:00.933' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (254, 36, 10, 2, 3, CAST(N'2018-08-03T12:07:01.050' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (255, 11, 10, 3, 7, CAST(N'2018-08-03T14:44:34.277' AS DateTime), N'bi trom')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (256, 35, 10, 3, 1, CAST(N'2018-08-03T14:44:34.420' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (257, 36, 10, 3, 7, CAST(N'2018-08-03T14:44:34.643' AS DateTime), N'bi trom')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (258, 51, 3, 3, 2, CAST(N'2018-08-03T14:51:31.747' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (259, 51, 10, 2, 3, CAST(N'2018-08-03T14:55:52.133' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (260, 2, 10, 3, 7, CAST(N'2018-08-04T12:18:45.720' AS DateTime), N'bi mat')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (261, 51, 10, 3, 1, CAST(N'2018-08-04T14:54:51.373' AS DateTime), N'thay mo han')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (262, 51, 3, 1, 5, CAST(N'2018-08-04T15:01:39.850' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (263, 51, 10, 5, 6, CAST(N'2018-08-04T15:01:44.167' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (264, 51, 10, 6, 1, CAST(N'2018-08-04T15:12:17.447' AS DateTime), N'Thay mo han')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (265, 51, 3, 1, 5, CAST(N'2018-08-04T15:14:12.003' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (266, 51, 10, 5, 6, CAST(N'2018-08-04T15:14:17.183' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (267, 51, 10, 6, 1, CAST(N'2018-08-04T15:14:31.943' AS DateTime), N'Thay mo han')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (268, 55, 10, 3, 1, CAST(N'2018-08-04T15:17:13.703' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (269, 58, 10, 3, 1, CAST(N'2018-08-04T15:17:13.977' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (270, 7, 10, 3, 1, CAST(N'2018-08-04T15:17:14.230' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (271, 16, 10, 3, 1, CAST(N'2018-08-04T15:17:14.480' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (272, 17, 10, 3, 1, CAST(N'2018-08-04T15:17:14.713' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (273, 18, 10, 3, 1, CAST(N'2018-08-04T15:17:14.960' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (274, 49, 10, 3, 1, CAST(N'2018-08-04T15:17:22.827' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (275, 50, 10, 3, 1, CAST(N'2018-08-04T15:17:22.960' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (276, 51, 10, 1, 1, CAST(N'2018-08-04T15:17:23.077' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (277, 55, 3, 1, 5, CAST(N'2018-08-08T16:16:58.100' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (278, 55, 10, 5, 6, CAST(N'2018-08-08T16:17:10.433' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (279, 54, 3, 1, 2, CAST(N'2018-08-09T12:40:16.247' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (280, 49, 3, 1, 2, CAST(N'2018-08-09T12:40:16.293' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (281, 54, 10, 2, 3, CAST(N'2018-08-09T12:40:31.173' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (282, 49, 10, 2, 3, CAST(N'2018-08-09T12:40:31.210' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (283, 54, 10, 3, 1, CAST(N'2018-08-09T12:41:18.990' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (284, 49, 10, 3, 1, CAST(N'2018-08-09T12:41:19.097' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (285, 55, 10, 6, 1, CAST(N'2018-08-14T08:42:24.123' AS DateTime), N'thay que han')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (286, 7, 3, 1, 5, CAST(N'2018-08-18T11:32:27.937' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (287, 7, 10, 5, 6, CAST(N'2018-08-18T11:32:33.413' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (288, 57, 3, 1, 2, CAST(N'2018-08-18T11:43:00.777' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (289, 57, 10, 2, 3, CAST(N'2018-08-18T11:43:03.930' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (290, 9, 10, 1, 4, CAST(N'2018-08-21T09:40:09.197' AS DateTime), N'hư bộ phát laze')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (291, 64, 3, 1, 2, CAST(N'2018-08-21T09:41:00.780' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (292, 65, 3, 1, 2, CAST(N'2018-08-21T09:41:00.830' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (293, 63, 10, 1, 4, CAST(N'2018-08-21T13:49:58.967' AS DateTime), N'alo alo')
SET IDENTITY_INSERT [dbo].[EquipmentItemHistory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentStatus] ON 

INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (1, N'Available')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (2, N'Working Approved')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (3, N'Working')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (4, N'Damaged')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (5, N'Maintainance Approved')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (6, N'Maintaining')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (7, N'Lost')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (8, N'Archived')
SET IDENTITY_INSERT [dbo].[EquipmentStatus] OFF
SET IDENTITY_INSERT [dbo].[Floor] ON 

INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (63, N'1', 33, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (64, N'G', 33, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (65, N'4', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (66, N'3', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (67, N'2', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (68, N'1', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (69, N'G', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (70, N'B1', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (71, N'G', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (72, N'G', 35, NULL)
SET IDENTITY_INSERT [dbo].[Floor] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (1, N'Kho ABC', N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (2, N'Đại học FPT', N'Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (3, N'4S Linh Đông Thủ Đức', N'20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (5, N'FPT Software', N'Lot T2, D1 Street, Saigon Hi-Tech Park, Dist 9, Phường Tân Phú, Quận 9, Hồ Chí Minh', N'Công trường', 106.79836, 10.850978, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (7, N'Cầu vượt Nguyễn Thái Sơn', N'Vòng xoay Phạm Văn Đồng - Hoàng Minh Giám, Q.Gò Vấp, TpHCM', N'Công trường', 106.678678, 10.813932, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (8, N'FPT University', N'Toà nhà Innovation, lô 24, Công viên phần mềm Quang Trung, Quận 12, Hồ Chí Minh, Vietnam', N'this is fpt university', 106.62954480000008, 10.8529391, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (9, N'Nha Chau', N'135 Yersin, Phú Cường, Thủ Dầu Một, Bình Dương, Vietnam', N'', 106.65972799999997, 10.9822488, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (11, N'Cầu Phú Cường', N'Cầu Phú Cường, Bình Mỹ, Củ Chi, Bình Dương, Vietnam', N'', 106.64339259999997, 10.9810635, 1)
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[MaintenanceDuration] ON 

INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (1, 3)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (2, 6)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (3, 9)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (4, 12)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (5, 24)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (6, 3)
SET IDENTITY_INSERT [dbo].[MaintenanceDuration] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (52, N'<strong>teamleader</strong> created a work order <strong>Muon Máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-22T15:41:58.550' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (53, N'<strong>teamleader</strong> created a work order <strong>Muon Máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-22T15:41:58.560' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (54, N'<strong>teamleader</strong> created a work order <strong>Muon máy nén khí Puma</strong>', CAST(N'2018-07-22T15:50:40.857' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (55, N'<strong>teamleader</strong> created a work order <strong>Muon máy nén khí Puma</strong>', CAST(N'2018-07-22T15:50:40.863' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (56, N'<strong>teamleader</strong> created a work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-22T15:52:14.070' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (57, N'<strong>teamleader</strong> created a work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-22T15:52:14.100' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (58, N'<strong>staff</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T02:26:36.350' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (59, N'<strong>staff</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T02:26:36.350' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (60, N'Hello from <strong>the other side</strong>!!! Test notification.', CAST(N'2018-07-23T02:28:00.157' AS DateTime), NULL)
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (61, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T02:52:06.820' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (62, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T02:52:06.823' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (63, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T02:54:53.757' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (64, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:10:31.907' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (65, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:10:31.917' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (66, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:14:24.887' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (67, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:14:24.890' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (68, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:29:29.807' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (69, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:29:41.210' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (70, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T03:29:41.210' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (71, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:46:12.440' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (72, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:46:12.487' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (73, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:46:25.567' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (74, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:49:08.953' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (75, N'<strong>staff</strong> re-requested work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:49:09.017' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (76, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:49:36.863' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (77, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:49:36.897' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (78, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:49:52.463' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (79, N'Staff <strong>staff</strong> has cancelled work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-07-23T09:55:37.860' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (80, N'Staff staff has cancelled work order Mượn máy hàn que', CAST(N'2018-07-23T09:55:37.860' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (81, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:55:59.103' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (82, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:55:59.137' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (83, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:05.820' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (84, N'<strong>teamleader</strong> re-requested work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:26.897' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (85, N'<strong>teamleader</strong> re-requested work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:26.900' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (86, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:49.920' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (87, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:49.950' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (88, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T09:56:57.793' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (89, N'<strong>teamleader</strong> created a work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T09:59:44.620' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (90, N'<strong>teamleader</strong> created a work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T09:59:44.630' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (91, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:00:07.080' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (92, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:00:07.110' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (93, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:00:15.010' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (94, N'<strong>teamleader</strong> re-requested work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:00:41.610' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (95, N'<strong>teamleader</strong> re-requested work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:00:41.617' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (96, N'Staff <strong>teamleader</strong> has cancelled work order <strong>Muon thiet bi</strong>', CAST(N'2018-07-23T10:05:41.080' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (97, N'Staff teamleader has cancelled work order Muon thiet bi', CAST(N'2018-07-23T10:05:41.107' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (98, N'<strong>teamleader</strong> re-requested work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T10:30:07.290' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (99, N'<strong>teamleader</strong> re-requested work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T10:30:07.300' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (100, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T10:30:38.950' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (101, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T10:30:38.950' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (102, N'<strong>teamleader</strong> created a work order <strong>Muon may in</strong>', CAST(N'2018-07-23T10:34:47.020' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (103, N'<strong>teamleader</strong> created a work order <strong>Muon may in</strong>', CAST(N'2018-07-23T10:34:47.027' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (104, N'Staff <strong>teamleader</strong> has cancelled work order <strong>Muon may in</strong>', CAST(N'2018-07-23T10:52:26.633' AS DateTime), N'{"page":"work_order","elementId":6}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (105, N'Staff teamleader has cancelled work order Muon may in', CAST(N'2018-07-23T10:52:26.637' AS DateTime), N'{"page":"work_order","elementId":6}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (106, N'<strong>teamleader</strong> created a work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T10:53:03.103' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (107, N'<strong>teamleader</strong> created a work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T10:53:03.113' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (108, N'<strong>teamleader</strong> updated work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T12:14:14.260' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (109, N'<strong>teamleader</strong> updated work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T12:14:14.260' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (110, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-23T12:17:49.783' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (111, N'Your work order <strong>Muon máy hàn que Jasic ARC 200</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-23T12:18:04.390' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (112, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T13:09:23.350' AS DateTime), N'{"page":"work_order","elementId":7}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (113, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T13:09:23.353' AS DateTime), N'{"page":"work_order","elementId":7}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (114, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may in 2</strong>', CAST(N'2018-07-23T13:09:45.797' AS DateTime), N'{"page":"work_order","elementId":7}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (115, N'Your work order <strong>Muon may in 2</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-23T13:09:53.337' AS DateTime), N'{"page":"work_order","elementId":7}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (116, N'<strong>teamleader</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-23T13:39:40.273' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (117, N'<strong>teamleader</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-23T13:39:40.297' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (118, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-23T13:39:47.330' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (119, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han</strong>', CAST(N'2018-07-23T13:39:47.360' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (120, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-23T13:39:52.437' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (121, N'Your work order <strong>Muon may han</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-23T13:39:59.103' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (122, N'<strong>teamleader</strong> created a work order <strong>Muon may han 2</strong>', CAST(N'2018-07-23T13:44:18.800' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (123, N'<strong>teamleader</strong> created a work order <strong>Muon may han 2</strong>', CAST(N'2018-07-23T13:44:18.837' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (124, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han 2</strong>', CAST(N'2018-07-24T13:44:40.553' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (125, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han 2</strong>', CAST(N'2018-07-24T13:44:40.623' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (126, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han 2</strong>', CAST(N'2018-07-24T13:44:46.820' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (127, N'Your work order <strong>Muon may han 2</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-24T13:45:03.887' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (128, N'<strong>staff</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T14:42:15.010' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (129, N'<strong>staff</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T14:42:15.057' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (130, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T14:42:58.227' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (131, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T14:42:58.270' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (132, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T14:43:05.777' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (133, N'Your work order <strong>Muon may han que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-24T14:43:23.037' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (134, N'<strong>staff</strong> created a work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-28T16:00:13.937' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (135, N'<strong>staff</strong> created a work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-28T16:00:13.970' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (136, N'<strong>staff</strong> updated work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-28T16:07:42.203' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (137, N'<strong>staff</strong> updated work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-28T16:07:42.233' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (138, N'<strong>staff</strong> created a work order <strong>Muon may in</strong>', CAST(N'2018-07-28T16:14:05.957' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (139, N'<strong>staff</strong> created a work order <strong>Muon may in</strong>', CAST(N'2018-07-28T16:14:05.960' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (140, N'<strong>staff</strong> updated work order <strong>Muon may in</strong>', CAST(N'2018-07-28T16:30:57.443' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (141, N'<strong>staff</strong> updated work order <strong>Muon may in</strong>', CAST(N'2018-07-28T16:30:57.460' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (142, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may in</strong>', CAST(N'2018-07-29T01:15:03.107' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (143, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may in</strong>', CAST(N'2018-07-29T01:15:03.150' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (144, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may in</strong>', CAST(N'2018-07-29T01:15:13.717' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (145, N'Your work order <strong>Muon may in</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-29T01:15:19.923' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (146, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-29T01:24:55.043' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (147, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-29T01:24:55.067' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (148, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy nén khí Puma</strong>', CAST(N'2018-07-29T01:27:25.620' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (149, N'Your work order <strong>Mượn máy nén khí Puma</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-29T01:27:35.987' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (150, N'<strong>staff</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:05:06.387' AS DateTime), N'[object Object]')
GO
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (151, N'<strong>staff</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:05:06.430' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (152, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:05:18.773' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (153, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:05:18.810' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (154, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:05:26.820' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (155, N'Your work order <strong>Muon may han</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-24T02:07:19.050' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (156, N'<strong>staff</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:25:19.633' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (157, N'<strong>staff</strong> created a work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:25:19.673' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (158, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:25:28.793' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (159, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:25:28.830' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (160, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han</strong>', CAST(N'2018-07-24T02:25:35.440' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (161, N'Your work order <strong>Muon may han</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-24T02:25:51.600' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (162, N'<strong>teamleader</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T03:04:17.203' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (163, N'<strong>teamleader</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T03:04:17.257' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (164, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T03:04:36.760' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (165, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T03:04:36.760' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (166, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T03:11:56.370' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (167, N'Your work order <strong>Muon may han que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-24T03:12:26.810' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (168, N'<strong>staff</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T04:22:53.803' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (169, N'<strong>staff</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-24T04:22:53.840' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (170, N'<strong>staff</strong> created a work order <strong>Muon may nen khi</strong>', CAST(N'2018-07-24T11:42:40.030' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (171, N'<strong>staff</strong> created a work order <strong>Muon may nen khi</strong>', CAST(N'2018-07-24T11:42:40.053' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (172, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may nen khi</strong>', CAST(N'2018-07-25T11:16:43.737' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (173, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may nen khi</strong>', CAST(N'2018-07-25T11:16:43.753' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (174, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may nen khi</strong>', CAST(N'2018-07-25T11:42:16.397' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (175, N'Your work order <strong>Muon may nen khi</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-25T11:42:34.727' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (176, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-07-25T11:59:23.660' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (177, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-07-25T11:59:24.160' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (178, N'<strong>teamleader</strong> created a work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-25T12:14:30.217' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (179, N'<strong>teamleader</strong> created a work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-25T12:14:30.290' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (180, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-25T12:15:27.380' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (181, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-25T12:15:27.463' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (182, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-25T12:15:58.620' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (183, N'<strong>staff</strong> created a work order <strong>muon do sua chua tang 1 moda</strong>', CAST(N'2018-07-25T15:41:22.653' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (184, N'<strong>staff</strong> created a work order <strong>muon do sua chua tang 1 moda</strong>', CAST(N'2018-07-25T15:41:22.730' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (185, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>muon do sua chua tang 1 moda</strong>', CAST(N'2018-07-26T08:46:09.627' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (186, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>muon do sua chua tang 1 moda</strong>', CAST(N'2018-07-26T08:46:09.703' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (187, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>muon do sua chua tang 1 moda</strong>', CAST(N'2018-07-26T08:46:21.830' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (188, N'Your work order <strong>muon do sua chua tang 1 moda</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-26T08:47:43.277' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (189, N'Staff <strong>teamleader</strong> has cancelled work order <strong>Muon thiet bi cho cong trinh Cau Phu Cuong</strong>', CAST(N'2018-07-29T15:35:49.567' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (190, N'Staff teamleader has cancelled work order Muon thiet bi cho cong trinh Cau Phu Cuong', CAST(N'2018-07-29T15:35:49.647' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (191, N'<strong>teamleader</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-29T15:36:48.937' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (192, N'<strong>teamleader</strong> created a work order <strong>Muon may han que</strong>', CAST(N'2018-07-29T15:36:48.973' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (193, N'<strong>maintainer</strong> created a work order <strong>Bao tri may in</strong>', CAST(N'2018-08-01T11:58:24.910' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (194, N'<strong>maintainer</strong> created a work order <strong>Bao tri may in</strong>', CAST(N'2018-08-01T11:58:24.963' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (195, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-08-01T13:07:47.613' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (196, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-01T13:07:47.717' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (197, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> work order <strong>Bao tri may in</strong>', CAST(N'2018-08-01T13:26:14.243' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (198, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> your work order <strong>Bao tri may in</strong>', CAST(N'2018-08-01T13:26:14.363' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (199, N'<strong>teamleader</strong> updated work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:31:41.090' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (200, N'<strong>teamleader</strong> updated work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:31:41.167' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (201, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:31:56.820' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (202, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:31:56.893' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (203, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:08.360' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (204, N'<strong>teamleader</strong> updated work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:21.060' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (205, N'<strong>teamleader</strong> updated work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:21.117' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (206, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:35.210' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (207, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:35.273' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (208, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T08:32:45.000' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (209, N'<strong>staff</strong> created a work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T12:04:12.013' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (210, N'<strong>staff</strong> created a work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T12:04:12.080' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (211, N'<strong>maintainer</strong> updated work order <strong>Bao tri may in</strong>', CAST(N'2018-08-02T12:47:21.477' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (212, N'<strong>maintainer</strong> updated work order <strong>Bao tri may in</strong>', CAST(N'2018-08-02T12:47:21.533' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (213, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-02T12:58:13.267' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (214, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-02T12:58:13.323' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (215, N'Maintainer <strong>maintainer</strong> has cancelled work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-02T13:03:22.880' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (216, N'Maintainer maintainer has cancelled work order Bao tri may han que 0003851085400', CAST(N'2018-08-02T13:03:22.960' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (217, N'Staff <strong>teamleader</strong> has cancelled work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T13:04:00.187' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (218, N'Staff teamleader has cancelled work order Muon may han que', CAST(N'2018-08-02T13:04:00.697' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (219, N'Maintainer <strong>maintainer</strong> has cancelled work order <strong>Bao tri may in</strong>', CAST(N'2018-08-02T13:13:45.140' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (220, N'Maintainer maintainer has cancelled work order Bao tri may in', CAST(N'2018-08-02T13:13:45.727' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (221, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-02T13:16:12.880' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (222, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-02T13:16:13.380' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (223, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may han que</strong>', CAST(N'2018-08-02T15:33:47.777' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (224, N'Your work order <strong>Muon may han que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-02T15:57:13.790' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (225, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T15:59:08.603' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (226, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T15:59:08.713' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (227, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:00:03.157' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (228, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:00:03.293' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (229, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:00:22.637' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (230, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:00:22.687' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (231, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:02:08.833' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (232, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:04:53.940' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (233, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:04:53.983' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (234, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:05:35.180' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (235, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:05:35.227' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (236, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:20:24.093' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (237, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:22:05.507' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (238, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:22:05.550' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (239, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:24:31.743' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (240, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:24:31.793' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (241, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:25:10.917' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (242, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:28:36.980' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (243, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:28:37.017' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (244, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:37:56.053' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (245, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:37:56.107' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (246, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:39:19.440' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (247, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:39:19.543' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (248, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:44:43.203' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (249, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:44:43.300' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (250, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:49:18.730' AS DateTime), N'{"page":"work_order","elementId":22}')
GO
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (251, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:50:22.600' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (252, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:50:22.690' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (253, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:50:40.780' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (254, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:50:40.873' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (255, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-02T16:52:08.337' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (256, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:00:37.227' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (257, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:00:37.287' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (258, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:31:35.890' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (259, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:31:35.970' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (260, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:36:22.697' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (261, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:52:29.763' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (262, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:52:29.830' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (263, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:58:26.527' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (264, N'Equipment Staff <strong>estaff</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T10:58:26.573' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (265, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:04:58.040' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (266, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:04:58.090' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (267, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:07:30.507' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (268, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:07:30.563' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (269, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:21:15.067' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (270, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:29:15.903' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (271, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:29:16.023' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (272, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:29:24.530' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (273, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:29:24.617' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (274, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:34:19.953' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (275, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:38:45.560' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (276, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:38:45.707' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (277, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:39:08.433' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (278, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:39:08.487' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (279, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:44:24.160' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (280, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:46:34.310' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (281, N'<strong>staff</strong> updated work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:46:34.453' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (282, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:46:54.983' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (283, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:46:55.033' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (284, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn Búa hơi đục bê tông G10</strong>', CAST(N'2018-08-03T11:47:07.047' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (285, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-03T11:50:52.230' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (286, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-03T11:50:52.280' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (287, N'Your work order <strong>Mượn Búa hơi đục bê tông G10</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-03T12:07:01.107' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (288, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-03T14:51:31.883' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (289, N'Your work order <strong>Bao tri may han que 0003851085400</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-03T14:55:52.280' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (290, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:00:29.530' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (291, N'<strong>maintainer</strong> created a work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:00:29.617' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (292, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:01:12.513' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (293, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:01:12.623' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (294, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Bao tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:01:39.933' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (295, N'', CAST(N'2018-08-04T15:01:44.253' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (296, N'<strong>maintainer</strong> created a work order <strong>BAo tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:13:57.480' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (297, N'<strong>maintainer</strong> created a work order <strong>BAo tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:13:57.533' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (298, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>BAo tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:14:06.100' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (299, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>BAo tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:14:06.180' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (300, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>BAo tri may han que 0003851085400</strong>', CAST(N'2018-08-04T15:14:12.050' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (301, N'<strong>staff</strong> created a work order <strong>muon may han</strong>', CAST(N'2018-08-07T16:36:16.813' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (302, N'<strong>staff</strong> created a work order <strong>muon may han</strong>', CAST(N'2018-08-07T16:36:16.923' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (303, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>muon may han</strong>', CAST(N'2018-08-07T16:37:15.070' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (304, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-07T16:37:15.153' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (305, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-07T16:42:26.613' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (306, N'<strong>staff</strong> updated work order <strong>muon may han</strong>', CAST(N'2018-08-08T11:19:15.423' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (307, N'<strong>staff</strong> updated work order <strong>muon may han</strong>', CAST(N'2018-08-08T11:19:15.510' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (308, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>muon may han</strong>', CAST(N'2018-08-08T11:19:47.740' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (309, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-08T11:19:47.817' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (310, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-08T11:20:04.847' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (311, N'<strong>maintainer</strong> created a work order <strong>bao tri may han</strong>', CAST(N'2018-08-08T16:16:16.890' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (312, N'<strong>maintainer</strong> created a work order <strong>bao tri may han</strong>', CAST(N'2018-08-08T16:16:17.047' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (313, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>bao tri may han</strong>', CAST(N'2018-08-08T16:16:48.507' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (314, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>bao tri may han</strong>', CAST(N'2018-08-08T16:16:48.580' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (315, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>bao tri may han</strong>', CAST(N'2018-08-08T16:16:58.170' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (316, N'<strong>staff</strong> updated work order <strong>muon may han</strong>', CAST(N'2018-08-09T12:39:55.583' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (317, N'<strong>staff</strong> updated work order <strong>muon may han</strong>', CAST(N'2018-08-09T12:39:55.673' AS DateTime), N'[object Object]')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (318, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>muon may han</strong>', CAST(N'2018-08-09T12:40:04.710' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (319, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-09T12:40:04.820' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (320, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>muon may han</strong>', CAST(N'2018-08-09T12:40:16.353' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (321, N'Your work order <strong>muon may han</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-09T12:40:31.333' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (322, N'<strong>teamleader</strong> created a work order <strong>Mượn 2 máy nén khí Puma XN2525</strong>', CAST(N'2018-08-16T12:36:38.370' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (323, N'<strong>teamleader</strong> created a work order <strong>Mượn 2 máy nén khí Puma XN2525</strong>', CAST(N'2018-08-16T12:36:38.440' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (324, N'<strong>teamleader</strong> created a work order <strong>Muon may nen khi Puma</strong>', CAST(N'2018-08-16T21:40:53.553' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (325, N'<strong>teamleader</strong> created a work order <strong>Muon may nen khi Puma</strong>', CAST(N'2018-08-16T21:40:53.593' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (326, N'<strong>maintainer</strong> created a work order <strong>abcsadfsdaf</strong>', CAST(N'2018-08-18T11:32:14.093' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (327, N'<strong>maintainer</strong> created a work order <strong>abcsadfsdaf</strong>', CAST(N'2018-08-18T11:32:14.237' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (328, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>abcsadfsdaf</strong>', CAST(N'2018-08-18T11:32:21.513' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (329, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>abcsadfsdaf</strong>', CAST(N'2018-08-18T11:32:21.603' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (330, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>abcsadfsdaf</strong>', CAST(N'2018-08-18T11:32:28.080' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (331, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may nen khi Puma</strong>', CAST(N'2018-08-18T11:42:35.807' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (332, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may nen khi Puma</strong>', CAST(N'2018-08-18T11:42:35.883' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (333, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Muon may nen khi Puma</strong>', CAST(N'2018-08-18T11:43:00.860' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (334, N'Your work order <strong>Muon may nen khi Puma</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-18T11:43:04.023' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (335, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn 2 máy nén khí Puma XN2525</strong>', CAST(N'2018-08-18T11:47:54.453' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (336, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn 2 máy nén khí Puma XN2525</strong>', CAST(N'2018-08-18T11:47:54.510' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (337, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn 2 máy nén khí Puma XN2525</strong>', CAST(N'2018-08-18T12:50:07.257' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (338, N'<strong>staff</strong> created a work order <strong>Aloalo</strong>', CAST(N'2018-08-21T04:54:11.850' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (339, N'<strong>staff</strong> created a work order <strong>Aloalo</strong>', CAST(N'2018-08-21T04:54:11.917' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (340, N'<strong>teamleader</strong> created a work order <strong>Muon may duoi sat</strong>', CAST(N'2018-08-21T09:28:11.400' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (341, N'<strong>teamleader</strong> created a work order <strong>Muon may duoi sat</strong>', CAST(N'2018-08-21T09:28:11.470' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (342, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Muon may duoi sat</strong>', CAST(N'2018-08-21T09:29:45.083' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (343, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Muon may duoi sat</strong>', CAST(N'2018-08-21T09:29:45.183' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (344, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-21T09:33:24.633' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (345, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-21T09:33:24.703' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (346, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy duỗi sắt cắt sắt tự động GT4-10</strong>', CAST(N'2018-08-21T09:40:53.500' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (347, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy duỗi sắt cắt sắt tự động GT4-10</strong>', CAST(N'2018-08-21T09:40:53.603' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (348, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy duỗi sắt cắt sắt tự động GT4-10</strong>', CAST(N'2018-08-21T09:41:00.900' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (349, N'<strong>staff</strong> created a work order <strong>Mượn thiết bị cho công trình ĐH FPT</strong>', CAST(N'2018-08-21T09:47:48.297' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (350, N'<strong>staff</strong> created a work order <strong>Mượn thiết bị cho công trình ĐH FPT</strong>', CAST(N'2018-08-21T09:47:48.363' AS DateTime), N'{"page":"work_order","elementId":35}')
GO
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (1, N'Kho 1', N'A', N'1', N'A7', NULL, 1)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (2, N'Kho 1', N'A', N'2', N'C2', NULL, 1)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (3, N'Trụ sở', N'A', N'2', N'A2', NULL, 2)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (4, N'Trụ sở', N'A', N'2', N'A3', NULL, 2)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (5, N'Công trường Misa Building', N'A', N'0', N'A2', NULL, 4)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (6, N'Công trường Misa Building', N'B', N'3', N'B1', NULL, 4)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (7, N'Công trường Misa Building', N'B', N'3', N'B2', NULL, 4)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (8, N'Công trường Misa Building', N'A', N'0', N'A1', NULL, 4)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (9, N'Công trường 4S Linh Đông', N'A', N'0', N'A1', NULL, 3)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (10, N'Công trường 4S Linh Đông', N'A', N'0', N'A2', NULL, 3)
SET IDENTITY_INSERT [dbo].[Position] OFF
SET IDENTITY_INSERT [dbo].[Priority] ON 

INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (1, N'Low', N'#00c853')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (2, N'Medium', N'#fbc02d')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (3, N'High', N'#ef5350')
SET IDENTITY_INSERT [dbo].[Priority] OFF
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (1, N'4S Linh Dong Apartment', 3, CAST(N'2018-06-02T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (2, N'MiSa Building', 4, CAST(N'2018-05-02T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (3, N'FPT University', 5, CAST(N'2018-03-02T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (4, N'Sky Center Building', 6, CAST(N'2018-01-01T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (5, N'Cầu vượt Nguyễn Thái Sơn', 7, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-04-30T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[ProjectTeams] ON 

INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (1, 1, 2, CAST(N'2018-06-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (4, 2, 3, CAST(N'2018-06-08T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (5, 3, 2, CAST(N'2018-03-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (6, 4, 4, CAST(N'2018-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (7, 5, 5, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-05-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ProjectTeams] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Equipment Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (5, N'Maintainer')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (1, N'xay dung abc', NULL, 1)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (2, N'Team A', NULL, 1)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (3, N'Team B', NULL, 1)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (4, N'Team C', NULL, 1)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (5, N'TeamD', NULL, 1)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (17, 2, 6, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (18, 2, 10, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (19, 2, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (20, 2, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (21, 3, 6, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (22, 3, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (23, 4, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (24, 4, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (25, 4, 6, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (26, 4, 9, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[TeamLocation] ON 

INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (1, 2, 2, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (2, 2, 4, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (5, 8, 3, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (6, 8, 1, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (7, 8, 2, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (8, 9, 5, CAST(N'2018-07-10T08:52:48.703' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (9, 7, 2, CAST(N'2018-07-10T09:25:27.903' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (16, 3, 4, CAST(N'2018-07-19T00:15:00.690' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (19, 11, 5, CAST(N'2018-07-19T00:15:56.590' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (20, 11, 4, CAST(N'2018-07-19T14:40:48.747' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (25, 11, 4, CAST(N'2018-08-18T12:50:19.147' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (26, 7, 3, CAST(N'2018-08-20T16:08:02.677' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (27, 7, 5, CAST(N'2018-08-20T16:08:02.677' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (33, 11, 5, CAST(N'2018-08-21T09:25:37.337' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (34, 11, 2, CAST(N'2018-08-21T09:25:37.347' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[TeamLocation] OFF
SET IDENTITY_INSERT [dbo].[TeamRoles] ON 

INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (1, N'Leader')
INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[TeamRoles] OFF
SET IDENTITY_INSERT [dbo].[Tile] ON 

INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (58, N'Library', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (59, N'PDP', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (60, N'104', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (61, N'103', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (62, N'105', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (63, N'106', 63, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (64, N'Ground', 64, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (65, N'1', 66, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (66, N'1', 68, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (67, N'1', 65, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (68, N'1', 67, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (69, N'1', 69, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (70, N'1', 70, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (71, N'1', 71, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (72, N'1', 72, NULL)
SET IDENTITY_INSERT [dbo].[Tile] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([Id], [Name]) VALUES (1, N'máy')
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (2, N'xe')
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (3, N'chiếc')
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nội', N'', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL, 1, N'0988 012 712')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (2, N'FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'http://www.dpoint.com.jp', N'Bùi Quang Nhật Châu', N'thietbivanphong@gmail.com', NULL, 1, N'0927234924')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (3, N'Công Ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', NULL, 1, N'0988 987 713')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL, 1, N'0988 128 891')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', NULL, 1, N'0988 127 127')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Kim Thanh ', N'truonglongoto@gmail.com', NULL, 1, N'0988 654 716')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', NULL, 1, N'0988 298 817')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (8, N'Công Ty Cổ Phần Máy Công Trình Phúc Long', N'Số 420, QL 1A, KP 2, Tam Bình, Thủ Đức, TP. HCM', N'http://phuclong.com', N'Nguyễn Việt Khánh', N'info@gmail.com.vn', N'', 0, N'0988 987 717')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (14, N'cong ty thien hoa', N'01 thien vuong', N'thienvuongthienhoa', N'thien hoa', N'thienhoa@gmail.com', NULL, 1, N'0988 239 568')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (16, N'Hải Dương Auto', N'Hải Dương Auto', N'', N'Huỳnh Hải Dương', N'contact@haiduongauto.com', NULL, 1, N'0988 468 468')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (17, N'Hải Dương Auto', N'Hải Dương Auto', N'', N'Huỳnh Hải Dương', N'contact@haiduongauto.com', NULL, 1, N'0988 681 980')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (18, N'Đình Thành', N'165 CMT8, Thủ Đức, TP. HCM', N'', N'Nguyễn Trung Thành', N'nguyentrungthanh@gmail.com', NULL, 1, N'0988 971 258')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (19, N'Đình Thành', N'165 CMT8, q Thủ Đức, TP. HCM', N'', N'Nguyễn Trung Thành', N'nguyentrungthanh1@gmail.com', NULL, 1, N'0988 096 187')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (20, N'Cong ty  van tai ABCD', N'35 Yersin, quan 12, tp HCM', N'abc.com.voa', N'Nguyễn Văn Hòa', N'abcauto@gmail.com', NULL, 1, N'0988 765 890')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thiết bị xây dựng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thiết bị văn phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thiết bị cơ sở vật chất', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
SET IDENTITY_INSERT [dbo].[WorkOrder] ON 

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (3, N'Muon máy hàn que Jasic ARC 200', 8, CAST(N'2018-07-22T15:52:13.920' AS DateTime), CAST(N'2018-07-23T17:00:00.000' AS DateTime), CAST(N'2018-07-30T17:00:00.000' AS DateTime), CAST(N'2018-07-23T12:18:04.127' AS DateTime), CAST(N'2018-07-23T12:42:24.770' AS DateTime), 1, 6, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (4, N'Mượn máy hàn que', 6, CAST(N'2018-07-23T02:26:36.013' AS DateTime), CAST(N'2018-07-22T17:00:00.000' AS DateTime), CAST(N'2018-07-25T17:00:00.000' AS DateTime), NULL, NULL, 2, 1009, 2, 20, N'hello')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (5, N'Muon thiet bi', 8, CAST(N'2018-07-23T09:59:44.220' AS DateTime), CAST(N'2018-07-22T17:00:00.000' AS DateTime), CAST(N'2018-07-30T17:00:00.000' AS DateTime), NULL, NULL, 3, 1009, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (6, N'Muon may in', 8, CAST(N'2018-07-23T10:34:46.887' AS DateTime), CAST(N'2018-07-22T17:00:00.000' AS DateTime), CAST(N'2018-07-25T17:00:00.000' AS DateTime), NULL, NULL, 3, 1009, 2, 8, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (7, N'Muon may in 2', 8, CAST(N'2018-07-23T10:53:02.980' AS DateTime), CAST(N'2018-07-23T00:00:00.000' AS DateTime), CAST(N'2018-07-26T00:00:00.000' AS DateTime), CAST(N'2018-07-23T13:09:53.203' AS DateTime), CAST(N'2018-07-23T13:28:01.607' AS DateTime), 2, 6, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (8, N'Muon may han', 8, CAST(N'2018-07-23T13:39:40.050' AS DateTime), CAST(N'2018-07-23T00:00:00.000' AS DateTime), CAST(N'2018-07-27T00:00:00.000' AS DateTime), CAST(N'2018-07-23T13:39:58.690' AS DateTime), CAST(N'2018-07-23T13:41:01.227' AS DateTime), 1, 6, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (9, N'Muon may han 2', 8, CAST(N'2018-07-23T13:44:18.593' AS DateTime), CAST(N'2018-07-23T00:00:00.000' AS DateTime), CAST(N'2018-07-27T00:00:00.000' AS DateTime), CAST(N'2018-07-24T13:45:03.520' AS DateTime), CAST(N'2018-07-24T13:45:57.543' AS DateTime), 2, 6, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (10, N'Muon may han que', 6, CAST(N'2018-07-24T14:42:14.803' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2018-07-31T00:00:00.000' AS DateTime), CAST(N'2018-07-24T14:43:22.527' AS DateTime), CAST(N'2018-07-28T14:44:27.173' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (11, N'Mượn máy nén khí Puma', 6, CAST(N'2018-07-28T16:00:13.713' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-08-24T00:00:00.000' AS DateTime), CAST(N'2018-07-29T01:27:35.700' AS DateTime), CAST(N'2018-07-29T01:28:22.033' AS DateTime), 2, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (12, N'Muon may in', 6, CAST(N'2018-07-28T16:14:05.757' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-31T00:00:00.000' AS DateTime), CAST(N'2018-07-29T01:15:19.580' AS DateTime), CAST(N'2018-07-29T01:17:20.200' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (13, N'Muon may han', 6, CAST(N'2018-07-24T02:05:06.223' AS DateTime), CAST(N'2018-07-24T00:00:00.000' AS DateTime), CAST(N'2018-07-31T00:00:00.000' AS DateTime), CAST(N'2018-07-24T02:07:18.753' AS DateTime), CAST(N'2018-07-24T02:07:42.543' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (14, N'Muon may han', 6, CAST(N'2018-07-24T02:25:19.387' AS DateTime), CAST(N'2018-07-24T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-24T02:25:51.273' AS DateTime), CAST(N'2018-07-24T02:26:47.150' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (15, N'Muon may han que', 8, CAST(N'2018-07-24T03:04:16.983' AS DateTime), CAST(N'2018-07-24T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-24T03:12:26.400' AS DateTime), CAST(N'2018-07-24T03:15:43.173' AS DateTime), 1, 6, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (16, N'Muon may han que', 6, CAST(N'2018-07-24T04:22:53.540' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-08-02T15:57:13.480' AS DateTime), CAST(N'2018-08-04T15:17:23.077' AS DateTime), 2, 6, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (17, N'Muon may nen khi', 6, CAST(N'2018-07-24T11:42:39.887' AS DateTime), CAST(N'2018-07-24T00:00:00.000' AS DateTime), CAST(N'2018-08-24T00:00:00.000' AS DateTime), CAST(N'2018-07-25T11:42:34.630' AS DateTime), CAST(N'2018-07-31T13:50:59.020' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (18, N'Muon thiet bi cho cong trinh Cau Phu Cuong', 8, CAST(N'2018-07-25T12:14:29.533' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2019-08-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 1009, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (19, N'muon do sua chua tang 1 moda', 6, CAST(N'2018-07-25T15:41:22.240' AS DateTime), CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2021-07-31T00:00:00.000' AS DateTime), CAST(N'2018-07-26T08:47:42.627' AS DateTime), CAST(N'2018-08-04T15:17:14.960' AS DateTime), 2, 6, 2, 16, N'ke me t')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (20, N'Muon may han que', 8, CAST(N'2018-07-29T15:36:48.637' AS DateTime), CAST(N'2018-07-29T00:00:00.000' AS DateTime), CAST(N'2018-08-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 1009, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (21, N'Bao tri may in', 15, CAST(N'2018-08-01T11:58:24.810' AS DateTime), CAST(N'2018-08-02T00:00:00.000' AS DateTime), CAST(N'2018-08-04T00:00:00.000' AS DateTime), NULL, NULL, 1, 1009, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (22, N'Mượn Búa hơi đục bê tông G10', 6, CAST(N'2018-08-02T12:04:11.640' AS DateTime), CAST(N'2018-08-09T00:00:00.000' AS DateTime), CAST(N'2018-08-24T00:00:00.000' AS DateTime), CAST(N'2018-08-03T12:07:00.840' AS DateTime), CAST(N'2018-08-05T14:44:34.647' AS DateTime), 1, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (25, N'Bao tri may han que 0003851085400', 15, CAST(N'2018-08-04T15:00:29.347' AS DateTime), CAST(N'2018-08-04T00:00:00.000' AS DateTime), CAST(N'2018-08-06T00:00:00.000' AS DateTime), CAST(N'2018-08-04T15:01:44.090' AS DateTime), CAST(N'2018-08-04T15:12:17.447' AS DateTime), 1, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (26, N'BAo tri may han que 0003851085400', 15, CAST(N'2018-08-04T15:13:57.340' AS DateTime), CAST(N'2018-08-04T00:00:00.000' AS DateTime), CAST(N'2018-08-06T00:00:00.000' AS DateTime), CAST(N'2018-08-04T15:14:17.113' AS DateTime), CAST(N'2018-08-04T15:14:31.943' AS DateTime), 2, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (27, N'muon may han', 6, CAST(N'2018-08-07T16:36:16.580' AS DateTime), CAST(N'2018-08-07T00:00:00.000' AS DateTime), CAST(N'2018-08-30T00:00:00.000' AS DateTime), CAST(N'2018-08-09T12:40:31.127' AS DateTime), CAST(N'2018-08-09T12:41:19.100' AS DateTime), 3, 6, 2, 20, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (28, N'bao tri may han', 15, CAST(N'2018-08-08T16:16:16.787' AS DateTime), CAST(N'2018-08-08T00:00:00.000' AS DateTime), CAST(N'2018-08-17T00:00:00.000' AS DateTime), CAST(N'2018-08-08T16:17:10.380' AS DateTime), CAST(N'2018-08-14T08:42:24.123' AS DateTime), 3, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (29, N'Mượn 2 máy nén khí Puma XN2525', 8, CAST(N'2018-08-16T12:36:38.180' AS DateTime), CAST(N'2018-08-17T00:00:00.000' AS DateTime), CAST(N'2018-08-31T00:00:00.000' AS DateTime), NULL, NULL, 2, 4, 2, 19, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (30, N'Muon may nen khi Puma', 8, CAST(N'2018-08-16T21:40:53.417' AS DateTime), CAST(N'2018-08-18T00:00:00.000' AS DateTime), CAST(N'2018-08-24T00:00:00.000' AS DateTime), CAST(N'2018-08-18T11:43:03.880' AS DateTime), NULL, 1, 5, 2, 9, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (31, N'Bao tri may in', 15, CAST(N'2018-08-18T11:32:13.983' AS DateTime), CAST(N'2018-08-18T00:00:00.000' AS DateTime), CAST(N'2018-08-23T00:00:00.000' AS DateTime), CAST(N'2018-08-18T11:32:33.347' AS DateTime), NULL, 1, 5, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (32, N'Mượn máy duỗi sắt cắt sắt tự động GT4-10', 6, CAST(N'2018-08-21T04:54:11.693' AS DateTime), CAST(N'2018-08-24T00:00:00.000' AS DateTime), CAST(N'2018-08-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 3, 2, 16, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (33, N'Muon may duoi sat', 8, CAST(N'2018-08-21T09:28:11.287' AS DateTime), CAST(N'2018-08-21T00:00:00.000' AS DateTime), CAST(N'2018-08-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 2, 2, 34, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (34, N'Mượn máy hàn que', 8, CAST(N'2018-08-21T09:33:24.493' AS DateTime), CAST(N'2018-08-23T00:00:00.000' AS DateTime), CAST(N'2018-09-30T00:00:00.000' AS DateTime), NULL, NULL, 2, 1, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (35, N'Mượn thiết bị cho công trình ĐH FPT', 6, CAST(N'2018-08-21T09:47:48.083' AS DateTime), CAST(N'2018-08-21T00:00:00.000' AS DateTime), CAST(N'2018-09-14T00:00:00.000' AS DateTime), NULL, NULL, 3, 1, 2, 2, N'')
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (30, 2, 5, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (31, 3, 5, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (32, 36, 5, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (33, 1, 5, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (34, 11, 5, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (35, 50, 3, CAST(N'2018-07-23T12:42:24.673' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (36, 49, 3, CAST(N'2018-07-23T12:42:24.767' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (37, 7, 6, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (38, 8, 6, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (41, 7, 7, CAST(N'2018-07-23T13:28:01.607' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (42, 50, 8, CAST(N'2018-07-23T13:41:01.217' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (43, 49, 8, CAST(N'2018-07-23T13:41:01.217' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (44, 51, 8, CAST(N'2018-07-23T13:41:01.227' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (45, 49, 9, CAST(N'2018-07-24T13:45:29.783' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (46, 50, 9, CAST(N'2018-07-24T13:45:57.543' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (47, 49, 10, CAST(N'2018-07-28T14:44:27.170' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (48, 50, 10, CAST(N'2018-07-28T14:44:27.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (51, 3, 11, CAST(N'2018-07-29T01:28:22.033' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (53, 7, 12, CAST(N'2018-07-29T01:16:57.217' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (54, 8, 12, CAST(N'2018-07-29T01:17:20.200' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (55, 51, 13, CAST(N'2018-07-24T02:07:42.507' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (56, 52, 13, CAST(N'2018-07-24T02:07:42.543' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (57, 51, 14, CAST(N'2018-07-24T02:26:30.357' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (58, 52, 14, CAST(N'2018-07-24T02:26:47.137' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (59, 53, 14, CAST(N'2018-07-24T02:26:47.150' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (60, 51, 15, CAST(N'2018-07-24T03:15:43.113' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (61, 52, 15, CAST(N'2018-07-24T03:15:43.173' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (62, 53, 15, CAST(N'2018-07-24T03:15:43.120' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (63, 54, 15, CAST(N'2018-07-24T03:15:43.173' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (64, 49, 16, CAST(N'2018-08-04T15:17:22.823' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (65, 50, 16, CAST(N'2018-08-04T15:17:22.960' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (66, 51, 16, CAST(N'2018-08-04T15:17:23.077' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (67, 3, 17, CAST(N'2018-07-31T13:50:59.020' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (68, 55, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (69, 53, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (70, 54, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (71, 52, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (72, 1, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (73, 2, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (74, 56, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (75, 58, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (76, 57, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (77, 11, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (78, 35, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (79, 36, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (80, 12, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (81, 9, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (82, 10, 18, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (83, 53, 19, CAST(N'2018-07-26T14:58:06.583' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (84, 55, 19, CAST(N'2018-08-04T15:17:13.697' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (85, 16, 19, CAST(N'2018-08-04T15:17:14.480' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (86, 17, 19, CAST(N'2018-08-04T15:17:14.710' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (87, 18, 19, CAST(N'2018-08-04T15:17:14.960' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (88, 1, 19, CAST(N'2018-07-26T14:59:27.443' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (89, 2, 19, CAST(N'2018-08-04T12:18:45.720' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (90, 58, 19, CAST(N'2018-08-04T15:17:13.973' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (91, 7, 19, CAST(N'2018-08-04T15:17:14.227' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (101, 49, 20, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (102, 54, 20, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (103, 50, 20, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (104, 52, 20, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (108, 8, 21, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (144, 11, 22, CAST(N'2018-08-03T14:44:34.273' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (145, 35, 22, CAST(N'2018-08-03T14:44:34.417' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (146, 36, 22, CAST(N'2018-08-03T14:44:34.647' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (147, 51, 25, CAST(N'2018-08-04T15:12:17.447' AS DateTime), 100, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (148, 51, 26, CAST(N'2018-08-04T15:14:31.943' AS DateTime), 100, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (153, 55, 28, CAST(N'2018-08-14T08:42:24.123' AS DateTime), 0, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (154, 54, 27, CAST(N'2018-08-09T12:41:18.990' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (155, 49, 27, CAST(N'2018-08-09T12:41:19.100' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (156, 3, 29, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (157, 57, 29, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (158, 57, 30, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (159, 7, 31, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (160, 64, 32, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (161, 65, 32, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (162, 66, 33, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (163, 50, 34, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (164, 54, 34, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (165, 59, 35, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (166, 60, 35, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (167, 3, 35, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (168, 1, 35, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] ON 

INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (53, 35, 10, CAST(N'2018-07-23T12:42:24.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (54, 36, 10, CAST(N'2018-07-23T12:42:24.733' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (55, 41, 10, CAST(N'2018-07-23T13:28:01.593' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (56, 42, 10, CAST(N'2018-07-23T13:41:01.207' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (57, 43, 10, CAST(N'2018-07-23T13:41:01.210' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (58, 44, 10, CAST(N'2018-07-23T13:41:01.217' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (59, 45, 10, CAST(N'2018-07-24T13:45:29.767' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (60, 46, 10, CAST(N'2018-07-24T13:45:57.420' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (61, 48, 10, CAST(N'2018-07-28T14:44:27.097' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (62, 47, 10, CAST(N'2018-07-28T14:44:27.163' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (63, 53, 10, CAST(N'2018-07-29T01:16:57.213' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (64, 54, 10, CAST(N'2018-07-29T01:17:20.193' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (65, 51, 10, CAST(N'2018-07-29T01:28:22.030' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (66, 55, 10, CAST(N'2018-07-24T02:07:42.497' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (67, 56, 10, CAST(N'2018-07-24T02:07:42.523' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (68, 57, 10, CAST(N'2018-07-24T02:26:30.357' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (69, 58, 10, CAST(N'2018-07-24T02:26:47.137' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (70, 59, 10, CAST(N'2018-07-24T02:26:47.147' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (71, 60, 10, CAST(N'2018-07-24T03:15:43.100' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (72, 62, 10, CAST(N'2018-07-24T03:15:43.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (73, 63, 10, CAST(N'2018-07-24T03:15:43.170' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (74, 61, 10, CAST(N'2018-07-24T03:15:43.170' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (75, 83, 10, CAST(N'2018-07-26T14:58:06.583' AS DateTime), 7, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (76, 88, 10, CAST(N'2018-07-26T14:59:27.440' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (77, 67, 10, CAST(N'2018-07-31T13:50:59.013' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (78, 144, 10, CAST(N'2018-08-03T14:44:34.273' AS DateTime), 7, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (79, 145, 10, CAST(N'2018-08-03T14:44:34.417' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (80, 146, 10, CAST(N'2018-08-03T14:44:34.640' AS DateTime), 7, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (81, 89, 10, CAST(N'2018-08-04T12:18:45.717' AS DateTime), 7, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (83, 147, 10, CAST(N'2018-08-04T15:12:17.433' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (84, 148, 10, CAST(N'2018-08-04T15:14:31.937' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (85, 84, 10, CAST(N'2018-08-04T15:17:13.697' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (86, 90, 10, CAST(N'2018-08-04T15:17:13.970' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (87, 91, 10, CAST(N'2018-08-04T15:17:14.220' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (88, 85, 10, CAST(N'2018-08-04T15:17:14.477' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (89, 86, 10, CAST(N'2018-08-04T15:17:14.700' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (90, 87, 10, CAST(N'2018-08-04T15:17:14.930' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (91, 64, 10, CAST(N'2018-08-04T15:17:22.800' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (92, 65, 10, CAST(N'2018-08-04T15:17:22.960' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (93, 66, 10, CAST(N'2018-08-04T15:17:23.077' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (94, 154, 10, CAST(N'2018-08-09T12:41:18.990' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (95, 155, 10, CAST(N'2018-08-09T12:41:19.097' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (96, 153, 10, CAST(N'2018-08-14T08:42:24.120' AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] ON 

INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (183, 3, 8, CAST(N'2018-07-22T15:52:13.920' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (184, 4, 6, CAST(N'2018-07-23T02:26:36.013' AS DateTime), NULL, 1, N'hello')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (185, 4, 10, CAST(N'2018-07-23T02:52:06.630' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (186, 4, 3, CAST(N'2018-07-23T02:54:53.637' AS DateTime), 2, 4, N'reject')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (187, 4, 6, CAST(N'2018-07-23T03:10:31.930' AS DateTime), 4, 1, N'hello')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (188, 4, 10, CAST(N'2018-07-23T03:14:24.720' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (189, 4, 3, CAST(N'2018-07-23T03:29:29.650' AS DateTime), 2, 4, N'reject again
')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (190, 4, 6, CAST(N'2018-07-23T03:29:41.237' AS DateTime), 4, 1, N'hello')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (191, 4, 10, CAST(N'2018-07-23T09:46:12.337' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (192, 4, 3, CAST(N'2018-07-23T09:46:25.450' AS DateTime), 2, 4, N'reject')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (193, 4, 6, CAST(N'2018-07-23T09:49:08.957' AS DateTime), 4, 1, N'ok')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (194, 4, 10, CAST(N'2018-07-23T09:49:36.757' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (195, 4, 3, CAST(N'2018-07-23T09:49:52.370' AS DateTime), 2, 4, N'reject')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (196, 4, 6, CAST(N'2018-07-23T09:55:37.773' AS DateTime), 4, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (197, 3, 10, CAST(N'2018-07-23T09:55:59.037' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (198, 3, 3, CAST(N'2018-07-23T09:56:05.750' AS DateTime), 2, 4, N'reject')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (199, 3, 8, CAST(N'2018-07-23T09:56:26.907' AS DateTime), 4, 1, N'hello from the other side')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (200, 3, 10, CAST(N'2018-07-23T09:56:49.840' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (201, 3, 3, CAST(N'2018-07-23T09:56:57.687' AS DateTime), 2, 4, N'hmm')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (202, 5, 8, CAST(N'2018-07-23T09:59:44.220' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (203, 5, 10, CAST(N'2018-07-23T10:00:07.010' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (204, 5, 3, CAST(N'2018-07-23T10:00:14.940' AS DateTime), 2, 4, N'muon nhieu qua')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (205, 5, 8, CAST(N'2018-07-23T10:00:41.570' AS DateTime), 4, 1, N'ok ??')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (206, 5, 8, CAST(N'2018-07-23T10:05:41.000' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (207, 3, 8, CAST(N'2018-07-23T10:30:07.297' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (208, 3, 10, CAST(N'2018-07-23T10:30:38.867' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (209, 6, 8, CAST(N'2018-07-23T10:34:46.887' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (210, 6, 8, CAST(N'2018-07-23T10:52:26.527' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (211, 7, 8, CAST(N'2018-07-23T10:53:02.980' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (212, 7, 8, CAST(N'2018-07-23T12:14:14.267' AS DateTime), 1, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (213, 3, 3, CAST(N'2018-07-23T12:17:49.520' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (214, 3, 10, CAST(N'2018-07-23T12:18:04.127' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (215, 3, 10, CAST(N'2018-07-23T12:42:24.777' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (216, 7, 10, CAST(N'2018-07-23T13:09:23.190' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (217, 7, 3, CAST(N'2018-07-23T13:09:45.597' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (218, 7, 10, CAST(N'2018-07-23T13:09:53.203' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (219, 7, 10, CAST(N'2018-07-23T13:28:01.607' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (220, 8, 8, CAST(N'2018-07-23T13:39:40.050' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (221, 8, 10, CAST(N'2018-07-23T13:39:47.053' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (222, 8, 3, CAST(N'2018-07-23T13:39:51.937' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (223, 8, 10, CAST(N'2018-07-23T13:39:58.690' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (224, 8, 10, CAST(N'2018-07-23T13:41:01.230' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (225, 9, 8, CAST(N'2018-07-23T13:44:18.593' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (226, 9, 10, CAST(N'2018-07-24T13:44:39.777' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (227, 9, 3, CAST(N'2018-07-24T13:44:45.460' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (228, 9, 10, CAST(N'2018-07-24T13:45:03.520' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (229, 9, 10, CAST(N'2018-07-24T13:45:57.543' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (230, 10, 6, CAST(N'2018-07-24T14:42:14.803' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (231, 10, 10, CAST(N'2018-07-24T14:42:57.960' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (232, 10, 3, CAST(N'2018-07-24T14:43:05.283' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (233, 10, 10, CAST(N'2018-07-24T14:43:22.527' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (234, 10, 10, CAST(N'2018-07-28T14:44:27.177' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (235, 11, 6, CAST(N'2018-07-28T16:00:13.713' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (236, 11, 6, CAST(N'2018-07-28T16:07:42.217' AS DateTime), 1, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (237, 12, 6, CAST(N'2018-07-28T16:14:05.757' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (238, 12, 6, CAST(N'2018-07-28T16:30:57.380' AS DateTime), 1, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (239, 12, 10, CAST(N'2018-07-29T01:15:02.917' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (240, 12, 3, CAST(N'2018-07-29T01:15:13.337' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (241, 12, 10, CAST(N'2018-07-29T01:15:19.580' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (242, 12, 10, CAST(N'2018-07-29T01:17:20.200' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (243, 11, 10, CAST(N'2018-07-29T01:24:54.830' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (244, 11, 3, CAST(N'2018-07-29T01:27:25.380' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (245, 11, 10, CAST(N'2018-07-29T01:27:35.700' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (246, 11, 10, CAST(N'2018-07-29T01:28:22.033' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (247, 13, 6, CAST(N'2018-07-24T02:05:06.223' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (248, 13, 10, CAST(N'2018-07-24T02:05:18.537' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (249, 13, 3, CAST(N'2018-07-24T02:05:26.527' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (250, 13, 10, CAST(N'2018-07-24T02:07:18.753' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (251, 13, 10, CAST(N'2018-07-24T02:07:42.543' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (252, 14, 6, CAST(N'2018-07-24T02:25:19.387' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (253, 14, 10, CAST(N'2018-07-24T02:25:28.610' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (254, 14, 3, CAST(N'2018-07-24T02:25:35.133' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (255, 14, 10, CAST(N'2018-07-24T02:25:51.273' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (256, 14, 10, CAST(N'2018-07-24T02:26:47.150' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (257, 15, 8, CAST(N'2018-07-24T03:04:16.983' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (258, 15, 10, CAST(N'2018-07-24T03:04:36.510' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (259, 15, 3, CAST(N'2018-07-24T03:11:55.670' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (260, 15, 10, CAST(N'2018-07-24T03:12:26.400' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (261, 15, 10, CAST(N'2018-07-24T03:15:43.173' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (262, 15, 10, CAST(N'2018-07-24T03:15:43.173' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (263, 16, 6, CAST(N'2018-07-24T04:22:53.540' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (264, 17, 6, CAST(N'2018-07-24T11:42:39.887' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (265, 17, 10, CAST(N'2018-07-25T11:16:43.630' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (266, 17, 3, CAST(N'2018-07-25T11:42:16.283' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (267, 17, 10, CAST(N'2018-07-25T11:42:34.630' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (268, 16, 10, CAST(N'2018-07-25T11:59:23.557' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (269, 18, 8, CAST(N'2018-07-25T12:14:29.533' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (270, 18, 10, CAST(N'2018-07-25T12:15:27.317' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (271, 18, 3, CAST(N'2018-07-25T12:15:58.567' AS DateTime), 2, 4, N'muon nhieu qua, nen tao nhieu Work Order khac nhau voi thoi gian cu the')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (272, 19, 6, CAST(N'2018-07-25T15:41:22.240' AS DateTime), NULL, 1, N'ke me t')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (273, 19, 10, CAST(N'2018-07-26T08:46:09.567' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (274, 19, 3, CAST(N'2018-07-26T08:46:20.960' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (275, 19, 10, CAST(N'2018-07-26T08:47:42.627' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (276, 18, 8, CAST(N'2018-07-29T15:35:49.493' AS DateTime), 4, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (277, 20, 8, CAST(N'2018-07-29T15:36:48.637' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (278, 17, 10, CAST(N'2018-07-31T13:50:59.023' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (279, 21, 15, CAST(N'2018-08-01T11:58:24.810' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (280, 20, 10, CAST(N'2018-08-01T13:07:47.520' AS DateTime), 1, 4, N'thieu thiet bi')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (281, 21, 10, CAST(N'2018-08-01T13:26:14.160' AS DateTime), 1, 4, N'ko')
GO
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (282, 20, 8, CAST(N'2018-08-02T08:31:40.900' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (283, 20, 10, CAST(N'2018-08-02T08:31:56.713' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (284, 20, 3, CAST(N'2018-08-02T08:32:08.297' AS DateTime), 2, 4, N'ko')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (285, 20, 8, CAST(N'2018-08-02T08:32:20.867' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (286, 20, 10, CAST(N'2018-08-02T08:32:35.123' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (287, 20, 3, CAST(N'2018-08-02T08:32:44.930' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (288, 22, 6, CAST(N'2018-08-02T12:04:11.640' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (289, 21, 15, CAST(N'2018-08-02T12:47:21.420' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (292, 20, 8, CAST(N'2018-08-02T13:04:00.123' AS DateTime), 4, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (293, 21, 15, CAST(N'2018-08-02T13:13:45.053' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (295, 16, 3, CAST(N'2018-08-02T15:33:47.440' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (296, 16, 10, CAST(N'2018-08-02T15:57:13.480' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (297, 22, 10, CAST(N'2018-08-02T15:59:08.483' AS DateTime), 1, 4, N'ko')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (298, 22, 6, CAST(N'2018-08-02T16:00:03.050' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (299, 22, 10, CAST(N'2018-08-02T16:00:22.537' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (300, 22, 3, CAST(N'2018-08-02T16:02:08.787' AS DateTime), 2, 4, N'ko')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (301, 22, 6, CAST(N'2018-08-02T16:04:53.713' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (302, 22, 10, CAST(N'2018-08-02T16:05:35.113' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (303, 22, 3, CAST(N'2018-08-02T16:20:24.040' AS DateTime), 2, 4, N'ko')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (304, 22, 6, CAST(N'2018-08-02T16:22:05.260' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (305, 22, 10, CAST(N'2018-08-02T16:24:31.687' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (306, 22, 3, CAST(N'2018-08-02T16:25:10.867' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (307, 22, 6, CAST(N'2018-08-02T16:28:36.773' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (308, 22, 10, CAST(N'2018-08-02T16:37:55.997' AS DateTime), 1, 4, N'koo')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (309, 22, 6, CAST(N'2018-08-02T16:39:19.237' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (310, 22, 10, CAST(N'2018-08-02T16:44:43.137' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (311, 22, 3, CAST(N'2018-08-02T16:49:18.677' AS DateTime), 2, 4, N'nono')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (312, 22, 6, CAST(N'2018-08-02T16:50:22.517' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (313, 22, 10, CAST(N'2018-08-02T16:50:40.657' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (314, 22, 3, CAST(N'2018-08-02T16:52:08.190' AS DateTime), 2, 4, N'nonono')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (315, 22, 6, CAST(N'2018-08-03T10:00:37.037' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (316, 22, 10, CAST(N'2018-08-03T10:31:35.793' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (317, 22, 3, CAST(N'2018-08-03T10:36:22.613' AS DateTime), 2, 4, N'nonono')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (318, 22, 6, CAST(N'2018-08-03T10:52:29.520' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (319, 22, 10, CAST(N'2018-08-03T10:58:26.477' AS DateTime), 1, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (320, 22, 6, CAST(N'2018-08-03T11:04:57.810' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (321, 22, 10, CAST(N'2018-08-03T11:07:30.453' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (322, 22, 3, CAST(N'2018-08-03T11:21:15.010' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (323, 22, 6, CAST(N'2018-08-03T11:29:15.783' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (324, 22, 10, CAST(N'2018-08-03T11:29:24.457' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (325, 22, 3, CAST(N'2018-08-03T11:34:19.893' AS DateTime), 2, 4, N'yes')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (326, 22, 6, CAST(N'2018-08-03T11:38:45.440' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (327, 22, 10, CAST(N'2018-08-03T11:39:08.377' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (328, 22, 3, CAST(N'2018-08-03T11:44:24.100' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (329, 22, 6, CAST(N'2018-08-03T11:46:34.020' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (330, 22, 10, CAST(N'2018-08-03T11:46:54.933' AS DateTime), 1, 2, N'yes')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (331, 22, 3, CAST(N'2018-08-03T11:47:06.780' AS DateTime), 2, 3, N'ok')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (333, 22, 10, CAST(N'2018-08-03T12:07:00.840' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (334, 22, 10, CAST(N'2018-08-03T14:44:34.647' AS DateTime), 5, 6, N'bi trom')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (338, 25, 15, CAST(N'2018-08-04T15:00:29.347' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (339, 25, 10, CAST(N'2018-08-04T15:01:12.430' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (340, 25, 3, CAST(N'2018-08-04T15:01:39.773' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (341, 25, 10, CAST(N'2018-08-04T15:01:44.090' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (342, 25, 10, CAST(N'2018-08-04T15:12:17.447' AS DateTime), 5, 6, N'Thay mo han')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (343, 26, 15, CAST(N'2018-08-04T15:13:57.340' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (344, 26, 10, CAST(N'2018-08-04T15:14:06.030' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (345, 26, 3, CAST(N'2018-08-04T15:14:11.950' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (346, 26, 10, CAST(N'2018-08-04T15:14:17.113' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (347, 26, 10, CAST(N'2018-08-04T15:14:31.943' AS DateTime), 5, 6, N'Thay mo han')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (348, 19, 10, CAST(N'2018-08-04T15:17:14.963' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (349, 16, 10, CAST(N'2018-08-04T15:17:23.077' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (350, 27, 6, CAST(N'2018-08-07T16:36:16.580' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (351, 27, 10, CAST(N'2018-08-07T16:37:15.000' AS DateTime), 1, 2, N'helo')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (352, 27, 3, CAST(N'2018-08-07T16:42:26.520' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (353, 27, 6, CAST(N'2018-08-08T11:19:15.227' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (354, 27, 10, CAST(N'2018-08-08T11:19:47.660' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (355, 27, 3, CAST(N'2018-08-08T11:20:04.767' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (356, 28, 15, CAST(N'2018-08-08T16:16:16.787' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (357, 28, 10, CAST(N'2018-08-08T16:16:48.413' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (358, 28, 3, CAST(N'2018-08-08T16:16:58.037' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (359, 28, 10, CAST(N'2018-08-08T16:17:10.380' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (360, 27, 6, CAST(N'2018-08-09T12:39:55.417' AS DateTime), 4, 1, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (361, 27, 10, CAST(N'2018-08-09T12:40:04.653' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (362, 27, 3, CAST(N'2018-08-09T12:40:16.107' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (363, 27, 10, CAST(N'2018-08-09T12:40:31.127' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (364, 27, 10, CAST(N'2018-08-09T12:41:19.100' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (365, 28, 10, CAST(N'2018-08-14T08:42:24.123' AS DateTime), 5, 6, N'thay que han')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (366, 29, 8, CAST(N'2018-08-16T12:36:38.180' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (367, 30, 8, CAST(N'2018-08-16T21:40:53.417' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (368, 31, 15, CAST(N'2018-08-18T11:32:13.983' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (369, 31, 10, CAST(N'2018-08-18T11:32:21.440' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (370, 31, 3, CAST(N'2018-08-18T11:32:27.837' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (371, 31, 10, CAST(N'2018-08-18T11:32:33.347' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (372, 30, 10, CAST(N'2018-08-18T11:42:35.700' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (373, 30, 3, CAST(N'2018-08-18T11:43:00.723' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (374, 30, 10, CAST(N'2018-08-18T11:43:03.880' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (375, 29, 10, CAST(N'2018-08-18T11:47:54.397' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (376, 29, 3, CAST(N'2018-08-18T12:50:07.210' AS DateTime), 2, 4, N'no')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (377, 32, 6, CAST(N'2018-08-21T04:54:11.693' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (378, 33, 8, CAST(N'2018-08-21T09:28:11.287' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (379, 33, 10, CAST(N'2018-08-21T09:29:45.010' AS DateTime), 1, 2, N'trả trước 25/08/2018 vì có công trình cần')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (380, 34, 8, CAST(N'2018-08-21T09:33:24.493' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (381, 32, 10, CAST(N'2018-08-21T09:40:53.427' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (382, 32, 3, CAST(N'2018-08-21T09:41:00.713' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (383, 35, 6, CAST(N'2018-08-21T09:47:48.083' AS DateTime), NULL, 1, N'')
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] ON 

INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1, N'Requested')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (2, N'Checked')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (3, N'Approved')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (4, N'Rejected')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (5, N'In Progress')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (6, N'Closed')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1009, N'Cancelled')
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[AccountNotification]  WITH CHECK ADD  CONSTRAINT [FK_AccountNotification_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountNotification] CHECK CONSTRAINT [FK_AccountNotification_Account]
GO
ALTER TABLE [dbo].[AccountNotification]  WITH CHECK ADD  CONSTRAINT [FK_AccountNotification_Notification] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notification] ([Id])
GO
ALTER TABLE [dbo].[AccountNotification] CHECK CONSTRAINT [FK_AccountNotification_Notification]
GO
ALTER TABLE [dbo].[Block]  WITH CHECK ADD  CONSTRAINT [FK_Block_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Block] CHECK CONSTRAINT [FK_Block_Location]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_EquipmentCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[EquipmentCategory] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_EquipmentCategory]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_MaintenanceDuration] FOREIGN KEY([MaintenanceDurationID])
REFERENCES [dbo].[MaintenanceDuration] ([Id])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_MaintenanceDuration]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Unit] FOREIGN KEY([UnitID])
REFERENCES [dbo].[Unit] ([Id])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_Unit]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Vendor] FOREIGN KEY([VendorID])
REFERENCES [dbo].[Vendor] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_Vendor]
GO
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_Equipment] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipment] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_Equipment]
GO
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_EquipmentStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[EquipmentStatus] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_EquipmentStatus]
GO
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_Location] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_Location]
GO
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_Tile] FOREIGN KEY([TileID])
REFERENCES [dbo].[Tile] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_Tile]
GO
ALTER TABLE [dbo].[EquipmentItemHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItemHistory_Account] FOREIGN KEY([ByUserID])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItemHistory] CHECK CONSTRAINT [FK_EquipmentItemHistory_Account]
GO
ALTER TABLE [dbo].[EquipmentItemHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItemHistory_EquipmentItem] FOREIGN KEY([EquipmentItemID])
REFERENCES [dbo].[EquipmentItem] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItemHistory] CHECK CONSTRAINT [FK_EquipmentItemHistory_EquipmentItem]
GO
ALTER TABLE [dbo].[EquipmentItemHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItemHistory_EquipmentStatus] FOREIGN KEY([OldStatusID])
REFERENCES [dbo].[EquipmentStatus] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItemHistory] CHECK CONSTRAINT [FK_EquipmentItemHistory_EquipmentStatus]
GO
ALTER TABLE [dbo].[EquipmentItemHistory]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItemHistory_EquipmentStatus1] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[EquipmentStatus] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItemHistory] CHECK CONSTRAINT [FK_EquipmentItemHistory_EquipmentStatus1]
GO
ALTER TABLE [dbo].[Floor]  WITH CHECK ADD  CONSTRAINT [FK_Floor_Block] FOREIGN KEY([BlockID])
REFERENCES [dbo].[Block] ([Id])
GO
ALTER TABLE [dbo].[Floor] CHECK CONSTRAINT [FK_Floor_Block]
GO
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_Account]
GO
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_Team]
GO
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_TeamRoles] FOREIGN KEY([TeamRoleID])
REFERENCES [dbo].[TeamRoles] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_TeamRoles]
GO
ALTER TABLE [dbo].[TeamLocation]  WITH CHECK ADD  CONSTRAINT [FK_TeamLocation_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[TeamLocation] CHECK CONSTRAINT [FK_TeamLocation_Location]
GO
ALTER TABLE [dbo].[TeamLocation]  WITH CHECK ADD  CONSTRAINT [FK_TeamLocation_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[TeamLocation] CHECK CONSTRAINT [FK_TeamLocation_Team]
GO
ALTER TABLE [dbo].[Tile]  WITH CHECK ADD  CONSTRAINT [FK_Tile_Floor] FOREIGN KEY([FloorID])
REFERENCES [dbo].[Floor] ([Id])
GO
ALTER TABLE [dbo].[Tile] CHECK CONSTRAINT [FK_Tile_Floor]
GO
ALTER TABLE [dbo].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_Account] FOREIGN KEY([RequestUserID])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_Account]
GO
ALTER TABLE [dbo].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_Priority] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[Priority] ([Id])
GO
ALTER TABLE [dbo].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_Priority]
GO
ALTER TABLE [dbo].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_TeamLocation] FOREIGN KEY([TeamLocationID])
REFERENCES [dbo].[TeamLocation] ([Id])
GO
ALTER TABLE [dbo].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_TeamLocation]
GO
ALTER TABLE [dbo].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_WorkOrderCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[WorkOrderCategory] ([Id])
GO
ALTER TABLE [dbo].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_WorkOrderCategory]
GO
ALTER TABLE [dbo].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_WorkOrderStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[WorkOrderStatus] ([Id])
GO
ALTER TABLE [dbo].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_WorkOrderStatus]
GO
ALTER TABLE [dbo].[WorkOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetail_EquipmentItem] FOREIGN KEY([EquipmentItemID])
REFERENCES [dbo].[EquipmentItem] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetail] CHECK CONSTRAINT [FK_WorkOrderDetail_EquipmentItem]
GO
ALTER TABLE [dbo].[WorkOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetail_WorkOrder] FOREIGN KEY([WorkOrderID])
REFERENCES [dbo].[WorkOrder] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetail] CHECK CONSTRAINT [FK_WorkOrderDetail_WorkOrder]
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailReturn_Account] FOREIGN KEY([ByUserID])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn] CHECK CONSTRAINT [FK_WorkOrderDetailReturn_Account]
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailReturn_EquipmentStatus] FOREIGN KEY([ReturnedStatusID])
REFERENCES [dbo].[EquipmentStatus] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn] CHECK CONSTRAINT [FK_WorkOrderDetailReturn_EquipmentStatus]
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailReturn_WorkOrderDetail] FOREIGN KEY([WorkOrderDetailID])
REFERENCES [dbo].[WorkOrderDetail] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailReturn] CHECK CONSTRAINT [FK_WorkOrderDetailReturn_WorkOrderDetail]
GO
ALTER TABLE [dbo].[WorkOrderRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRecord_Account] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Account] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkOrderRecord] CHECK CONSTRAINT [FK_WorkOrderRecord_Account]
GO
ALTER TABLE [dbo].[WorkOrderRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRecord_WorkOrder] FOREIGN KEY([WorkOrderID])
REFERENCES [dbo].[WorkOrder] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderRecord] CHECK CONSTRAINT [FK_WorkOrderRecord_WorkOrder]
GO
ALTER TABLE [dbo].[WorkOrderRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRecord_WorkOrderStatus] FOREIGN KEY([OldStatusID])
REFERENCES [dbo].[WorkOrderStatus] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderRecord] CHECK CONSTRAINT [FK_WorkOrderRecord_WorkOrderStatus]
GO
ALTER TABLE [dbo].[WorkOrderRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRecord_WorkOrderStatus1] FOREIGN KEY([NewStatusID])
REFERENCES [dbo].[WorkOrderStatus] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderRecord] CHECK CONSTRAINT [FK_WorkOrderRecord_WorkOrderStatus1]
GO
USE [master]
GO
ALTER DATABASE [EquipmentManageSystem] SET  READ_WRITE 
GO
