/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4224)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [EquipmentManageSystem]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[AccountNotification]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 5/11/2018 10:30:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[VendorID] [int] NULL,
	[Image] [nvarchar](max) NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Floor]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[MaintenanceDuration]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Tile]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[VendorType]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 5/11/2018 10:30:00 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 5/11/2018 10:30:00 PM ******/
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

INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (2, N'admin', N'123456', N'admin@ems.com', N'Nguyễn Huy Hung', N'0983234919', 1, CAST(N'2018-06-03T14:20:49.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', N'manager@ems.com', N'Trần Minh Hưng', N'0941239761', 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'TienNT', N'123456', N'tiennt@ems.com', N'Nguyễn Thanh Tiến', N'0971298366', 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'KhanhPM', N'123456', N'khanhpm@ems.com', N'Phạm Minh Khánh', N'0981123123', 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'teamleader2', N'123456', N'teamleader2@gmail.com', N'Nguyễn Minh Hải', N'0927234925', 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', N'vietnq@ems.com', N'Trần Quốc Việt', N'0961212636', 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'teamleader', N'123456', N'nhatchau.bq249@gmail.com', N'Bùi Quang Nhật Châu', N'0982712366', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', N'hautt@ems.com', N'Trịnh Thanh Hậu', N'0927234923', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534476847/lake_motosu_and_mount_fuji-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'estaff', N'123456', N'estaff@ems.com', N'Nguyễn Huy Hoàng', N'0927234924', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534442948/mount_fuji_landscapes-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'maintainer', N'123456', N'chaubqnse61740@fpt.edu.vn', N'Nguyễn Nhật Duy', N'0912383766', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (16, N'admin2', N'123456', N'admin2@ems.com', N'Ngô Bảo Châu', N'0981283838', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (17, N'ThanhMN', N'123456', N'thanhnm@gmail.com', N'Nguyễn Minh Thành', N'0912387691', 1, CAST(N'2018-05-04T13:44:42.643' AS DateTime), NULL, 3, N'https://i.stack.imgur.com/l60Hf.png')
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[AccountNotification] ON 

INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (1, 5, 1, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (2, 10, 1, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (3, 3, 2, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (4, 3, 3, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (5, 8, 4, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (6, 8, 5, 0)
SET IDENTITY_INSERT [dbo].[AccountNotification] OFF
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (1, N'A', 1, N'', 7, 2)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (2, N'B', 1, N'', 7, 2)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (3, N'Innovation', 2, N'', 6, 1)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (4, N'1', 3, NULL, 1, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (5, N'A', 4, N'', 10, 2)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (6, N'A', 5, N'', 2, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (7, N'B', 5, N'', 1, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [TotalFloor], [TotalBasementFloor]) VALUES (8, N'A', 6, N'', 1, 0)
SET IDENTITY_INSERT [dbo].[Block] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', N'Japan', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', N'China', NULL, 1, 3, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/may-khoan-rut-loi-ken-6200n-400x400.jpg', N'Hàn Quốc', NULL, 1, 2, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', N'Puma', NULL, 1, 4, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (14, N'Máy đầm cóc chạy điện HCD100 (3KW) 380V', 1, N'http://dailymayxaydung.com/wp-content/uploads/2017/09/dam_coc_hcd100.jpg', N'China', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (15, N'Búa hơi đục bê tông G10', 3, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg', N'China', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (18, N'Máy khoan bàn 600mm hồng ký KD600', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may-khoan-ban-hong-ky-hk-kd600.gif', N'VietNam', NULL, 1, 2, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (19, N'Máy trộn bê tông cam 250L', 1, N'http://dienmaysaoviet.vn//app/webroot/upload/image/images/M%C3%A1y%20tr%E1%BB%99n%20b%C3%AA%20t%C3%B4ng%20250L.jpg', N'VietNam', NULL, 1, 1, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (1028, N'Máy hàn que Maxi 300', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_han_que_maxi_300.jpg', N'China', NULL, 1, 3, 2, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID], [Status]) VALUES (1031, N'Máy tiện ren ống Lushun Zit-N50 (21-60mm)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may-tien-ren-ong-lushun-zit-r2.jpg', N'China', NULL, 1, 2, 2, 1)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentCategory] ON 

INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (1, N'Máy xây dựng', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (2, N'Máy cơ khí', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (3, N'Máy hàn', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (4, N'Máy nén khí', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (5, N'Máy bơm', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (6, N'Dụng cụ đo', NULL, 1)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description], [Status]) VALUES (7, N'Dụng cụ điện', NULL, 1)
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (1, 15, N'0010015947234', 5, 12, 0, 261, 15000000, CAST(N'2018-05-03T14:52:19.243' AS DateTime), CAST(N'2018-05-03T14:52:19.243' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (2, 15, N'0010015164343', 5, 12, 0, 261, 15000000, CAST(N'2018-05-03T14:52:19.250' AS DateTime), CAST(N'2018-05-03T14:52:19.250' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (3, 15, N'0010015989027', 5, 12, 0, 261, 15000000, CAST(N'2018-05-03T14:52:19.247' AS DateTime), CAST(N'2018-05-03T14:52:19.247' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (4, 15, N'0010015956707', 6, 12, 0, 311, 15000000, CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-10-30T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (5, 15, N'0010015136979', 6, 12, 0, 311, 15000000, CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-10-30T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (6, 14, N'0010014965600', 5, 12, 0, 261, 8900000, CAST(N'2018-05-09T14:59:22.840' AS DateTime), CAST(N'2018-05-09T14:59:22.840' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (7, 14, N'0010014485108', 5, 12, 0, 261, 8900000, CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (8, 14, N'0010014846055', 5, 12, 0, 261, 8900000, CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (9, 14, N'0010014951707', 5, 12, 0, 261, 8900000, CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (10, 14, N'0010014778920', 5, 12, 0, 261, 8900000, CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (11, 14, N'0010014315977', 6, 12, 0, 311, 9000000, CAST(N'2018-05-09T15:02:32.940' AS DateTime), CAST(N'2018-05-09T15:02:32.940' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (12, 14, N'0010014749577', 6, 12, 0, 311, 9000000, CAST(N'2018-05-09T15:02:32.960' AS DateTime), CAST(N'2018-05-09T15:02:32.960' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (13, 14, N'0010014318596', 6, 12, 0, 311, 9000000, CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (14, 14, N'0010014488980', 6, 12, 0, 311, 9000000, CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (15, 1, N'0010001849433', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (16, 1, N'0010001685838', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (17, 1, N'0010001919207', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.507' AS DateTime), CAST(N'2018-05-09T15:04:39.507' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (18, 1, N'0010001152387', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (19, 1, N'0010001622069', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (20, 1, N'0010001930073', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.530' AS DateTime), CAST(N'2018-05-09T15:04:39.530' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (21, 1, N'0010001198732', 5, 12, 0, 261, 7600000, CAST(N'2018-05-09T15:04:39.540' AS DateTime), CAST(N'2018-05-09T15:04:39.540' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (22, 2, N'0030002536271', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 2, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (23, 2, N'0030002291528', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 2, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (24, 2, N'0030002726981', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:05:54.247' AS DateTime), CAST(N'2018-05-09T15:05:54.247' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 2, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (25, 2, N'0030002697333', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:05:54.250' AS DateTime), CAST(N'2018-05-09T15:05:54.250' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (26, 2, N'0030002742828', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:18:01.840' AS DateTime), CAST(N'2018-05-09T15:18:01.840' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (27, 2, N'0030002792194', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:18:01.873' AS DateTime), CAST(N'2018-05-09T15:18:01.873' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (28, 2, N'0030002143074', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:23:53.800' AS DateTime), CAST(N'2018-05-09T15:23:53.800' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (29, 2, N'0030002455015', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:23:53.820' AS DateTime), CAST(N'2018-05-09T15:23:53.820' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (30, 1028, N'0031028719207', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.267' AS DateTime), CAST(N'2018-05-09T15:25:00.267' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (31, 1028, N'0031028949758', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.290' AS DateTime), CAST(N'2018-05-09T15:25:00.290' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (32, 1028, N'0031028184365', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.317' AS DateTime), CAST(N'2018-05-09T15:25:00.317' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (33, 1028, N'0031028422311', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.340' AS DateTime), CAST(N'2018-05-09T15:25:00.340' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (34, 1028, N'0031028904752', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.360' AS DateTime), CAST(N'2018-05-09T15:25:00.360' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (35, 1028, N'0031028186898', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:00.383' AS DateTime), CAST(N'2018-05-09T15:25:00.383' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (36, 1028, N'0031028819629', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:26.097' AS DateTime), CAST(N'2018-05-09T15:25:26.097' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (37, 1028, N'0031028620040', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:26.120' AS DateTime), CAST(N'2018-05-09T15:25:26.120' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (38, 1028, N'0031028596440', 6, 12, 0, 311, 5500000, CAST(N'2018-05-09T15:25:26.143' AS DateTime), CAST(N'2018-05-09T15:25:26.143' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (39, 18, N'0020018718821', 5, 6, 0, 262, 1800000, CAST(N'2018-05-09T15:28:29.980' AS DateTime), CAST(N'2018-05-09T15:28:29.980' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (40, 18, N'0020018686023', 5, 6, 0, 262, 1800000, CAST(N'2018-05-09T15:28:30.007' AS DateTime), CAST(N'2018-05-09T15:28:30.007' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (41, 18, N'0020018180532', 6, 6, 0, 311, 1800000, CAST(N'2018-05-09T15:28:59.783' AS DateTime), CAST(N'2018-05-09T15:28:59.783' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (42, 18, N'0020018243384', 6, 6, 0, 311, 1800000, CAST(N'2018-05-09T15:28:59.803' AS DateTime), CAST(N'2018-05-09T15:28:59.803' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (43, 18, N'0020018755240', 6, 6, 0, 311, 1800000, CAST(N'2018-05-09T15:28:59.827' AS DateTime), CAST(N'2018-05-09T15:28:59.827' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (44, 3, N'0020003148645', 5, 12, 0, 241, 6800000, CAST(N'2018-05-09T15:29:55.617' AS DateTime), CAST(N'2018-05-09T15:29:55.617' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (45, 3, N'0020003326915', 5, 12, 0, 241, 6800000, CAST(N'2018-05-09T15:29:55.660' AS DateTime), CAST(N'2018-05-09T15:29:55.660' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (46, 3, N'0020003428531', 5, 12, 0, 241, 6800000, CAST(N'2018-05-09T15:29:55.693' AS DateTime), CAST(N'2018-05-09T15:29:55.693' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (47, 3, N'0020003198839', 5, 12, 0, 241, 6800000, CAST(N'2018-05-09T15:29:55.727' AS DateTime), CAST(N'2018-05-09T15:29:55.727' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (48, 3, N'0020003198073', 6, 12, 0, 311, 6800000, CAST(N'2018-05-09T15:30:43.627' AS DateTime), CAST(N'2018-05-09T15:30:43.627' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (49, 3, N'0020003445127', 6, 12, 0, 311, 6800000, CAST(N'2018-05-09T15:30:43.657' AS DateTime), CAST(N'2018-05-09T15:30:43.657' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (50, 3, N'0020003725876', 6, 12, 0, 311, 6800000, CAST(N'2018-05-09T15:30:43.697' AS DateTime), CAST(N'2018-05-09T15:30:43.697' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (51, 3, N'0020003607274', 6, 12, 0, 311, 6800000, CAST(N'2018-05-09T15:30:43.733' AS DateTime), CAST(N'2018-05-09T15:30:43.733' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (52, 4, N'0040004969336', 6, 1, 0, 312, 3000000, CAST(N'2018-05-09T15:35:00.040' AS DateTime), CAST(N'2018-05-09T15:35:00.040' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (53, 4, N'0040004813726', 6, 1, 0, 312, 3000000, CAST(N'2018-05-09T15:35:00.070' AS DateTime), CAST(N'2018-05-09T15:35:00.070' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (54, 4, N'0040004334277', 6, 1, 0, 312, 3000000, CAST(N'2018-05-09T15:35:00.103' AS DateTime), CAST(N'2018-05-09T15:35:00.103' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (55, 4, N'0040004754475', 6, 1, 0, 313, 4000000, CAST(N'2018-05-09T15:35:15.700' AS DateTime), CAST(N'2018-05-09T15:35:15.700' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (56, 1031, N'0021031747289', 5, 12, 0, 263, 7900000, CAST(N'2018-05-09T15:38:08.410' AS DateTime), CAST(N'2018-05-09T15:38:08.410' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (57, 1031, N'0021031271126', 5, 12, 0, 263, 7900000, CAST(N'2018-05-09T15:38:08.433' AS DateTime), CAST(N'2018-05-09T15:38:08.433' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (58, 1031, N'0021031685505', 5, 12, 0, 263, 7900000, CAST(N'2018-05-09T15:38:08.460' AS DateTime), CAST(N'2018-05-09T15:38:08.460' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (59, 1031, N'0021031280417', 6, 12, 0, 314, 7900000, CAST(N'2018-05-09T15:38:33.290' AS DateTime), CAST(N'2018-05-09T15:38:33.290' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (60, 1031, N'0021031976240', 6, 12, 0, 314, 7900000, CAST(N'2018-05-09T15:38:33.310' AS DateTime), CAST(N'2018-05-09T15:38:33.310' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (61, 1031, N'0021031689752', 6, 12, 0, 314, 7900000, CAST(N'2018-05-09T15:38:33.333' AS DateTime), CAST(N'2018-05-09T15:38:33.333' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (62, 19, N'0010019576375', 5, 6, 0, 281, 1500000, CAST(N'2018-05-09T15:40:24.850' AS DateTime), CAST(N'2018-05-09T15:40:24.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (63, 19, N'0010019267127', 5, 6, 0, 281, 1500000, CAST(N'2018-05-09T15:40:24.877' AS DateTime), CAST(N'2018-05-09T15:40:24.877' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (64, 19, N'0010019905919', 5, 6, 0, 281, 1500000, CAST(N'2018-05-09T15:40:24.900' AS DateTime), CAST(N'2018-05-09T15:40:24.900' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (65, 19, N'0010019887736', 5, 6, 0, 281, 1500000, CAST(N'2018-05-09T15:40:24.927' AS DateTime), CAST(N'2018-05-09T15:40:24.927' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (66, 19, N'0010019879303', 5, 6, 0, 281, 1500000, CAST(N'2018-05-09T15:40:24.950' AS DateTime), CAST(N'2018-05-09T15:40:24.950' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (67, 19, N'0010019768295', 6, 6, 0, 313, 1500000, CAST(N'2018-05-09T15:40:44.563' AS DateTime), CAST(N'2018-05-09T15:40:44.563' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (68, 19, N'0010019184170', 6, 6, 0, 313, 1500000, CAST(N'2018-05-09T15:40:44.597' AS DateTime), CAST(N'2018-05-09T15:40:44.597' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (69, 19, N'0010019933632', 6, 6, 0, 313, 1500000, CAST(N'2018-05-09T15:40:44.640' AS DateTime), CAST(N'2018-05-09T15:40:44.640' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (70, 19, N'0010019853823', 6, 6, 0, 313, 1500000, CAST(N'2018-05-09T15:40:44.670' AS DateTime), CAST(N'2018-05-09T15:40:44.670' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (71, 19, N'0010019555943', 6, 6, 0, 313, 1500000, CAST(N'2018-05-09T15:40:44.687' AS DateTime), CAST(N'2018-05-09T15:40:44.687' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItemHistory] ON 

INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (1, 22, 3, 1, 2, CAST(N'2018-05-11T15:59:54.207' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (2, 23, 3, 1, 2, CAST(N'2018-05-11T15:59:54.230' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (3, 24, 3, 1, 2, CAST(N'2018-05-11T15:59:54.260' AS DateTime), NULL)
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

INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (1, N'6', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (2, N'5', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (3, N'4', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (4, N'3', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (5, N'2', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (6, N'1', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (7, N'Ground', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (8, N'B1', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (9, N'B2', 1, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (10, N'6', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (11, N'5', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (12, N'4', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (13, N'3', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (14, N'2', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (15, N'1', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (16, N'Ground', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (17, N'B1', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (18, N'B2', 2, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (19, N'5', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (20, N'4', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (21, N'3', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (22, N'2', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (23, N'1', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (24, N'Ground', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (25, N'B1', 3, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (26, N'G', 4, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (27, N'10', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (28, N'9', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (29, N'8', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (30, N'7', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (31, N'6', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (32, N'5', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (33, N'4', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (34, N'3', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (35, N'2', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (36, N'1', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (37, N'B1', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (38, N'B2', 5, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (39, N'2', 6, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (40, N'1', 6, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (41, N'1', 7, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (42, N'1', 8, NULL)
SET IDENTITY_INSERT [dbo].[Floor] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (1, N'Chung cư 4S Linh Đông', N'20 Phạm Văn Đồng, Linh Đông, Thủ Đức, Hồ Chí Minh, Vietnam', N'', 106.74405300000001, 10.841594, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (2, N'Đại học FPT CVPMQT', N'Toà nhà Innovation, lô 24, Công viên phần mềm Quang Trung, Quận 12, Hồ Chí Minh, Vietnam', N'', 106.62954480000008, 10.8529391, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (3, N'Cầu vượt Nguyễn Thái Sơn', N'Hoàng Minh Giám, Phường 3, Gò Vấp, Gò Vấp Hồ Chí Minh, Vietnam', N'', 106.67858750000005, 10.8141763, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (4, N'Becamex Tower', N'Đại lộ Bình Dương, Phú Hoà, Thủ Dầu Một, Bình Dương, Vietnam', N'', 106.67026169999997, 10.9761955, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (5, N'Kho Nguyễn Ảnh Thủ', N'13 Nguyễn Ảnh Thủ, Hiệp Thành, Quận 12, Hồ Chí Minh, Vietnam', N'', 106.64749619999998, 10.876275, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [IsActive]) VALUES (6, N'Kho Nguyễn Hữu Cảnh', N'155 Nguyễn Hữu Cảnh, Phường 22, Bình Thạnh, Hồ Chí Minh, Vietnam', N'', 106.71908269999994, 10.7966338, 1)
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[MaintenanceDuration] ON 

INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (1, 3)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (2, 6)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (3, 9)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (4, 12)
INSERT [dbo].[MaintenanceDuration] ([Id], [Months]) VALUES (5, 24)
SET IDENTITY_INSERT [dbo].[MaintenanceDuration] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (1, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-27T15:50:11.390' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (2, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-27T15:50:11.437' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (3, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T15:59:27.960' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (4, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T15:59:28.010' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (5, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T15:59:54.297' AS DateTime), N'{"page":"work_order","elementId":1}')
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Priority] ON 

INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (1, N'Low', N'#00c853')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (2, N'Medium', N'#fbc02d')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (3, N'High', N'#ef5350')
SET IDENTITY_INSERT [dbo].[Priority] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Equipment Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (5, N'Maintainer')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (1, N'Đội thi công số 1', CAST(N'2018-05-04T13:46:04.010' AS DateTime), 1)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (2, N'Đội thi công số 2', CAST(N'2018-05-04T13:49:28.180' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 17, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 1, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 2, 6, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 2, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 2, 9, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[TeamLocation] ON 

INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (1, 1, 1, CAST(N'2018-08-27T14:08:18.053' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[TeamLocation] OFF
SET IDENTITY_INSERT [dbo].[TeamRoles] ON 

INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (1, N'Leader')
INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[TeamRoles] OFF
SET IDENTITY_INSERT [dbo].[Tile] ON 

INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (1, N'601', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (2, N'602', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (3, N'603', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (4, N'604', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (5, N'605', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (6, N'606', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (7, N'607', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (8, N'608', 1, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (9, N'501', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (10, N'502', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (11, N'503', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (12, N'504', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (13, N'505', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (14, N'506', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (15, N'507', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (16, N'508', 2, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (17, N'401', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (18, N'402', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (19, N'403', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (20, N'404', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (21, N'405', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (22, N'406', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (23, N'407', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (24, N'408', 3, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (25, N'301', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (26, N'302', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (27, N'303', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (28, N'304', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (29, N'305', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (30, N'306', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (31, N'307', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (32, N'308', 4, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (33, N'201', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (34, N'202', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (35, N'203', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (36, N'204', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (37, N'205', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (38, N'206', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (39, N'207', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (40, N'208', 5, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (41, N'101', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (42, N'102', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (43, N'103', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (44, N'104', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (45, N'105', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (46, N'106', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (47, N'107', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (48, N'108', 6, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (49, N'1', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (50, N'2', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (51, N'3', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (52, N'4', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (53, N'5', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (54, N'6', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (55, N'7', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (56, N'8', 7, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (57, N'1', 8, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (58, N'1', 9, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (59, N'601', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (60, N'602', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (61, N'603', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (62, N'604', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (63, N'605', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (64, N'606', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (65, N'607', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (66, N'608', 10, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (67, N'501', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (68, N'502', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (69, N'503', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (70, N'504', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (71, N'505', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (72, N'506', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (73, N'507', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (74, N'508', 11, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (75, N'401', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (76, N'402', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (77, N'403', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (78, N'404', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (79, N'405', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (80, N'406', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (81, N'407', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (82, N'408', 12, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (83, N'301', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (84, N'302', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (85, N'303', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (86, N'304', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (87, N'305', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (88, N'306', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (89, N'307', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (90, N'308', 13, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (91, N'201', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (92, N'202', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (93, N'203', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (94, N'204', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (95, N'205', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (96, N'206', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (97, N'207', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (98, N'208', 14, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (99, N'101', 15, NULL)
GO
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (100, N'102', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (101, N'103', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (102, N'104', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (103, N'105', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (104, N'106', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (105, N'107', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (106, N'108', 15, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (107, N'1', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (108, N'2', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (109, N'3', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (110, N'4', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (111, N'5', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (112, N'6', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (113, N'7', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (114, N'8', 16, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (115, N'1', 17, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (116, N'1', 18, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (117, N'501', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (118, N'502', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (119, N'503', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (120, N'504', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (121, N'505', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (122, N'506', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (123, N'507', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (124, N'508', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (125, N'509', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (126, N'510', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (127, N'511', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (128, N'512', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (129, N'513', 19, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (130, N'401', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (131, N'402', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (132, N'403', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (133, N'404', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (134, N'405', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (135, N'406', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (136, N'407', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (137, N'408', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (138, N'409', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (139, N'410', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (140, N'411', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (141, N'412', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (142, N'413', 20, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (143, N'301', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (144, N'302', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (145, N'303', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (146, N'304', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (147, N'305', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (148, N'306', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (149, N'307', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (150, N'308', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (151, N'309', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (152, N'310', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (153, N'311', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (154, N'312', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (155, N'313', 21, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (156, N'201', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (157, N'202', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (158, N'203', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (159, N'204', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (160, N'205', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (161, N'206', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (162, N'207', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (163, N'208', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (164, N'209', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (165, N'210', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (166, N'211', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (167, N'212', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (168, N'213', 22, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (169, N'Library', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (170, N'Medic', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (171, N'103', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (172, N'104', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (173, N'105', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (174, N'106', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (175, N'107', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (176, N'108', 23, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (177, N'1', 24, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (178, N'2', 24, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (179, N'3', 24, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (180, N'4', 24, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (181, N'5', 24, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (182, N'1', 25, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (183, N'1', 26, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (184, N'1001', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (185, N'1002', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (186, N'1003', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (187, N'1004', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (188, N'1005', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (189, N'1006', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (190, N'1007', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (191, N'1008', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (192, N'1009', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (193, N'1010', 27, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (194, N'901', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (195, N'902', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (196, N'903', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (197, N'904', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (198, N'905', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (199, N'906', 28, NULL)
GO
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (200, N'907', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (201, N'908', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (202, N'909', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (203, N'910', 28, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (204, N'801', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (205, N'802', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (206, N'803', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (207, N'804', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (208, N'805', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (209, N'806', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (210, N'807', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (211, N'808', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (212, N'809', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (213, N'810', 29, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (214, N'701', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (215, N'702', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (216, N'703', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (217, N'704', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (218, N'705', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (219, N'706', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (220, N'707', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (221, N'708', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (222, N'709', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (223, N'710', 30, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (224, N'601', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (225, N'602', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (226, N'603', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (227, N'604', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (228, N'605', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (229, N'606', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (230, N'607', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (231, N'608', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (232, N'609', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (233, N'610', 31, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (234, N'501', 32, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (235, N'401', 33, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (236, N'301', 34, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (237, N'201', 35, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (238, N'101', 36, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (239, N'1', 37, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (240, N'1', 38, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (241, N'1', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (242, N'2', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (243, N'3', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (244, N'4', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (245, N'5', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (246, N'6', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (247, N'7', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (248, N'8', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (249, N'9', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (250, N'10', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (251, N'11', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (252, N'12', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (253, N'13', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (254, N'14', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (255, N'15', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (256, N'16', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (257, N'17', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (258, N'18', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (259, N'19', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (260, N'20', 39, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (261, N'1', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (262, N'2', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (263, N'3', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (264, N'4', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (265, N'5', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (266, N'6', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (267, N'7', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (268, N'8', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (269, N'9', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (270, N'10', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (271, N'11', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (272, N'12', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (273, N'13', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (274, N'14', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (275, N'15', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (276, N'16', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (277, N'17', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (278, N'18', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (279, N'19', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (280, N'20', 40, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (281, N'1', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (282, N'2', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (283, N'3', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (284, N'4', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (285, N'5', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (286, N'6', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (287, N'7', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (288, N'8', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (289, N'9', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (290, N'10', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (291, N'11', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (292, N'12', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (293, N'13', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (294, N'14', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (295, N'15', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (296, N'16', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (297, N'17', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (298, N'18', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (299, N'19', 41, NULL)
GO
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (300, N'20', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (301, N'21', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (302, N'22', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (303, N'23', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (304, N'24', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (305, N'25', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (306, N'26', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (307, N'27', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (308, N'28', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (309, N'29', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (310, N'30', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (311, N'1', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (312, N'2', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (313, N'3', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (314, N'4', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (315, N'5', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (316, N'6', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (317, N'7', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (318, N'8', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (319, N'9', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (320, N'10', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (321, N'11', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (322, N'12', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (323, N'13', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (324, N'14', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (325, N'15', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (326, N'16', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (327, N'17', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (328, N'18', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (329, N'19', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (330, N'20', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (331, N'21', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (332, N'22', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (333, N'23', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (334, N'24', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (335, N'25', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (336, N'26', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (337, N'27', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (338, N'28', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (339, N'29', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (340, N'30', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (341, N'31', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (342, N'32', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (343, N'33', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (344, N'34', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (345, N'35', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (346, N'36', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (347, N'37', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (348, N'38', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (349, N'39', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (350, N'40', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (351, N'41', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (352, N'42', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (353, N'43', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (354, N'44', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (355, N'45', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (356, N'46', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (357, N'47', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (358, N'48', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (359, N'49', 42, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (360, N'50', 42, NULL)
SET IDENTITY_INSERT [dbo].[Tile] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([Id], [Name]) VALUES (1, N'máy')
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (2, N'xe')
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (3, N'chiếc')
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nội', N'thienlongcorp.vn', N'Trần Trọng Trung', N'dailymayxaydung@gmail.com', NULL, 1, N'0912312734')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (2, N'Công ty TNHH  FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'thietbixaydungfintec.vn', N'Nguyễn Thanh Long', N'thietbivanphong@gmail.com', NULL, 1, N'0921789231')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (3, N'Công ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', NULL, 1, N'0976873611')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', NULL, 1, N'0976323612')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (6, N'Công ty TNHH Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Lê Kim Thanh ', N'truonglongoto@gmail.com', NULL, 1, N'0921782351')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (7, N'Công ty TNHH Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', NULL, 1, N'0912316735')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description], [Status], [Phone]) VALUES (8, N'Công Ty Cổ Phần Máy Công Trình Phúc Long', N'Số 420, QL 1A, KP 2, Tam Bình, Thủ Đức, TP. HCM', N'http://phuclong.com/', N'Đăng Bình Minh', N'info@phuclong.com@gmail.com', NULL, 1, N'0976213213')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[WorkOrder] ON 

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (1, N'Mượn máy hàn que', 8, CAST(N'2018-05-11T15:50:11.280' AS DateTime), CAST(N'2018-05-11T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), NULL, NULL, 2, 3, 2, 1, N'')
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (1, 22, 1, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (2, 23, 1, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (3, 24, 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] ON 

INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (1, 1, 8, CAST(N'2018-05-11T00:00:00.000' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (2, 1, 10, CAST(N'2018-05-11T15:59:27.913' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (3, 1, 3, CAST(N'2018-05-11T15:59:54.163' AS DateTime), 2, 3, NULL)
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
