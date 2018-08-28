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
/****** Object:  Database [EquipmentManageSystem]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[AccountNotification]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Floor]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[MaintenanceDuration]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Tile]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[VendorType]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 8/29/2018 2:27:06 AM ******/
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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 8/29/2018 2:27:06 AM ******/
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
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (2, 10, 1, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (3, 3, 2, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (4, 3, 3, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (5, 8, 4, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (6, 8, 5, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (7, 5, 6, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (8, 10, 6, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (9, 3, 7, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (10, 5, 8, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (11, 10, 8, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (12, 3, 9, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (13, 5, 10, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (14, 10, 10, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (15, 3, 11, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (16, 3, 12, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (17, 8, 13, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (18, 3, 14, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (19, 8, 15, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (20, 3, 16, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (21, 8, 17, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (22, 8, 18, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (23, 8, 19, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (24, 8, 20, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (25, 8, 21, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (26, 8, 22, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (27, 8, 23, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (28, 8, 24, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (29, 5, 25, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (30, 10, 25, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (31, 3, 26, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (32, 3, 27, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (33, 8, 28, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (34, 8, 29, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (35, 8, 30, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (43, 5, 37, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (44, 10, 37, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (45, 3, 38, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (46, 3, 39, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (47, 6, 40, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (48, 6, 41, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (49, 6, 42, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (50, 5, 43, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (51, 10, 43, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (52, 3, 44, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (53, 3, 45, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (54, 6, 46, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (55, 6, 47, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (56, 6, 48, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (57, 5, 49, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (58, 10, 49, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (59, 3, 50, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (60, 3, 51, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (61, 6, 52, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (62, 6, 53, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (63, 6, 54, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (64, 5, 55, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (65, 10, 55, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (66, 3, 56, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (67, 3, 57, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (68, 6, 58, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (69, 6, 59, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (70, 6, 60, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (71, 5, 61, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (72, 10, 61, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (73, 3, 62, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (74, 3, 63, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (75, 8, 64, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (76, 8, 65, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (77, 8, 66, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (78, 5, 67, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (79, 10, 67, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (80, 3, 68, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (81, 3, 69, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (82, 6, 70, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (83, 6, 71, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (84, 6, 72, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (85, 5, 73, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (86, 10, 73, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (87, 3, 74, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (88, 3, 75, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (89, 6, 76, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (90, 6, 77, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (91, 6, 78, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (92, 5, 79, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (93, 10, 79, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (94, 3, 80, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (95, 5, 81, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (96, 10, 81, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (97, 3, 82, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (98, 5, 83, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (99, 10, 83, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (100, 3, 84, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (101, 5, 85, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (102, 10, 85, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (103, 3, 86, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (104, 5, 87, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (105, 10, 87, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (106, 3, 88, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (107, 3, 89, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (108, 6, 90, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (109, 6, 91, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (110, 6, 92, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (111, 3, 93, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (112, 8, 94, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (113, 8, 95, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (114, 8, 96, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (115, 3, 97, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (116, 8, 98, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (117, 8, 99, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (118, 8, 100, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (119, 3, 101, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (120, 6, 102, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (121, 6, 103, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (122, 6, 104, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (123, 3, 105, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (124, 6, 106, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (125, 6, 107, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (126, 6, 108, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (127, 5, 109, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (128, 10, 109, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (129, 3, 110, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (130, 5, 111, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (131, 10, 111, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (132, 3, 112, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (133, 5, 113, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (134, 10, 113, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (135, 3, 114, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (136, 5, 115, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (137, 10, 115, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (138, 3, 116, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (139, 5, 117, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (140, 10, 117, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (141, 3, 118, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (142, 3, 119, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (143, 6, 120, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (144, 6, 121, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (145, 6, 122, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (146, 3, 123, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (147, 8, 124, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (148, 3, 125, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (149, 8, 126, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (150, 8, 127, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (151, 8, 128, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (152, 8, 129, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (153, 8, 130, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (154, 3, 131, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (155, 6, 132, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (156, 3, 133, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (157, 8, 134, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (158, 8, 135, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (159, 6, 136, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (160, 8, 137, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (161, 6, 138, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (162, 5, 139, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (163, 10, 139, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (164, 3, 140, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (165, 5, 141, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (166, 10, 141, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (167, 3, 142, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (168, 5, 143, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (169, 10, 143, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (170, 3, 144, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (171, 5, 145, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (172, 10, 145, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (173, 3, 146, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (174, 3, 147, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (175, 8, 148, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (176, 3, 149, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (177, 8, 150, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (178, 3, 151, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (179, 6, 152, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (180, 3, 153, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (181, 6, 154, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (182, 8, 155, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (183, 8, 156, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (184, 6, 157, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (185, 6, 158, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (186, 6, 159, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (187, 8, 160, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (188, 8, 161, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (189, 6, 162, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (190, 5, 163, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (191, 10, 163, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (192, 3, 164, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (193, 5, 165, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (194, 10, 165, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (195, 3, 166, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (196, 5, 167, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (197, 10, 167, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (198, 3, 168, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (199, 5, 169, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (200, 10, 169, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (201, 3, 170, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (202, 3, 171, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (203, 8, 172, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (204, 3, 173, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (205, 8, 174, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (206, 3, 175, 1)
GO
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (207, 6, 176, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (208, 8, 177, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (209, 8, 178, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (210, 8, 179, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (211, 5, 180, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (212, 10, 180, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (213, 3, 181, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (214, 3, 182, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (215, 15, 183, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (216, 15, 184, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (217, 5, 185, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (218, 10, 185, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (219, 3, 186, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (220, 3, 187, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (221, 15, 188, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (222, 15, 189, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (223, 5, 190, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (224, 10, 190, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (225, 3, 191, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (226, 3, 192, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (227, 15, 193, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (228, 15, 194, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (229, 5, 195, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (230, 10, 195, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (231, 3, 196, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (232, 5, 197, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (233, 10, 197, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (234, 3, 198, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (235, 3, 199, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (236, 8, 200, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (237, 8, 201, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (238, 8, 202, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (239, 5, 203, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (240, 10, 203, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (241, 3, 204, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (242, 5, 205, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (243, 10, 205, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (244, 3, 206, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (245, 3, 207, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (246, 6, 208, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (247, 6, 209, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (248, 6, 210, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (249, 5, 211, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (250, 10, 211, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (251, 3, 212, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (252, 3, 213, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (253, 15, 214, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (254, 15, 215, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (255, 5, 216, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (256, 10, 216, 0)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (257, 3, 217, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (258, 3, 218, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (259, 6, 219, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (260, 6, 220, 1)
INSERT [dbo].[AccountNotification] ([Id], [AccountId], [NotificationId], [NotificationStatus]) VALUES (261, 6, 221, 1)
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

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (1, 15, N'0010015947234', 5, 12, 22, 261, 15000000, CAST(N'2018-05-03T14:52:19.243' AS DateTime), CAST(N'2018-05-03T14:52:19.243' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (2, 15, N'0010015164343', 5, 12, 22, 261, 15000000, CAST(N'2018-05-03T14:52:19.250' AS DateTime), CAST(N'2018-05-03T14:52:19.250' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (3, 15, N'0010015989027', 5, 12, 22, 261, 15000000, CAST(N'2018-05-03T14:52:19.247' AS DateTime), CAST(N'2018-05-03T14:52:19.247' AS DateTime), CAST(N'2019-02-23T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (4, 15, N'0010015956707', 6, 12, 48, 379, 15000000, CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-10-30T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (5, 15, N'0010015136979', 6, 12, 48, 379, 15000000, CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-05-03T14:53:01.697' AS DateTime), CAST(N'2018-10-30T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (6, 14, N'0010014965600', 5, 12, 66, 261, 8900000, CAST(N'2018-05-09T14:59:22.840' AS DateTime), CAST(N'2018-05-09T14:59:22.840' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (7, 14, N'0010014485108', 5, 12, 30, 261, 8900000, CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (8, 14, N'0010014846055', 5, 12, 30, 261, 8900000, CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-05-09T14:59:22.847' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (9, 14, N'0010014951707', 5, 12, 36, 261, 8900000, CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (10, 14, N'0010014778920', 5, 12, 36, 261, 8900000, CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-05-09T14:59:22.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (11, 14, N'0010014315977', 6, 12, 20, 238, 9000000, CAST(N'2018-05-09T15:02:32.940' AS DateTime), CAST(N'2018-05-09T15:02:32.940' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (12, 14, N'0010014749577', 6, 12, 20, 238, 9000000, CAST(N'2018-05-09T15:02:32.960' AS DateTime), CAST(N'2018-05-09T15:02:32.960' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (13, 14, N'0010014318596', 6, 12, 20, 261, 9000000, CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (14, 14, N'0010014488980', 6, 12, 20, 261, 9000000, CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-05-09T15:02:32.990' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (15, 1, N'0010001849433', 5, 12, 50, 261, 7600000, CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (16, 1, N'0010001685838', 5, 12, 50, 261, 7600000, CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-05-09T15:04:39.503' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (17, 1, N'0010001919207', 5, 12, 50, 261, 7600000, CAST(N'2018-05-09T15:04:39.507' AS DateTime), CAST(N'2018-05-09T15:04:39.507' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (18, 1, N'0010001152387', 5, 12, 32, 261, 7600000, CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (19, 1, N'0010001622069', 5, 12, 32, 261, 7600000, CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-05-09T15:04:39.527' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (20, 1, N'0010001930073', 5, 12, 32, 261, 7600000, CAST(N'2018-05-09T15:04:39.530' AS DateTime), CAST(N'2018-05-09T15:04:39.530' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (21, 1, N'0010001198732', 5, 12, 32, 261, 7600000, CAST(N'2018-05-09T15:04:39.540' AS DateTime), CAST(N'2018-05-09T15:04:39.540' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (22, 2, N'0030002536271', 5, 12, 32, 261, 3500000, CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-07-14T10:18:40.270' AS DateTime), CAST(N'2019-01-14T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (23, 2, N'0030002291528', 5, 12, 32, 261, 3500000, CAST(N'2018-05-09T15:05:54.243' AS DateTime), CAST(N'2018-07-14T10:18:40.387' AS DateTime), CAST(N'2019-01-14T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (24, 2, N'0030002726981', 5, 12, 32, 261, 3500000, CAST(N'2018-05-09T15:05:54.247' AS DateTime), CAST(N'2018-07-14T10:18:40.490' AS DateTime), CAST(N'2019-01-14T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (25, 2, N'0030002697333', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:05:54.250' AS DateTime), CAST(N'2018-05-09T15:05:54.250' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (26, 2, N'0030002742828', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:18:01.840' AS DateTime), CAST(N'2018-05-09T15:18:01.840' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (27, 2, N'0030002792194', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:18:01.873' AS DateTime), CAST(N'2018-05-09T15:18:01.873' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (28, 2, N'0030002143074', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:23:53.800' AS DateTime), CAST(N'2018-05-09T15:23:53.800' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (29, 2, N'0030002455015', 5, 12, 0, 261, 3500000, CAST(N'2018-05-09T15:23:53.820' AS DateTime), CAST(N'2018-05-09T15:23:53.820' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (30, 1028, N'0031028719207', 6, 12, 42, 261, 5500000, CAST(N'2018-05-09T15:25:00.267' AS DateTime), CAST(N'2018-05-09T15:25:00.267' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (31, 1028, N'0031028949758', 6, 12, 42, 261, 5500000, CAST(N'2018-05-09T15:25:00.290' AS DateTime), CAST(N'2018-05-09T15:25:00.290' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 4, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (32, 1028, N'0031028184365', 6, 12, 42, 261, 5500000, CAST(N'2018-05-09T15:25:00.317' AS DateTime), CAST(N'2018-05-09T15:25:00.317' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (33, 1028, N'0031028422311', 6, 12, 42, 261, 5500000, CAST(N'2018-05-09T15:25:00.340' AS DateTime), CAST(N'2018-05-09T15:25:00.340' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (34, 1028, N'0031028904752', 6, 12, 32, 261, 5500000, CAST(N'2018-05-09T15:25:00.360' AS DateTime), CAST(N'2018-05-09T15:25:00.360' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (35, 1028, N'0031028186898', 6, 12, 32, 261, 5500000, CAST(N'2018-05-09T15:25:00.383' AS DateTime), CAST(N'2018-05-09T15:25:00.383' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 4, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (36, 1028, N'0031028819629', 6, 12, 32, 261, 5500000, CAST(N'2018-05-09T15:25:26.097' AS DateTime), CAST(N'2018-05-09T15:25:26.097' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (37, 1028, N'0031028620040', 6, 12, 32, 261, 5500000, CAST(N'2018-05-09T15:25:26.120' AS DateTime), CAST(N'2018-05-09T15:25:26.120' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (38, 1028, N'0031028596440', 6, 12, 0, 261, 5500000, CAST(N'2018-05-09T15:25:26.143' AS DateTime), CAST(N'2018-05-09T15:25:26.143' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 7, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (39, 18, N'0020018718821', 5, 6, 28, 261, 1800000, CAST(N'2018-05-09T15:28:29.980' AS DateTime), CAST(N'2018-05-09T15:28:29.980' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (40, 18, N'0020018686023', 5, 6, 28, 261, 1800000, CAST(N'2018-05-09T15:28:30.007' AS DateTime), CAST(N'2018-05-09T15:28:30.007' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (41, 18, N'0020018180532', 6, 6, 58, 261, 1800000, CAST(N'2018-05-09T15:28:59.783' AS DateTime), CAST(N'2018-07-16T10:20:47.180' AS DateTime), CAST(N'2019-01-15T00:00:00.000' AS DateTime), 6, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (42, 18, N'0020018243384', 6, 6, 57, 261, 1800000, CAST(N'2018-05-09T15:28:59.803' AS DateTime), CAST(N'2018-07-16T10:20:47.257' AS DateTime), CAST(N'2019-01-15T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (43, 18, N'0020018755240', 6, 6, 57, 261, 1800000, CAST(N'2018-05-09T15:28:59.827' AS DateTime), CAST(N'2018-07-16T10:20:47.327' AS DateTime), CAST(N'2019-01-15T00:00:00.000' AS DateTime), 3, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (44, 3, N'0020003148645', 5, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:29:55.617' AS DateTime), CAST(N'2018-05-09T15:29:55.617' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (45, 3, N'0020003326915', 5, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:29:55.660' AS DateTime), CAST(N'2018-05-09T15:29:55.660' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (46, 3, N'0020003428531', 5, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:29:55.693' AS DateTime), CAST(N'2018-05-09T15:29:55.693' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (47, 3, N'0020003198839', 5, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:29:55.727' AS DateTime), CAST(N'2018-05-09T15:29:55.727' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (48, 3, N'0020003198073', 6, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:30:43.627' AS DateTime), CAST(N'2018-05-09T15:30:43.627' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (49, 3, N'0020003445127', 6, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:30:43.657' AS DateTime), CAST(N'2018-05-09T15:30:43.657' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (50, 3, N'0020003725876', 6, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:30:43.697' AS DateTime), CAST(N'2018-05-09T15:30:43.697' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (51, 3, N'0020003607274', 6, 12, 0, 261, 6800000, CAST(N'2018-05-09T15:30:43.733' AS DateTime), CAST(N'2018-05-09T15:30:43.733' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (52, 4, N'0040004969336', 6, 1, 56, 261, 3000000, CAST(N'2018-05-09T15:35:00.040' AS DateTime), CAST(N'2018-05-09T15:35:00.040' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (53, 4, N'0040004813726', 6, 1, 56, 261, 3000000, CAST(N'2018-05-09T15:35:00.070' AS DateTime), CAST(N'2018-05-09T15:35:00.070' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (54, 4, N'0040004334277', 6, 1, 14, 261, 3000000, CAST(N'2018-05-09T15:35:00.103' AS DateTime), CAST(N'2018-05-09T15:35:00.103' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (55, 4, N'0040004754475', 6, 1, 14, 261, 4000000, CAST(N'2018-05-09T15:35:15.700' AS DateTime), CAST(N'2018-05-09T15:35:15.700' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (56, 1031, N'0021031747289', 5, 12, 42, 261, 7900000, CAST(N'2018-05-09T15:38:08.410' AS DateTime), CAST(N'2018-05-09T15:38:08.410' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (57, 1031, N'0021031271126', 5, 12, 42, 261, 7900000, CAST(N'2018-05-09T15:38:08.433' AS DateTime), CAST(N'2018-05-09T15:38:08.433' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (58, 1031, N'0021031685505', 5, 12, 42, 261, 7900000, CAST(N'2018-05-09T15:38:08.460' AS DateTime), CAST(N'2018-05-09T15:38:08.460' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (59, 1031, N'0021031280417', 6, 12, 20, 261, 7900000, CAST(N'2018-05-09T15:38:33.290' AS DateTime), CAST(N'2018-05-09T15:38:33.290' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (60, 1031, N'0021031976240', 6, 12, 20, 261, 7900000, CAST(N'2018-05-09T15:38:33.310' AS DateTime), CAST(N'2018-05-09T15:38:33.310' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (61, 1031, N'0021031689752', 6, 12, 20, 261, 7900000, CAST(N'2018-05-09T15:38:33.333' AS DateTime), CAST(N'2018-05-09T15:38:33.333' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (62, 19, N'0010019576375', 5, 6, 54, 261, 1500000, CAST(N'2018-05-09T15:40:24.850' AS DateTime), CAST(N'2018-05-09T15:40:24.850' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (63, 19, N'0010019267127', 5, 6, 54, 261, 1500000, CAST(N'2018-05-09T15:40:24.877' AS DateTime), CAST(N'2018-05-09T15:40:24.877' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (64, 19, N'0010019905919', 5, 6, 54, 261, 1500000, CAST(N'2018-05-09T15:40:24.900' AS DateTime), CAST(N'2018-05-09T15:40:24.900' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (65, 19, N'0010019887736', 5, 6, 54, 261, 1500000, CAST(N'2018-05-09T15:40:24.927' AS DateTime), CAST(N'2018-05-09T15:40:24.927' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (66, 19, N'0010019879303', 5, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:24.950' AS DateTime), CAST(N'2018-05-09T15:40:24.950' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (67, 19, N'0010019768295', 6, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:44.563' AS DateTime), CAST(N'2018-05-09T15:40:44.563' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (68, 19, N'0010019184170', 6, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:44.597' AS DateTime), CAST(N'2018-05-09T15:40:44.597' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (69, 19, N'0010019933632', 6, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:44.640' AS DateTime), CAST(N'2018-05-09T15:40:44.640' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 7, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (70, 19, N'0010019853823', 6, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:44.670' AS DateTime), CAST(N'2018-05-09T15:40:44.670' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (71, 19, N'0010019555943', 6, 6, 0, 261, 1500000, CAST(N'2018-05-09T15:40:44.687' AS DateTime), CAST(N'2018-05-09T15:40:44.687' AS DateTime), CAST(N'2018-11-05T00:00:00.000' AS DateTime), 1, N'No description')
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItemHistory] ON 

INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (1, 22, 3, 1, 2, CAST(N'2018-05-11T17:20:54.163' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (2, 23, 3, 1, 2, CAST(N'2018-05-11T17:20:54.163' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (3, 24, 3, 1, 2, CAST(N'2018-05-11T17:20:54.163' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (4, 11, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (5, 12, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (6, 13, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (7, 67, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (8, 68, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (9, 69, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (10, 52, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (11, 53, 3, 1, 2, CAST(N'2018-05-20T01:26:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (12, 5, 3, 1, 2, CAST(N'2018-05-20T10:00:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (13, 25, 3, 1, 2, CAST(N'2018-05-20T10:00:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (14, 26, 3, 1, 2, CAST(N'2018-05-20T10:00:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (15, 27, 3, 1, 2, CAST(N'2018-05-20T10:00:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (16, 44, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (17, 46, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (18, 45, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (19, 47, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (20, 1, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (21, 2, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (22, 3, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (23, 4, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (24, 62, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (25, 63, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (26, 64, 3, 1, 2, CAST(N'2018-05-13T09:02:05.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (27, 22, 10, 2, 3, CAST(N'2018-05-12T07:30:11.280' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (28, 23, 10, 2, 3, CAST(N'2018-05-12T07:30:11.280' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (29, 24, 10, 2, 3, CAST(N'2018-05-12T07:30:11.280' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (30, 22, 10, 3, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (31, 23, 10, 3, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (32, 24, 10, 3, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (33, 44, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (34, 46, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (35, 45, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (36, 47, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (37, 1, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (38, 2, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (39, 3, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (40, 4, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (41, 62, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (42, 63, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (43, 64, 10, 2, 3, CAST(N'2018-05-13T09:05:31.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (44, 44, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (45, 4, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (46, 45, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (47, 46, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (48, 47, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (49, 1, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (50, 2, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (51, 3, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (52, 62, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (53, 63, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (54, 64, 10, 3, 1, CAST(N'2018-05-28T10:39:42.640' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (55, 5, 10, 2, 3, CAST(N'2018-05-20T11:54:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (56, 25, 10, 2, 3, CAST(N'2018-05-20T11:54:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (57, 26, 10, 2, 3, CAST(N'2018-05-20T11:54:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (58, 27, 10, 2, 3, CAST(N'2018-05-20T11:54:02.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (59, 5, 10, 3, 1, CAST(N'2018-05-26T10:40:37.977' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (60, 25, 10, 3, 1, CAST(N'2018-05-26T10:40:37.977' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (61, 26, 10, 3, 1, CAST(N'2018-05-26T10:40:37.977' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (62, 27, 10, 3, 1, CAST(N'2018-05-26T10:40:37.977' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (63, 11, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (64, 12, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (65, 13, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (66, 67, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (67, 68, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (68, 69, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (69, 52, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (70, 53, 10, 2, 3, CAST(N'2018-05-20T01:46:57.673' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (71, 52, 10, 3, 1, CAST(N'2018-05-20T01:46:57.673' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (72, 53, 10, 3, 1, CAST(N'2018-05-20T01:46:57.673' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (73, 11, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (74, 12, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (75, 13, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (76, 67, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (77, 68, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (78, 69, 10, 3, 1, CAST(N'2018-05-28T10:41:05.660' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (79, 4, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (80, 5, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (81, 15, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (82, 16, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (83, 17, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (84, 22, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (85, 23, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (86, 24, 3, 1, 2, CAST(N'2018-05-03T11:21:15.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (87, 4, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (88, 5, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (89, 15, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (90, 16, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (91, 17, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (92, 22, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (93, 23, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (94, 24, 10, 2, 3, CAST(N'2018-05-03T14:01:18.153' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (95, 15, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (96, 16, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (97, 17, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (98, 22, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (99, 23, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
GO
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (100, 24, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (101, 4, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (102, 5, 10, 3, 1, CAST(N'2018-05-27T17:05:11.107' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (118, 30, 3, 1, 2, CAST(N'2018-05-22T08:04:41.417' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (119, 31, 3, 1, 2, CAST(N'2018-05-22T08:04:41.460' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (120, 32, 3, 1, 2, CAST(N'2018-05-22T08:04:41.493' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (121, 33, 3, 1, 2, CAST(N'2018-05-22T08:04:41.537' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (122, 30, 10, 2, 3, CAST(N'2018-05-22T08:04:48.043' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (123, 31, 10, 2, 3, CAST(N'2018-05-22T08:04:48.080' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (124, 32, 10, 2, 3, CAST(N'2018-05-22T08:04:48.127' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (125, 33, 10, 2, 3, CAST(N'2018-05-22T08:04:48.163' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (126, 30, 10, 3, 1, CAST(N'2018-05-22T08:04:56.797' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (127, 31, 10, 3, 1, CAST(N'2018-05-22T08:04:56.973' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (128, 32, 10, 3, 1, CAST(N'2018-05-22T08:04:57.087' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (129, 33, 10, 3, 1, CAST(N'2018-05-22T08:04:57.160' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (130, 62, 3, 1, 2, CAST(N'2018-05-22T08:08:16.250' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (131, 63, 3, 1, 2, CAST(N'2018-05-22T08:08:16.283' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (132, 64, 3, 1, 2, CAST(N'2018-05-22T08:08:16.310' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (133, 65, 3, 1, 2, CAST(N'2018-05-22T08:08:16.343' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (134, 66, 3, 1, 2, CAST(N'2018-05-22T08:08:16.387' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (135, 62, 10, 2, 3, CAST(N'2018-05-22T08:08:20.670' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (136, 63, 10, 2, 3, CAST(N'2018-05-22T08:08:20.707' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (137, 64, 10, 2, 3, CAST(N'2018-05-22T08:08:20.740' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (138, 65, 10, 2, 3, CAST(N'2018-05-22T08:08:20.777' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (139, 66, 10, 2, 3, CAST(N'2018-05-22T08:08:20.820' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (140, 62, 10, 3, 1, CAST(N'2018-05-22T08:08:36.230' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (141, 63, 10, 3, 1, CAST(N'2018-05-22T08:08:36.323' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (142, 64, 10, 3, 1, CAST(N'2018-05-22T08:08:36.407' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (143, 65, 10, 3, 1, CAST(N'2018-05-22T08:08:36.517' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (144, 66, 10, 3, 1, CAST(N'2018-05-22T08:08:36.607' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (145, 1, 3, 1, 2, CAST(N'2018-05-18T08:11:48.007' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (146, 2, 3, 1, 2, CAST(N'2018-05-18T08:11:48.043' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (147, 3, 3, 1, 2, CAST(N'2018-05-18T08:11:48.080' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (148, 1, 10, 2, 3, CAST(N'2018-05-18T08:11:50.873' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (149, 2, 10, 2, 3, CAST(N'2018-05-18T08:11:50.910' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (150, 3, 10, 2, 3, CAST(N'2018-05-18T08:11:50.963' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (151, 1, 10, 3, 1, CAST(N'2018-05-29T08:12:14.837' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (152, 2, 10, 3, 1, CAST(N'2018-05-29T08:12:14.947' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (153, 3, 10, 3, 1, CAST(N'2018-05-29T08:12:15.047' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (154, 6, 3, 1, 2, CAST(N'2018-05-10T09:13:37.853' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (155, 7, 3, 1, 2, CAST(N'2018-05-10T09:13:37.890' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (156, 8, 3, 1, 2, CAST(N'2018-05-10T09:13:37.930' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (157, 6, 10, 2, 3, CAST(N'2018-05-10T09:13:41.783' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (158, 7, 10, 2, 3, CAST(N'2018-05-10T09:13:41.817' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (159, 8, 10, 2, 3, CAST(N'2018-05-10T09:13:41.857' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (160, 6, 10, 3, 1, CAST(N'2018-05-25T15:14:03.030' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (161, 7, 10, 3, 1, CAST(N'2018-05-25T15:14:03.150' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (162, 8, 10, 3, 1, CAST(N'2018-05-25T15:14:03.253' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (163, 41, 3, 1, 2, CAST(N'2018-06-10T10:11:13.687' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (164, 42, 3, 1, 2, CAST(N'2018-05-25T08:28:53.100' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (165, 43, 3, 1, 2, CAST(N'2018-05-25T08:28:53.137' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (166, 41, 10, 2, 3, CAST(N'2018-06-11T10:11:13.687' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (167, 42, 10, 2, 3, CAST(N'2018-05-25T08:28:55.307' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (168, 43, 10, 2, 3, CAST(N'2018-05-25T08:28:55.340' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (169, 41, 10, 3, 1, CAST(N'2018-06-22T10:11:13.687' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (170, 42, 10, 3, 1, CAST(N'2018-06-22T18:29:08.443' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (171, 43, 10, 3, 1, CAST(N'2018-06-22T18:29:08.543' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (172, 4, 3, 1, 2, CAST(N'2018-05-25T09:33:48.463' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (173, 5, 3, 1, 2, CAST(N'2018-05-25T09:33:48.527' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (174, 4, 10, 2, 3, CAST(N'2018-05-25T09:33:56.157' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (175, 5, 10, 2, 3, CAST(N'2018-05-25T09:33:56.217' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (176, 4, 10, 3, 1, CAST(N'2018-06-18T09:34:11.587' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (177, 5, 10, 3, 1, CAST(N'2018-06-18T09:34:11.773' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (178, 44, 3, 1, 2, CAST(N'2018-06-04T11:56:42.030' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (179, 45, 3, 1, 2, CAST(N'2018-06-04T11:56:42.057' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (180, 46, 3, 1, 2, CAST(N'2018-06-04T11:56:42.087' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (181, 47, 3, 1, 2, CAST(N'2018-06-04T11:56:42.117' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (182, 44, 10, 2, 3, CAST(N'2018-06-04T11:56:45.190' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (183, 45, 10, 2, 3, CAST(N'2018-06-04T11:56:45.223' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (184, 46, 10, 2, 3, CAST(N'2018-06-04T11:56:45.253' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (185, 47, 10, 2, 3, CAST(N'2018-06-04T11:56:45.280' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (186, 44, 10, 3, 1, CAST(N'2018-06-04T11:56:53.933' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (187, 45, 10, 3, 1, CAST(N'2018-06-04T11:56:54.057' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (188, 46, 10, 3, 1, CAST(N'2018-06-04T11:56:54.153' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (189, 47, 10, 3, 1, CAST(N'2018-06-04T11:56:54.230' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (190, 56, 3, 1, 2, CAST(N'2018-06-29T09:07:58.350' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (191, 57, 3, 1, 2, CAST(N'2018-06-29T09:07:58.393' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (192, 58, 3, 1, 2, CAST(N'2018-06-29T09:07:58.430' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (193, 56, 10, 2, 3, CAST(N'2018-06-29T09:08:02.160' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (194, 57, 10, 2, 3, CAST(N'2018-06-29T09:08:02.200' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (195, 58, 10, 2, 3, CAST(N'2018-06-29T09:08:02.233' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (196, 56, 10, 3, 1, CAST(N'2018-07-20T09:14:15.597' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (197, 57, 10, 3, 1, CAST(N'2018-07-20T09:14:15.733' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (198, 58, 10, 3, 1, CAST(N'2018-07-20T09:14:15.847' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (199, 22, 3, 1, 2, CAST(N'2018-06-20T09:13:34.973' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (200, 24, 3, 1, 2, CAST(N'2018-06-20T09:13:35.017' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (201, 23, 3, 1, 2, CAST(N'2018-06-20T09:13:35.053' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (202, 22, 10, 2, 3, CAST(N'2018-06-20T09:13:39.780' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (203, 24, 10, 2, 3, CAST(N'2018-06-20T09:13:39.820' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (204, 23, 10, 2, 3, CAST(N'2018-06-20T09:13:39.860' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (205, 22, 10, 3, 1, CAST(N'2018-07-06T09:13:51.950' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (206, 24, 10, 3, 1, CAST(N'2018-07-06T09:13:52.093' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (207, 23, 10, 3, 1, CAST(N'2018-07-06T09:13:52.197' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (208, 52, 3, 1, 2, CAST(N'2018-06-22T09:14:40.847' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (209, 53, 3, 1, 2, CAST(N'2018-06-22T09:14:40.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (210, 54, 3, 1, 2, CAST(N'2018-06-22T09:14:40.917' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (211, 55, 3, 1, 2, CAST(N'2018-06-22T09:14:40.950' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (212, 52, 10, 2, 3, CAST(N'2018-06-22T09:15:03.683' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (213, 53, 10, 2, 3, CAST(N'2018-06-22T09:15:03.720' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (214, 54, 10, 2, 3, CAST(N'2018-06-22T09:15:03.757' AS DateTime), NULL)
GO
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (215, 55, 10, 2, 3, CAST(N'2018-06-22T09:15:03.807' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (216, 52, 10, 3, 1, CAST(N'2018-06-29T09:15:17.680' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (217, 53, 10, 3, 1, CAST(N'2018-06-29T09:15:17.830' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (218, 54, 10, 3, 1, CAST(N'2018-06-29T09:15:17.980' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (219, 55, 10, 3, 1, CAST(N'2018-06-29T09:15:18.150' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (220, 30, 3, 1, 2, CAST(N'2018-06-29T09:15:50.320' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (221, 31, 3, 1, 2, CAST(N'2018-06-29T09:15:50.357' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (222, 32, 3, 1, 2, CAST(N'2018-06-29T09:15:50.397' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (223, 33, 3, 1, 2, CAST(N'2018-06-29T09:15:50.433' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (224, 30, 10, 2, 3, CAST(N'2018-06-29T09:15:53.063' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (225, 31, 10, 2, 3, CAST(N'2018-06-29T09:15:53.100' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (226, 32, 10, 2, 3, CAST(N'2018-06-29T09:15:53.137' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (227, 33, 10, 2, 3, CAST(N'2018-06-29T09:15:53.170' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (228, 30, 10, 3, 1, CAST(N'2018-07-20T09:16:06.570' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (229, 31, 10, 3, 1, CAST(N'2018-07-20T09:16:06.693' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (230, 32, 10, 3, 1, CAST(N'2018-07-20T09:16:06.800' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (231, 33, 10, 3, 1, CAST(N'2018-07-20T09:16:06.917' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (232, 62, 3, 1, 2, CAST(N'2018-06-29T09:16:21.910' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (233, 63, 3, 1, 2, CAST(N'2018-06-29T09:16:21.947' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (234, 64, 3, 1, 2, CAST(N'2018-06-29T09:16:21.983' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (235, 65, 3, 1, 2, CAST(N'2018-06-29T09:16:22.060' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (236, 62, 10, 2, 3, CAST(N'2018-06-29T09:16:26.337' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (237, 63, 10, 2, 3, CAST(N'2018-06-29T09:16:26.373' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (238, 64, 10, 2, 3, CAST(N'2018-06-29T09:16:26.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (239, 65, 10, 2, 3, CAST(N'2018-06-29T09:16:26.440' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (240, 62, 10, 3, 1, CAST(N'2018-07-26T09:16:37.710' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (241, 63, 10, 3, 1, CAST(N'2018-07-26T09:16:37.840' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (242, 64, 10, 3, 1, CAST(N'2018-07-26T09:16:37.947' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (243, 65, 10, 3, 1, CAST(N'2018-07-26T09:16:38.063' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (244, 9, 3, 1, 2, CAST(N'2018-07-09T09:25:58.377' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (245, 10, 3, 1, 2, CAST(N'2018-07-09T09:25:58.420' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (246, 6, 3, 1, 2, CAST(N'2018-07-09T09:25:58.467' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (247, 9, 10, 2, 3, CAST(N'2018-07-09T09:26:04.260' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (248, 10, 10, 2, 3, CAST(N'2018-07-09T09:26:04.293' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (249, 6, 10, 2, 3, CAST(N'2018-07-09T09:26:04.327' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (250, 9, 10, 3, 1, CAST(N'2018-07-27T09:26:16.297' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (251, 10, 10, 3, 1, CAST(N'2018-07-27T09:26:16.427' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (252, 6, 10, 3, 1, CAST(N'2018-07-27T09:26:16.553' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (253, 59, 3, 1, 2, CAST(N'2018-07-02T09:27:25.110' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (254, 60, 3, 1, 2, CAST(N'2018-07-02T09:27:25.170' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (255, 61, 3, 1, 2, CAST(N'2018-07-02T09:27:25.247' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (256, 11, 3, 1, 2, CAST(N'2018-07-02T09:27:34.950' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (257, 12, 3, 1, 2, CAST(N'2018-07-02T09:27:34.987' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (258, 13, 3, 1, 2, CAST(N'2018-07-02T09:27:35.020' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (259, 14, 3, 1, 2, CAST(N'2018-07-02T09:27:35.060' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (260, 11, 10, 2, 3, CAST(N'2018-07-02T09:27:45.547' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (261, 12, 10, 2, 3, CAST(N'2018-07-02T09:27:45.580' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (262, 13, 10, 2, 3, CAST(N'2018-07-02T09:27:45.613' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (263, 14, 10, 2, 3, CAST(N'2018-07-02T09:27:45.650' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (264, 59, 10, 2, 3, CAST(N'2018-07-02T09:27:50.167' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (265, 60, 10, 2, 3, CAST(N'2018-07-02T09:27:50.203' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (266, 61, 10, 2, 3, CAST(N'2018-07-02T09:27:50.237' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (267, 59, 10, 3, 1, CAST(N'2018-07-12T09:28:01.663' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (268, 60, 10, 3, 1, CAST(N'2018-07-12T09:28:01.813' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (269, 61, 10, 3, 1, CAST(N'2018-07-12T09:28:01.927' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (270, 11, 10, 3, 1, CAST(N'2018-07-12T09:28:17.773' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (271, 12, 10, 3, 1, CAST(N'2018-07-12T09:28:17.897' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (272, 13, 10, 3, 1, CAST(N'2018-07-12T09:28:18.010' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (273, 14, 10, 3, 1, CAST(N'2018-07-12T09:28:18.120' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (274, 15, 3, 1, 2, CAST(N'2018-07-04T09:28:46.587' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (275, 16, 3, 1, 2, CAST(N'2018-07-04T09:28:46.620' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (276, 17, 3, 1, 2, CAST(N'2018-07-04T09:28:46.657' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (277, 18, 3, 1, 2, CAST(N'2018-07-04T09:28:56.267' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (278, 19, 3, 1, 2, CAST(N'2018-07-04T09:28:56.303' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (279, 20, 3, 1, 2, CAST(N'2018-07-04T09:28:56.343' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (280, 21, 3, 1, 2, CAST(N'2018-07-04T09:28:56.380' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (281, 15, 10, 2, 3, CAST(N'2018-07-04T09:29:01.870' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (282, 16, 10, 2, 3, CAST(N'2018-07-04T09:29:01.907' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (283, 17, 10, 2, 3, CAST(N'2018-07-04T09:29:01.940' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (284, 18, 10, 2, 3, CAST(N'2018-07-04T09:29:06.700' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (285, 19, 10, 2, 3, CAST(N'2018-07-04T09:29:06.740' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (286, 20, 10, 2, 3, CAST(N'2018-07-04T09:29:06.773' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (287, 21, 10, 2, 3, CAST(N'2018-07-04T09:29:06.807' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (288, 18, 10, 3, 1, CAST(N'2018-07-20T09:29:23.970' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (289, 19, 10, 3, 1, CAST(N'2018-07-20T09:29:24.100' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (290, 20, 10, 3, 1, CAST(N'2018-07-20T09:29:24.227' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (291, 21, 10, 3, 1, CAST(N'2018-07-20T09:29:24.333' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (292, 15, 10, 3, 1, CAST(N'2018-07-20T09:29:41.187' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (293, 16, 10, 3, 1, CAST(N'2018-07-20T09:29:41.320' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (294, 17, 10, 3, 1, CAST(N'2018-07-20T09:29:41.440' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (295, 34, 3, 1, 2, CAST(N'2018-08-01T09:40:38.000' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (296, 35, 3, 1, 2, CAST(N'2018-08-01T09:40:38.037' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (297, 36, 3, 1, 2, CAST(N'2018-08-01T09:40:38.070' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (298, 37, 3, 1, 2, CAST(N'2018-08-01T09:40:38.103' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (299, 15, 3, 1, 2, CAST(N'2018-08-01T09:40:55.820' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (300, 16, 3, 1, 2, CAST(N'2018-08-01T09:40:55.853' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (301, 17, 3, 1, 2, CAST(N'2018-08-01T09:40:55.887' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (302, 39, 3, 1, 2, CAST(N'2018-08-01T09:41:09.893' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (303, 40, 3, 1, 2, CAST(N'2018-08-01T09:41:09.930' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (304, 52, 3, 1, 2, CAST(N'2018-08-01T09:41:34.900' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (305, 53, 3, 1, 2, CAST(N'2018-08-01T09:41:34.937' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (306, 52, 10, 2, 3, CAST(N'2018-08-01T09:41:55.277' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (307, 53, 10, 2, 3, CAST(N'2018-08-01T09:41:55.310' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (308, 34, 10, 2, 3, CAST(N'2018-08-01T09:42:06.813' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (309, 35, 10, 2, 3, CAST(N'2018-08-01T09:42:06.847' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (310, 36, 10, 2, 3, CAST(N'2018-08-01T09:42:06.883' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (311, 37, 10, 2, 3, CAST(N'2018-08-01T09:42:06.913' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (312, 15, 10, 2, 3, CAST(N'2018-08-01T09:42:12.967' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (313, 16, 10, 2, 3, CAST(N'2018-08-01T09:42:13.003' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (314, 17, 10, 2, 3, CAST(N'2018-08-01T09:42:13.040' AS DateTime), NULL)
GO
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (315, 39, 10, 2, 3, CAST(N'2018-08-01T09:42:19.687' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (316, 40, 10, 2, 3, CAST(N'2018-08-01T09:42:19.723' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (317, 39, 10, 3, 1, CAST(N'2018-08-08T09:43:08.013' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (318, 40, 10, 3, 1, CAST(N'2018-08-08T09:43:08.143' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (319, 39, 10, 1, 1, CAST(N'2018-08-08T09:43:08.187' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (320, 40, 10, 1, 1, CAST(N'2018-08-08T09:43:08.357' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (321, 52, 10, 3, 1, CAST(N'2018-08-22T09:43:41.750' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (322, 53, 10, 3, 1, CAST(N'2018-08-22T09:43:41.870' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (323, 15, 10, 3, 1, CAST(N'2018-08-10T09:43:57.443' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (324, 16, 10, 3, 1, CAST(N'2018-08-10T09:43:57.577' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (325, 17, 10, 3, 1, CAST(N'2018-08-10T09:43:57.687' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (326, 34, 10, 3, 1, CAST(N'2018-08-17T09:44:20.567' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (327, 35, 10, 3, 1, CAST(N'2018-08-17T09:44:20.690' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (328, 36, 10, 3, 1, CAST(N'2018-08-17T09:44:20.803' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (329, 37, 10, 3, 1, CAST(N'2018-08-17T09:44:20.907' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (330, 11, 3, 1, 2, CAST(N'2018-08-18T09:52:14.843' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (331, 12, 3, 1, 2, CAST(N'2018-08-18T09:52:14.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (332, 11, 10, 2, 3, CAST(N'2018-08-18T10:04:02.177' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (333, 12, 10, 2, 3, CAST(N'2018-08-18T10:04:02.210' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (334, 41, 10, 1, 4, CAST(N'2018-06-23T10:11:13.687' AS DateTime), N'Dây điện bị chuột cắn')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (335, 41, 3, 4, 5, CAST(N'2018-06-24T10:13:46.883' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (336, 41, 10, 5, 6, CAST(N'2018-06-24T10:13:50.530' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (337, 41, 10, 6, 1, CAST(N'2018-06-25T10:14:30.740' AS DateTime), N'Đã thay dây mới')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (338, 22, 3, 1, 5, CAST(N'2018-07-14T10:17:37.407' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (339, 23, 3, 1, 5, CAST(N'2018-07-14T10:17:37.440' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (340, 24, 3, 1, 5, CAST(N'2018-07-14T10:17:37.480' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (341, 22, 10, 5, 6, CAST(N'2018-07-14T10:17:43.900' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (342, 23, 10, 5, 6, CAST(N'2018-07-14T10:17:43.937' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (343, 24, 10, 5, 6, CAST(N'2018-07-14T10:17:43.970' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (344, 22, 10, 6, 1, CAST(N'2018-07-14T10:18:40.223' AS DateTime), N'Đã thay tụ mới')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (345, 23, 10, 6, 1, CAST(N'2018-07-14T10:18:40.353' AS DateTime), N'Máy tốt, chỉ bị bụi vào, đã vệ sinh')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (346, 24, 10, 6, 1, CAST(N'2018-07-14T10:18:40.453' AS DateTime), N'Máy tốt, chỉ bị bụi vào, đã vệ sinh')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (347, 41, 3, 1, 5, CAST(N'2018-07-15T10:20:05.040' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (348, 42, 3, 1, 5, CAST(N'2018-07-15T10:20:05.077' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (349, 43, 3, 1, 5, CAST(N'2018-07-15T10:20:05.110' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (350, 41, 10, 5, 6, CAST(N'2018-07-15T10:20:12.230' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (351, 42, 10, 5, 6, CAST(N'2018-07-15T10:20:12.263' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (352, 43, 10, 5, 6, CAST(N'2018-07-15T10:20:12.297' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (353, 41, 10, 6, 1, CAST(N'2018-07-16T10:20:47.140' AS DateTime), N'Thay lưỡi cưa mới')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (354, 42, 10, 6, 1, CAST(N'2018-07-16T10:20:47.220' AS DateTime), N'Thay lưỡi cưa mới')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (355, 43, 10, 6, 1, CAST(N'2018-07-16T10:20:47.290' AS DateTime), N'Thay lưỡi cưa mới')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (356, 69, 10, 1, 7, CAST(N'2018-07-16T10:22:06.833' AS DateTime), N'Kiểm tra định kỳ phát hiện, đã báo cáo điều tra')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (357, 38, 10, 1, 7, CAST(N'2018-08-18T01:30:51.413' AS DateTime), N'Kiểm tra đầu giờ phát hiện mất, đã báo cáo kiểm tra')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (358, 31, 10, 1, 4, CAST(N'2018-08-18T01:44:09.463' AS DateTime), N'Dây điện bị chuột cắn')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (359, 35, 10, 1, 4, CAST(N'2018-08-18T01:44:33.200' AS DateTime), N'Dây điện bị chuột cắn')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (360, 28, 3, 1, 2, CAST(N'2018-08-18T01:46:49.103' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (361, 29, 3, 1, 2, CAST(N'2018-08-18T01:46:49.140' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (362, 28, 10, 2, 3, CAST(N'2018-08-18T01:46:53.767' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (363, 29, 10, 2, 3, CAST(N'2018-08-18T01:46:53.800' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (364, 42, 3, 1, 2, CAST(N'2018-08-18T01:52:22.257' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (365, 43, 3, 1, 2, CAST(N'2018-08-18T01:52:22.290' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (366, 42, 10, 2, 3, CAST(N'2018-08-18T01:52:27.437' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (367, 43, 10, 2, 3, CAST(N'2018-08-18T01:52:27.470' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (368, 41, 3, 1, 5, CAST(N'2018-08-18T01:53:51.980' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (369, 41, 10, 5, 6, CAST(N'2018-08-18T01:53:56.127' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (370, 18, 3, 1, 2, CAST(N'2018-08-16T10:09:18.430' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (371, 19, 3, 1, 2, CAST(N'2018-08-16T10:09:18.477' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (372, 18, 10, 2, 3, CAST(N'2018-08-16T10:09:26.040' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (373, 19, 10, 2, 3, CAST(N'2018-08-16T10:09:26.080' AS DateTime), NULL)
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

INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (1, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T15:50:11.280' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (2, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T15:50:11.280' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (3, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T16:59:27.913' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (4, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T16:59:27.913' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (5, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-05-11T17:20:54.163' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (6, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong>', CAST(N'2018-05-13T01:16:26.670' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (7, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong>', CAST(N'2018-05-13T01:16:26.670' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (8, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị Becamex Tower lần 2</strong>', CAST(N'2018-05-20T09:34:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (9, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị Becamex Tower lần 2</strong>', CAST(N'2018-05-20T09:34:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (10, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị thi công chung cư 4S</strong>', CAST(N'2018-05-20T10:36:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (11, N'<strong>teamleader</strong> created a work order <strong>Mượn thiết bị thi công chung cư 4S</strong>', CAST(N'2018-05-20T10:36:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (12, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn thiết bị thi công chung cư 4S</strong>', CAST(N'2018-05-20T11:03:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (13, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn thiết bị thi công chung cư 4S</strong>', CAST(N'2018-05-20T11:03:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (14, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn thiết bị Becamex Tower lần 2</strong>', CAST(N'2018-05-20T09:54:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (15, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn thiết bị Becamex Tower lần 2</strong>', CAST(N'2018-05-20T09:54:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (16, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong>', CAST(N'2018-05-13T08:56:26.670' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (17, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong>', CAST(N'2018-05-13T08:56:26.670' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (18, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn thiết bị thi công chung cư 4S</strong>', CAST(N'2018-05-20T01:26:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (19, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn thiết bị Becamex Tower lần 2</strong>', CAST(N'2018-05-20T10:00:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (20, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong>', CAST(N'2018-05-13T09:02:05.473' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (21, N'Your work order <strong>Mượn máy hàn que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-12T07:30:11.280' AS DateTime), N'{"page":"work_order","elementId":1}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (22, N'Your work order <strong>Mượn thiết bị cho công trình Becamex Tower</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-13T09:05:31.290' AS DateTime), N'{"page":"work_order","elementId":2}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (23, N'Your work order <strong>Mượn thiết bị Becamex Tower lần 2</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-20T11:54:02.417' AS DateTime), N'{"page":"work_order","elementId":3}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (24, N'Your work order <strong>Mượn thiết bị thi công chung cư 4S</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-20T01:46:57.673' AS DateTime), N'{"page":"work_order","elementId":4}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (25, N'<strong>teamleader</strong> created a work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong>', CAST(N'2018-05-02T08:58:11.107' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (26, N'<strong>teamleader</strong> created a work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong>', CAST(N'2018-05-02T08:58:11.107' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (27, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong>', CAST(N'2018-05-03T11:01:12.063' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (28, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong>', CAST(N'2018-05-03T11:01:12.063' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (29, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong>', CAST(N'2018-05-03T11:21:15.407' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (30, N'Your work order <strong>Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-03T14:01:18.153' AS DateTime), N'{"page":"work_order","elementId":5}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (37, N'<strong>teamleader2</strong> created a work order <strong>Mượn 4 máy hàn que Maxi</strong>', CAST(N'2018-05-22T08:00:57.420' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (38, N'<strong>teamleader2</strong> created a work order <strong>Mượn 4 máy hàn que Maxi</strong>', CAST(N'2018-05-22T08:00:57.420' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (39, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn 4 máy hàn que Maxi</strong>', CAST(N'2018-05-22T08:04:38.633' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (40, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn 4 máy hàn que Maxi</strong>', CAST(N'2018-05-22T08:04:38.747' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (41, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn 4 máy hàn que Maxi</strong>', CAST(N'2018-05-22T08:04:41.600' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (42, N'Your work order <strong>Mượn 4 máy hàn que Maxi</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-22T08:04:48.223' AS DateTime), N'{"page":"work_order","elementId":8}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (43, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-05-22T08:08:03.730' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (44, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-05-22T08:08:03.790' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (45, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-05-22T08:08:12.753' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (46, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-05-22T08:08:12.830' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (47, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-05-22T08:08:16.437' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (48, N'Your work order <strong>Mượn máy trộn bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-22T08:08:20.877' AS DateTime), N'{"page":"work_order","elementId":9}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (49, N'<strong>teamleader2</strong> created a work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-18T08:11:37.280' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (50, N'<strong>teamleader2</strong> created a work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-18T08:11:37.327' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (51, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-18T08:11:45.247' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (52, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-18T08:11:45.310' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (53, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-18T08:11:48.120' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (54, N'Your work order <strong>Mượn búa hơi</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-18T08:11:51.027' AS DateTime), N'{"page":"work_order","elementId":10}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (55, N'<strong>teamleader2</strong> created a work order <strong>Mượn 3 máy đầm cóc</strong>', CAST(N'2018-05-10T09:13:24.417' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (56, N'<strong>teamleader2</strong> created a work order <strong>Mượn 3 máy đầm cóc</strong>', CAST(N'2018-05-10T09:13:24.470' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (57, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn 3 máy đầm cóc</strong>', CAST(N'2018-05-10T09:13:35.007' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (58, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn 3 máy đầm cóc</strong>', CAST(N'2018-05-10T09:13:35.060' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (59, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn 3 máy đầm cóc</strong>', CAST(N'2018-05-10T09:13:37.980' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (60, N'Your work order <strong>Mượn 3 máy đầm cóc</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-10T09:13:41.910' AS DateTime), N'{"page":"work_order","elementId":11}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (61, N'<strong>teamleader</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-05-25T08:28:44.390' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (62, N'<strong>teamleader</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-05-25T08:28:44.447' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (63, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-05-25T08:28:48.987' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (64, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-05-25T08:28:49.033' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (65, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-05-25T08:28:53.183' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (66, N'Your work order <strong>Mượn máy khoan bàn</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-25T08:28:55.390' AS DateTime), N'{"page":"work_order","elementId":12}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (67, N'<strong>teamleader2</strong> created a work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-25T09:33:37.070' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (68, N'<strong>teamleader2</strong> created a work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-25T09:33:37.140' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (69, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-25T09:33:44.783' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (70, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-25T09:33:44.950' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (71, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn búa hơi</strong>', CAST(N'2018-05-25T09:33:48.610' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (72, N'Your work order <strong>Mượn búa hơi</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-05-25T09:33:56.287' AS DateTime), N'{"page":"work_order","elementId":13}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (73, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy rút lõi bê tông</strong>', CAST(N'2018-06-04T10:49:58.250' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (74, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy rút lõi bê tông</strong>', CAST(N'2018-06-04T10:49:58.250' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (75, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy rút lõi bê tông</strong>', CAST(N'2018-06-04T11:55:59.533' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (76, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy rút lõi bê tông</strong>', CAST(N'2018-06-04T11:55:59.607' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (77, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy rút lõi bê tông</strong>', CAST(N'2018-06-04T11:56:42.157' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (78, N'Your work order <strong>Mượn máy rút lõi bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-04T11:56:45.323' AS DateTime), N'{"page":"work_order","elementId":14}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (79, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-06-20T09:03:51.253' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (80, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-06-20T09:03:51.313' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (81, N'<strong>teamleader</strong> created a work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-06-20T09:04:39.013' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (82, N'<strong>teamleader</strong> created a work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-06-20T09:04:39.070' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (83, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy tiện</strong>', CAST(N'2018-06-20T09:05:36.527' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (84, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy tiện</strong>', CAST(N'2018-06-20T09:05:36.587' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (85, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy hàn</strong>', CAST(N'2018-06-20T09:06:23.030' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (86, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy hàn</strong>', CAST(N'2018-06-20T09:06:23.087' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (87, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-06-20T09:07:05.597' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (88, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-06-20T09:07:05.643' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (89, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy tiện</strong>', CAST(N'2018-06-29T09:07:51.363' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (90, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy tiện</strong>', CAST(N'2018-06-29T09:07:51.423' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (91, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy tiện</strong>', CAST(N'2018-06-29T09:07:58.473' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (92, N'Your work order <strong>Mượn máy tiện</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-29T09:08:02.270' AS DateTime), N'{"page":"work_order","elementId":17}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (93, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-06-20T09:13:31.407' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (94, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-06-20T09:13:31.487' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (95, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-06-20T09:13:35.090' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (96, N'Your work order <strong>Mượn máy hàn que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-20T09:13:39.900' AS DateTime), N'{"page":"work_order","elementId":15}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (97, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-06-22T09:14:36.277' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (98, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-06-22T09:14:36.343' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (99, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-06-22T09:14:40.990' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (100, N'Your work order <strong>Mượn máy nén khí</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-22T09:15:03.857' AS DateTime), N'{"page":"work_order","elementId":16}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (101, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn</strong>', CAST(N'2018-06-29T09:15:47.323' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (102, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn</strong>', CAST(N'2018-06-29T09:15:47.387' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (103, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn</strong>', CAST(N'2018-06-29T09:15:50.507' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (104, N'Your work order <strong>Mượn máy hàn</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-29T09:15:53.213' AS DateTime), N'{"page":"work_order","elementId":18}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (105, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-06-29T09:16:17.887' AS DateTime), N'{"page":"work_order","elementId":19}')
GO
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (106, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-06-29T09:16:17.950' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (107, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-06-29T09:16:22.107' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (108, N'Your work order <strong>Mượn máy trộn bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-06-29T09:16:26.480' AS DateTime), N'{"page":"work_order","elementId":19}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (109, N'<strong>teamleader</strong> created a work order <strong>Mượn máy tiện</strong>', CAST(N'2018-07-02T09:20:41.080' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (110, N'<strong>teamleader</strong> created a work order <strong>Mượn máy tiện</strong>', CAST(N'2018-07-02T09:20:41.133' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (111, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đầm</strong>', CAST(N'2018-07-02T09:21:34.720' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (112, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đầm</strong>', CAST(N'2018-07-02T09:21:34.770' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (113, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-02T09:22:19.660' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (114, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-02T09:22:19.723' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (115, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-02T09:23:36.457' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (116, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-02T09:23:36.507' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (117, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-07-02T09:24:24.983' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (118, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-07-02T09:24:25.040' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (119, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-07-09T09:25:52.290' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (120, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-07-09T09:25:52.337' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (121, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-07-09T09:25:58.507' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (122, N'Your work order <strong>Mượn máy đầm cóc</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-09T09:26:04.373' AS DateTime), N'{"page":"work_order","elementId":24}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (123, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy tiện</strong>', CAST(N'2018-07-02T09:26:35.797' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (124, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy tiện</strong>', CAST(N'2018-07-02T09:26:35.853' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (125, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đầm</strong>', CAST(N'2018-07-02T09:26:41.960' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (126, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đầm</strong>', CAST(N'2018-07-02T09:26:42.023' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (127, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy tiện</strong>', CAST(N'2018-07-02T09:27:25.330' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (128, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đầm</strong>', CAST(N'2018-07-02T09:27:35.097' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (129, N'Your work order <strong>Mượn máy đầm</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-02T09:27:45.697' AS DateTime), N'{"page":"work_order","elementId":21}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (130, N'Your work order <strong>Mượn máy tiện</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-02T09:27:50.280' AS DateTime), N'{"page":"work_order","elementId":20}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (131, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:36.757' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (132, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:36.807' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (133, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:40.707' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (134, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:40.770' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (135, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:46.697' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (136, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-07-04T09:28:56.413' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (137, N'Your work order <strong>Mượn máy đục bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-04T09:29:01.983' AS DateTime), N'{"page":"work_order","elementId":22}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (138, N'Your work order <strong>Mượn máy đục bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-07-04T09:29:06.843' AS DateTime), N'{"page":"work_order","elementId":23}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (139, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-01T09:36:23.983' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (140, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-01T09:36:24.047' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (141, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-01T09:37:06.163' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (142, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-01T09:37:06.217' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (143, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-01T09:37:57.280' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (144, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-01T09:37:57.337' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (145, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-08-01T09:39:31.753' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (146, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-08-01T09:39:31.813' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (147, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-01T09:40:08.693' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (148, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-01T09:40:08.750' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (149, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-01T09:40:17.323' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (150, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-01T09:40:17.380' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (151, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-01T09:40:23.237' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (152, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-01T09:40:23.317' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (153, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-08-01T09:40:31.657' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (154, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-08-01T09:40:31.697' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (155, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-01T09:40:38.140' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (156, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-01T09:40:55.930' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (157, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-01T09:41:09.977' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (158, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy nén khí</strong>', CAST(N'2018-08-01T09:41:34.973' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (159, N'Your work order <strong>Mượn máy nén khí</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-01T09:41:55.357' AS DateTime), N'{"page":"work_order","elementId":28}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (160, N'Your work order <strong>Mượn máy hàn que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-01T09:42:06.953' AS DateTime), N'{"page":"work_order","elementId":25}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (161, N'Your work order <strong>Mượn máy đục bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-01T09:42:13.080' AS DateTime), N'{"page":"work_order","elementId":26}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (162, N'Your work order <strong>Mượn máy khoan bàn</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-01T09:42:19.767' AS DateTime), N'{"page":"work_order","elementId":27}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (163, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-08-18T09:42:24.670' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (164, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-08-18T09:42:24.730' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (165, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-18T09:48:24.653' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (166, N'<strong>teamleader</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-18T09:48:24.703' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (167, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T09:49:59.430' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (168, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T09:49:59.490' AS DateTime), N'{"page":"work_order","elementId":31}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (169, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-08-18T09:50:42.060' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (170, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-08-18T09:50:42.113' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (171, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-08-18T09:51:13.293' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (172, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-08-18T09:51:13.340' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (173, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-18T09:51:20.737' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (174, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-18T09:51:20.800' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (175, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-08-18T09:52:04.650' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (176, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy trộn bê tông</strong>', CAST(N'2018-08-18T09:52:04.700' AS DateTime), N'{"page":"work_order","elementId":32}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (177, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đầm cóc</strong>', CAST(N'2018-08-18T09:52:14.920' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (178, N'Manager <strong>manager</strong> has <strong>rejected</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-18T09:54:11.570' AS DateTime), N'{"page":"work_order","elementId":30}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (179, N'Your work order <strong>Mượn máy đầm cóc</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-18T10:04:02.250' AS DateTime), N'{"page":"work_order","elementId":29}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (180, N'<strong>maintainer</strong> created a work order <strong>Sửa máy khoan bàn 0020018180532</strong>', CAST(N'2018-06-24T10:12:54.263' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (181, N'<strong>maintainer</strong> created a work order <strong>Sửa máy khoan bàn 0020018180532</strong>', CAST(N'2018-06-24T10:12:54.323' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (182, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Sửa máy khoan bàn 0020018180532</strong>', CAST(N'2018-06-24T10:13:20.840' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (183, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Sửa máy khoan bàn 0020018180532</strong>', CAST(N'2018-06-24T10:13:20.907' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (184, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Sửa máy khoan bàn 0020018180532</strong>', CAST(N'2018-06-24T10:13:46.940' AS DateTime), N'{"page":"work_order","elementId":33}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (185, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-14T10:17:21.690' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (186, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-14T10:17:21.747' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (187, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Bảo trì máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-14T10:17:32.457' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (188, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Bảo trì máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-14T10:17:32.507' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (189, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Bảo trì máy hàn que Jasic ARC 200</strong>', CAST(N'2018-07-14T10:17:37.533' AS DateTime), N'{"page":"work_order","elementId":34}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (190, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-07-14T10:19:51.880' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (191, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-07-14T10:19:51.937' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (192, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Bảo trì máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-07-15T10:20:00.870' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (193, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Bảo trì máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-07-15T10:20:00.917' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (194, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Bảo trì máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-07-15T10:20:05.150' AS DateTime), N'{"page":"work_order","elementId":35}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (195, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:42:59.043' AS DateTime), N'{"page":"work_order","elementId":36}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (196, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:42:59.087' AS DateTime), N'{"page":"work_order","elementId":36}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (197, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:46:04.360' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (198, N'<strong>teamleader</strong> created a work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:46:04.410' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (199, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:46:29.340' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (200, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:46:29.397' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (201, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy hàn que</strong>', CAST(N'2018-08-18T01:46:49.180' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (202, N'Your work order <strong>Mượn máy hàn que</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-18T01:46:53.843' AS DateTime), N'{"page":"work_order","elementId":37}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (203, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:49:19.027' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (204, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:49:19.073' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (205, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:49:25.537' AS DateTime), N'{"page":"work_order","elementId":39}')
GO
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (206, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:49:25.567' AS DateTime), N'{"page":"work_order","elementId":39}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (207, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:52:15.050' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (208, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:52:15.110' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (209, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy khoan bàn</strong>', CAST(N'2018-08-18T01:52:22.333' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (210, N'Your work order <strong>Mượn máy khoan bàn</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-18T01:52:27.510' AS DateTime), N'{"page":"work_order","elementId":38}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (211, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-08-18T01:53:27.533' AS DateTime), N'{"page":"work_order","elementId":40}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (212, N'<strong>maintainer</strong> created a work order <strong>Bảo trì máy máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-08-18T01:53:27.590' AS DateTime), N'{"page":"work_order","elementId":40}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (213, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Bảo trì máy máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-08-18T01:53:34.780' AS DateTime), N'{"page":"work_order","elementId":40}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (214, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Bảo trì máy máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-08-18T01:53:34.840' AS DateTime), N'{"page":"work_order","elementId":40}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (215, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Bảo trì máy máy khoan bàn 600mm hồng ký KD600</strong>', CAST(N'2018-08-18T01:53:52.047' AS DateTime), N'{"page":"work_order","elementId":40}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (216, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-16T10:09:00.703' AS DateTime), N'{"page":"work_order","elementId":41}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (217, N'<strong>teamleader2</strong> created a work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-16T10:09:00.753' AS DateTime), N'{"page":"work_order","elementId":41}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (218, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-16T10:09:11.170' AS DateTime), N'{"page":"work_order","elementId":41}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (219, N'Equipment Staff <strong>estaff</strong> has <strong>checked</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-16T10:09:11.217' AS DateTime), N'{"page":"work_order","elementId":41}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (220, N'Manager <strong>manager</strong> has <strong>approved</strong> your work order <strong>Mượn máy đục bê tông</strong>', CAST(N'2018-08-16T10:09:18.520' AS DateTime), N'{"page":"work_order","elementId":41}')
INSERT [dbo].[Notification] ([Id], [Content], [CreatedDate], [Metadata]) VALUES (221, N'Your work order <strong>Mượn máy đục bê tông</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.', CAST(N'2018-08-16T10:09:26.130' AS DateTime), N'{"page":"work_order","elementId":41}')
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
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate], [Status]) VALUES (3, N'Đội thi công số 3', CAST(N'2018-08-28T09:29:45.703' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 17, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 1, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 2, 6, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 2, 4, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 2, 9, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[TeamLocation] ON 

INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (1, 1, 1, CAST(N'2018-08-27T14:08:18.053' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (2, 4, 1, CAST(N'2018-08-28T01:15:28.217' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (3, 4, 2, CAST(N'2018-08-28T01:15:28.220' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (4, 3, 1, CAST(N'2018-08-28T13:53:17.623' AS DateTime), NULL)
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
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (378, N'1', 41, NULL)
INSERT [dbo].[Tile] ([Id], [Name], [FloorID], [Description]) VALUES (379, N'1', 42, NULL)
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

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (1, N'Mượn máy hàn que', 8, CAST(N'2018-05-11T15:50:11.280' AS DateTime), CAST(N'2018-05-11T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), CAST(N'2018-05-11T10:38:12.550' AS DateTime), CAST(N'2018-05-30T10:38:27.667' AS DateTime), 2, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (2, N'Mượn thiết bị cho công trình Becamex Tower', 8, CAST(N'2018-05-13T01:16:26.670' AS DateTime), CAST(N'2018-05-13T00:00:00.000' AS DateTime), CAST(N'2018-05-28T00:00:00.000' AS DateTime), CAST(N'2018-05-13T10:38:31.290' AS DateTime), CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, 6, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (3, N'Mượn thiết bị Becamex Tower lần 2', 8, CAST(N'2018-05-20T09:34:02.417' AS DateTime), CAST(N'2018-05-20T00:00:00.000' AS DateTime), CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-05-20T10:40:10.090' AS DateTime), CAST(N'2018-05-26T10:40:37.977' AS DateTime), 1, 6, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (4, N'Mượn thiết bị thi công chung cư 4S', 8, CAST(N'2018-05-20T10:36:57.673' AS DateTime), CAST(N'2018-05-21T00:00:00.000' AS DateTime), CAST(N'2018-05-31T00:00:00.000' AS DateTime), CAST(N'2018-05-21T10:40:44.987' AS DateTime), CAST(N'2018-05-28T10:41:05.660' AS DateTime), 3, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (5, N'Mượn tbị cho công trình cầu vượt Nguyễn Thái Sơn', 8, CAST(N'2018-05-02T08:58:11.107' AS DateTime), CAST(N'2018-05-03T00:00:00.000' AS DateTime), CAST(N'2018-05-26T00:00:00.000' AS DateTime), CAST(N'2018-05-03T11:21:15.407' AS DateTime), CAST(N'2018-05-27T17:05:11.107' AS DateTime), 2, 6, 2, 4, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (8, N'Mượn 4 máy hàn que Maxi', 6, CAST(N'2018-05-22T23:00:57.420' AS DateTime), CAST(N'2018-05-22T00:00:00.000' AS DateTime), CAST(N'2018-06-10T00:00:00.000' AS DateTime), CAST(N'2018-05-22T08:04:47.993' AS DateTime), CAST(N'2018-05-22T08:04:57.163' AS DateTime), 2, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (9, N'Mượn máy trộn bê tông', 6, CAST(N'2018-05-22T08:08:03.527' AS DateTime), CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-06-22T00:00:00.000' AS DateTime), CAST(N'2018-05-22T08:08:20.620' AS DateTime), CAST(N'2018-06-22T08:08:36.610' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (10, N'Mượn búa hơi', 6, CAST(N'2018-05-18T08:11:37.157' AS DateTime), CAST(N'2018-05-23T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), CAST(N'2018-05-18T08:11:50.820' AS DateTime), CAST(N'2018-05-29T08:12:15.047' AS DateTime), 1, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (11, N'Mượn 3 máy đầm cóc', 6, CAST(N'2018-05-10T09:13:24.290' AS DateTime), CAST(N'2018-05-10T00:00:00.000' AS DateTime), CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-05-10T09:13:41.733' AS DateTime), CAST(N'2018-05-25T15:14:03.257' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (12, N'Mượn máy khoan bàn', 8, CAST(N'2018-05-25T08:28:44.223' AS DateTime), CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-06-22T00:00:00.000' AS DateTime), CAST(N'2018-05-25T08:28:55.233' AS DateTime), CAST(N'2018-06-22T18:29:08.543' AS DateTime), 2, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (13, N'Mượn búa hơi', 6, CAST(N'2018-05-25T09:33:36.897' AS DateTime), CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-06-29T00:00:00.000' AS DateTime), CAST(N'2018-05-25T09:33:56.100' AS DateTime), CAST(N'2018-06-18T09:34:11.773' AS DateTime), 2, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (14, N'Mượn máy rút lõi bê tông', 6, CAST(N'2018-06-04T10:49:58.250' AS DateTime), CAST(N'2018-06-04T00:00:00.000' AS DateTime), CAST(N'2018-06-24T00:00:00.000' AS DateTime), CAST(N'2018-06-04T11:56:45.153' AS DateTime), CAST(N'2018-06-04T11:56:54.230' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (15, N'Mượn máy hàn que', 8, CAST(N'2018-06-20T09:03:51.060' AS DateTime), CAST(N'2018-06-20T00:00:00.000' AS DateTime), CAST(N'2018-07-06T00:00:00.000' AS DateTime), CAST(N'2018-06-20T09:13:39.730' AS DateTime), CAST(N'2018-07-06T09:13:52.197' AS DateTime), 3, 6, 2, 4, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (16, N'Mượn máy nén khí', 8, CAST(N'2018-06-20T09:04:38.823' AS DateTime), CAST(N'2018-06-22T00:00:00.000' AS DateTime), CAST(N'2018-06-29T00:00:00.000' AS DateTime), CAST(N'2018-06-22T09:15:03.633' AS DateTime), CAST(N'2018-06-29T09:15:18.153' AS DateTime), 1, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (17, N'Mượn máy tiện', 6, CAST(N'2018-06-20T09:05:36.333' AS DateTime), CAST(N'2018-06-29T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-06-29T09:08:02.087' AS DateTime), CAST(N'2018-07-20T09:14:15.847' AS DateTime), 1, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (18, N'Mượn máy hàn', 6, CAST(N'2018-06-20T09:06:22.857' AS DateTime), CAST(N'2018-06-28T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-06-29T09:15:53.013' AS DateTime), CAST(N'2018-07-20T09:16:06.917' AS DateTime), 2, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (19, N'Mượn máy trộn bê tông', 6, CAST(N'2018-06-20T09:07:05.437' AS DateTime), CAST(N'2018-06-29T00:00:00.000' AS DateTime), CAST(N'2018-07-27T00:00:00.000' AS DateTime), CAST(N'2018-06-29T09:16:26.283' AS DateTime), CAST(N'2018-07-26T09:16:38.067' AS DateTime), 1, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (20, N'Mượn máy tiện', 8, CAST(N'2018-07-02T09:20:40.943' AS DateTime), CAST(N'2018-07-02T00:00:00.000' AS DateTime), CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-02T09:27:50.123' AS DateTime), CAST(N'2018-07-12T09:28:01.930' AS DateTime), 2, 6, 2, 4, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (21, N'Mượn máy đầm', 8, CAST(N'2018-07-02T09:21:34.530' AS DateTime), CAST(N'2018-07-02T00:00:00.000' AS DateTime), CAST(N'2018-07-13T00:00:00.000' AS DateTime), CAST(N'2018-07-02T09:27:45.497' AS DateTime), CAST(N'2018-07-12T09:28:18.120' AS DateTime), 3, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (22, N'Mượn máy đục bê tông', 8, CAST(N'2018-07-02T09:22:19.477' AS DateTime), CAST(N'2018-07-04T00:00:00.000' AS DateTime), CAST(N'2018-07-31T00:00:00.000' AS DateTime), CAST(N'2018-07-04T09:29:01.820' AS DateTime), CAST(N'2018-07-20T09:29:41.440' AS DateTime), 2, 6, 2, 4, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (23, N'Mượn máy đục bê tông', 6, CAST(N'2018-07-02T09:23:36.280' AS DateTime), CAST(N'2018-07-02T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-04T09:29:06.663' AS DateTime), CAST(N'2018-07-20T09:29:24.337' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (24, N'Mượn máy đầm cóc', 6, CAST(N'2018-07-02T09:24:24.847' AS DateTime), CAST(N'2018-07-09T00:00:00.000' AS DateTime), CAST(N'2018-07-27T00:00:00.000' AS DateTime), CAST(N'2018-07-09T09:26:04.213' AS DateTime), CAST(N'2018-07-27T09:26:16.557' AS DateTime), 1, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (25, N'Mượn máy hàn que', 8, CAST(N'2018-08-01T09:36:23.810' AS DateTime), CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2018-08-17T00:00:00.000' AS DateTime), CAST(N'2018-08-01T09:42:06.773' AS DateTime), CAST(N'2018-08-17T09:44:20.907' AS DateTime), 3, 6, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (26, N'Mượn máy đục bê tông', 8, CAST(N'2018-08-01T09:37:06.013' AS DateTime), CAST(N'2018-08-02T00:00:00.000' AS DateTime), CAST(N'2018-08-10T00:00:00.000' AS DateTime), CAST(N'2018-08-01T09:42:12.913' AS DateTime), CAST(N'2018-08-10T09:43:57.687' AS DateTime), 2, 6, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (27, N'Mượn máy khoan bàn', 6, CAST(N'2018-08-01T09:37:57.147' AS DateTime), CAST(N'2018-08-01T00:00:00.000' AS DateTime), CAST(N'2018-08-08T00:00:00.000' AS DateTime), CAST(N'2018-08-01T09:42:19.633' AS DateTime), CAST(N'2018-08-08T09:43:08.143' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (28, N'Mượn máy nén khí', 6, CAST(N'2018-08-01T09:39:31.580' AS DateTime), CAST(N'2018-08-03T00:00:00.000' AS DateTime), CAST(N'2018-08-22T00:00:00.000' AS DateTime), CAST(N'2018-08-01T09:41:55.227' AS DateTime), CAST(N'2018-08-22T09:43:41.870' AS DateTime), 3, 6, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (29, N'Mượn máy đầm cóc', 8, CAST(N'2018-08-18T09:42:24.533' AS DateTime), CAST(N'2018-08-20T00:00:00.000' AS DateTime), CAST(N'2018-09-07T00:00:00.000' AS DateTime), CAST(N'2018-08-18T10:04:02.127' AS DateTime), NULL, 2, 5, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (30, N'Mượn máy đục bê tông', 8, CAST(N'2018-08-18T09:48:24.517' AS DateTime), CAST(N'2018-08-20T00:00:00.000' AS DateTime), CAST(N'2018-09-21T00:00:00.000' AS DateTime), NULL, NULL, 2, 4, 2, 1, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (31, N'Mượn máy khoan bàn', 6, CAST(N'2018-08-18T09:49:59.293' AS DateTime), CAST(N'2018-08-28T00:00:00.000' AS DateTime), CAST(N'2018-09-14T00:00:00.000' AS DateTime), NULL, NULL, 2, 1, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (32, N'Mượn máy trộn bê tông', 6, CAST(N'2018-08-18T09:50:41.907' AS DateTime), CAST(N'2018-08-27T00:00:00.000' AS DateTime), CAST(N'2018-09-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 2, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (33, N'Sửa máy khoan bàn 0020018180532', 15, CAST(N'2018-06-24T10:12:54.133' AS DateTime), CAST(N'2018-06-25T00:00:00.000' AS DateTime), CAST(N'2018-06-29T00:00:00.000' AS DateTime), CAST(N'2018-06-24T10:13:50.480' AS DateTime), CAST(N'2018-06-25T10:14:30.740' AS DateTime), 1, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (34, N'Bảo trì máy hàn que Jasic ARC 200', 15, CAST(N'2018-07-14T10:17:21.533' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-14T10:17:43.853' AS DateTime), CAST(N'2018-07-14T10:18:40.457' AS DateTime), 1, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (35, N'Bảo trì máy khoan bàn 600mm hồng ký KD600', 15, CAST(N'2018-07-14T10:19:51.733' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-15T10:20:12.187' AS DateTime), CAST(N'2018-07-16T10:20:47.290' AS DateTime), 1, 6, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (36, N'Mượn máy hàn que', 6, CAST(N'2018-08-18T01:42:58.890' AS DateTime), CAST(N'2018-08-20T00:00:00.000' AS DateTime), CAST(N'2018-09-14T00:00:00.000' AS DateTime), NULL, NULL, 2, 1, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (37, N'Mượn máy hàn que', 8, CAST(N'2018-08-18T01:46:04.227' AS DateTime), CAST(N'2018-08-18T00:00:00.000' AS DateTime), CAST(N'2018-08-29T00:00:00.000' AS DateTime), CAST(N'2018-08-18T01:46:53.707' AS DateTime), NULL, 2, 5, 2, 2, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (38, N'Mượn máy khoan bàn', 6, CAST(N'2018-08-18T01:49:18.907' AS DateTime), CAST(N'2018-08-20T00:00:00.000' AS DateTime), CAST(N'2018-08-30T00:00:00.000' AS DateTime), CAST(N'2018-08-18T01:52:27.390' AS DateTime), NULL, 2, 5, 2, 3, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (40, N'Bảo trì máy máy khoan bàn 600mm hồng ký KD600', 15, CAST(N'2018-08-18T01:53:27.433' AS DateTime), CAST(N'2018-08-27T00:00:00.000' AS DateTime), CAST(N'2018-08-30T00:00:00.000' AS DateTime), CAST(N'2018-08-18T01:53:56.077' AS DateTime), NULL, 1, 5, 1, NULL, N'')
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [ExpectingStartDate], [ExpectingCloseDate], [StartDate], [ClosedDate], [PriorityID], [StatusID], [CategoryID], [TeamLocationID], [Description]) VALUES (41, N'Mượn máy đục bê tông', 6, CAST(N'2018-08-16T10:09:00.570' AS DateTime), CAST(N'2018-08-16T00:00:00.000' AS DateTime), CAST(N'2018-08-29T00:00:00.000' AS DateTime), CAST(N'2018-08-16T10:09:25.973' AS DateTime), NULL, 3, 5, 2, 3, N'')
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (1, 22, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (2, 23, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (3, 24, 1, CAST(N'2018-05-30T10:38:27.667' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (4, 44, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (5, 46, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (6, 45, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (7, 47, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (8, 1, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (9, 2, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (10, 3, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (11, 4, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (12, 62, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (13, 63, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (14, 64, 2, CAST(N'2018-05-27T10:39:42.640' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (15, 5, 3, CAST(N'2018-05-26T10:40:37.977' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (16, 25, 3, CAST(N'2018-05-26T10:40:37.977' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (17, 26, 3, CAST(N'2018-05-26T10:40:37.977' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (18, 27, 3, CAST(N'2018-05-26T10:40:37.977' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (19, 11, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (20, 12, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (21, 13, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (22, 67, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (23, 68, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (24, 69, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (25, 52, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (26, 53, 4, CAST(N'2018-05-28T10:41:05.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (27, 4, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (28, 5, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (29, 15, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (30, 16, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (31, 17, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (32, 22, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (33, 23, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (34, 24, 5, CAST(N'2018-05-27T17:05:11.107' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (43, 30, 8, CAST(N'2018-06-10T08:04:56.793' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (44, 31, 8, CAST(N'2018-06-10T08:04:56.973' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (45, 32, 8, CAST(N'2018-06-10T08:04:57.087' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (46, 33, 8, CAST(N'2018-06-10T08:04:57.163' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (47, 62, 9, CAST(N'2018-05-22T08:08:36.230' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (48, 63, 9, CAST(N'2018-06-22T08:08:36.323' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (49, 64, 9, CAST(N'2018-06-22T08:08:36.403' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (50, 65, 9, CAST(N'2018-06-22T08:08:36.517' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (51, 66, 9, CAST(N'2018-05-22T08:08:36.607' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (52, 1, 10, CAST(N'2018-05-29T08:12:14.837' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (53, 2, 10, CAST(N'2018-05-29T08:12:14.947' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (54, 3, 10, CAST(N'2018-05-29T08:12:15.047' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (55, 6, 11, CAST(N'2018-05-25T15:14:03.030' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (56, 7, 11, CAST(N'2018-05-25T15:14:03.150' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (57, 8, 11, CAST(N'2018-05-25T15:14:03.253' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (58, 41, 12, CAST(N'2018-06-22T18:29:08.353' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (59, 42, 12, CAST(N'2018-06-22T18:29:08.440' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (60, 43, 12, CAST(N'2018-06-22T18:29:08.543' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (61, 4, 13, CAST(N'2018-06-18T09:34:11.583' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (62, 5, 13, CAST(N'2018-06-18T09:34:11.773' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (63, 44, 14, CAST(N'2018-06-04T11:56:53.933' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (64, 45, 14, CAST(N'2018-06-04T11:56:54.057' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (65, 46, 14, CAST(N'2018-06-04T11:56:54.153' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (66, 47, 14, CAST(N'2018-06-04T11:56:54.230' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (67, 22, 15, CAST(N'2018-07-06T09:13:51.950' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (68, 24, 15, CAST(N'2018-07-06T09:13:52.093' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (69, 23, 15, CAST(N'2018-07-06T09:13:52.197' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (70, 52, 16, CAST(N'2018-06-29T09:15:17.677' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (71, 53, 16, CAST(N'2018-06-29T09:15:17.827' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (72, 54, 16, CAST(N'2018-06-29T09:15:17.980' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (73, 55, 16, CAST(N'2018-06-29T09:15:18.150' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (74, 56, 17, CAST(N'2018-07-20T09:14:15.597' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (75, 57, 17, CAST(N'2018-07-20T09:14:15.730' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (76, 58, 17, CAST(N'2018-07-20T09:14:15.847' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (77, 30, 18, CAST(N'2018-07-20T09:16:06.567' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (78, 31, 18, CAST(N'2018-07-20T09:16:06.693' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (79, 32, 18, CAST(N'2018-07-20T09:16:06.797' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (80, 33, 18, CAST(N'2018-07-20T09:16:06.917' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (81, 62, 19, CAST(N'2018-07-26T09:16:37.707' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (82, 63, 19, CAST(N'2018-07-26T09:16:37.840' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (83, 64, 19, CAST(N'2018-07-26T09:16:37.947' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (84, 65, 19, CAST(N'2018-07-26T09:16:38.063' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (85, 59, 20, CAST(N'2018-07-12T09:28:01.660' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (86, 60, 20, CAST(N'2018-07-12T09:28:01.813' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (87, 61, 20, CAST(N'2018-07-12T09:28:01.930' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (88, 11, 21, CAST(N'2018-07-12T09:28:17.773' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (89, 12, 21, CAST(N'2018-07-12T09:28:17.893' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (90, 13, 21, CAST(N'2018-07-12T09:28:18.010' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (91, 14, 21, CAST(N'2018-07-12T09:28:18.120' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (92, 15, 22, CAST(N'2018-07-20T09:29:41.183' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (93, 16, 22, CAST(N'2018-07-20T09:29:41.317' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (94, 17, 22, CAST(N'2018-07-20T09:29:41.440' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (95, 18, 23, CAST(N'2018-07-20T09:29:23.970' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (96, 19, 23, CAST(N'2018-07-20T09:29:24.100' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (97, 20, 23, CAST(N'2018-07-20T09:29:24.223' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (98, 21, 23, CAST(N'2018-07-20T09:29:24.333' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (99, 9, 24, CAST(N'2018-07-27T09:26:16.293' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (100, 10, 24, CAST(N'2018-07-27T09:26:16.423' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (101, 6, 24, CAST(N'2018-07-27T09:26:16.553' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (102, 34, 25, CAST(N'2018-08-17T09:44:20.563' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (103, 35, 25, CAST(N'2018-08-17T09:44:20.690' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (104, 36, 25, CAST(N'2018-08-17T09:44:20.800' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (105, 37, 25, CAST(N'2018-08-17T09:44:20.907' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (106, 15, 26, CAST(N'2018-08-10T09:43:57.440' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (107, 16, 26, CAST(N'2018-08-10T09:43:57.573' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (108, 17, 26, CAST(N'2018-08-10T09:43:57.687' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (109, 39, 27, CAST(N'2018-08-08T09:43:08.183' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (110, 40, 27, CAST(N'2018-08-08T09:43:08.317' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (111, 52, 28, CAST(N'2018-08-22T09:43:41.750' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (112, 53, 28, CAST(N'2018-08-22T09:43:41.870' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (113, 11, 29, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (114, 12, 29, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (115, 1, 30, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (116, 2, 30, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (117, 39, 31, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (118, 40, 31, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (119, 66, 32, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (120, 67, 32, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (121, 68, 32, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (122, 41, 33, CAST(N'2018-06-25T10:14:30.740' AS DateTime), 100000, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (123, 22, 34, CAST(N'2018-07-14T10:18:40.220' AS DateTime), 150000, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (124, 23, 34, CAST(N'2018-07-14T10:18:40.350' AS DateTime), 0, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (125, 24, 34, CAST(N'2018-07-14T10:18:40.453' AS DateTime), 0, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (126, 41, 35, CAST(N'2018-07-16T10:20:47.140' AS DateTime), 50000, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (127, 42, 35, CAST(N'2018-07-16T10:20:47.220' AS DateTime), 50000, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (128, 43, 35, CAST(N'2018-07-16T10:20:47.290' AS DateTime), 50000, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (129, 25, 36, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (130, 26, 36, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (131, 27, 36, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (132, 28, 37, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (133, 29, 37, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (134, 42, 38, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (135, 43, 38, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (138, 41, 40, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (139, 18, 41, NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ClosedDate], [MaintainceCost], [Description]) VALUES (140, 19, 41, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] ON 

INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (1, 1, 10, CAST(N'2018-05-30T10:38:27.667' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (2, 2, 10, CAST(N'2018-05-30T10:38:27.667' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (3, 3, 10, CAST(N'2018-05-30T10:38:27.667' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (4, 4, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (5, 11, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (6, 6, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (7, 5, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (8, 7, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (9, 8, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (10, 9, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (11, 10, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (12, 12, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (13, 13, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (14, 14, 10, CAST(N'2018-05-27T10:39:42.640' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (15, 15, 10, CAST(N'2018-05-26T10:40:37.977' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (16, 16, 10, CAST(N'2018-05-26T10:40:37.977' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (17, 17, 10, CAST(N'2018-05-26T10:40:37.977' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (18, 18, 10, CAST(N'2018-05-26T10:40:37.977' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (19, 25, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (20, 26, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (21, 19, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (22, 20, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (23, 21, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (24, 22, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (25, 23, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (26, 24, 10, CAST(N'2018-05-28T10:41:05.660' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (27, 29, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (28, 30, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (29, 31, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (30, 32, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (31, 33, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (32, 34, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (33, 27, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (34, 28, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (40, 43, 10, CAST(N'2018-05-22T08:04:56.793' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (41, 44, 10, CAST(N'2018-05-22T08:04:56.970' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (42, 45, 10, CAST(N'2018-05-22T08:04:57.087' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (43, 46, 10, CAST(N'2018-05-22T08:04:57.160' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (44, 47, 10, CAST(N'2018-05-22T08:08:36.223' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (45, 48, 10, CAST(N'2018-05-22T08:08:36.323' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (46, 49, 10, CAST(N'2018-05-22T08:08:36.403' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (47, 50, 10, CAST(N'2018-05-22T08:08:36.517' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (48, 51, 10, CAST(N'2018-05-22T08:08:36.607' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (49, 52, 10, CAST(N'2018-05-29T08:12:14.830' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (50, 53, 10, CAST(N'2018-05-29T08:12:14.947' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (51, 54, 10, CAST(N'2018-05-29T08:12:15.047' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (52, 55, 10, CAST(N'2018-05-25T15:14:03.023' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (53, 56, 10, CAST(N'2018-05-25T15:14:03.150' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (54, 57, 10, CAST(N'2018-05-25T15:14:03.250' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (55, 58, 10, CAST(N'2018-06-22T18:29:08.350' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (56, 59, 10, CAST(N'2018-06-22T18:29:08.440' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (57, 60, 10, CAST(N'2018-06-22T18:29:08.543' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (58, 61, 10, CAST(N'2018-06-18T09:34:11.580' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (59, 62, 10, CAST(N'2018-06-18T09:34:11.767' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (60, 63, 10, CAST(N'2018-06-04T11:56:53.930' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (61, 64, 10, CAST(N'2018-06-04T11:56:54.057' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (62, 65, 10, CAST(N'2018-06-04T11:56:54.153' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (63, 66, 10, CAST(N'2018-06-04T11:56:54.227' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (64, 74, 10, CAST(N'2018-07-20T09:14:15.590' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (65, 75, 10, CAST(N'2018-07-20T09:14:15.730' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (66, 76, 10, CAST(N'2018-07-20T09:14:15.843' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (67, 67, 10, CAST(N'2018-07-06T09:13:51.947' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (68, 68, 10, CAST(N'2018-07-06T09:13:52.093' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (69, 69, 10, CAST(N'2018-07-06T09:13:52.197' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (70, 70, 10, CAST(N'2018-06-29T09:15:17.670' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (71, 71, 10, CAST(N'2018-06-29T09:15:17.827' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (72, 72, 10, CAST(N'2018-06-29T09:15:17.977' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (73, 73, 10, CAST(N'2018-06-29T09:15:18.150' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (74, 77, 10, CAST(N'2018-07-20T09:16:06.563' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (75, 78, 10, CAST(N'2018-07-20T09:16:06.693' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (76, 79, 10, CAST(N'2018-07-20T09:16:06.797' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (77, 80, 10, CAST(N'2018-07-20T09:16:06.913' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (78, 81, 10, CAST(N'2018-07-26T09:16:37.703' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (79, 82, 10, CAST(N'2018-07-26T09:16:37.840' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (80, 83, 10, CAST(N'2018-07-26T09:16:37.947' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (81, 84, 10, CAST(N'2018-07-26T09:16:38.063' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (82, 99, 10, CAST(N'2018-07-27T09:26:16.287' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (83, 100, 10, CAST(N'2018-07-27T09:26:16.423' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (84, 101, 10, CAST(N'2018-07-27T09:26:16.550' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (85, 85, 10, CAST(N'2018-07-12T09:28:01.657' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (86, 86, 10, CAST(N'2018-07-12T09:28:01.813' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (87, 87, 10, CAST(N'2018-07-12T09:28:01.927' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (88, 88, 10, CAST(N'2018-07-12T09:28:17.770' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (89, 89, 10, CAST(N'2018-07-12T09:28:17.893' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (90, 90, 10, CAST(N'2018-07-12T09:28:18.010' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (91, 91, 10, CAST(N'2018-07-12T09:28:18.117' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (92, 95, 10, CAST(N'2018-07-20T09:29:23.970' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (93, 96, 10, CAST(N'2018-07-20T09:29:24.097' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (94, 97, 10, CAST(N'2018-07-20T09:29:24.223' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (95, 98, 10, CAST(N'2018-07-20T09:29:24.333' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (96, 92, 10, CAST(N'2018-07-20T09:29:41.180' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (97, 93, 10, CAST(N'2018-07-20T09:29:41.317' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (98, 94, 10, CAST(N'2018-07-20T09:29:41.437' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (99, 109, 10, CAST(N'2018-08-08T09:43:08.007' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (100, 110, 10, CAST(N'2018-08-08T09:43:08.140' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (101, 109, 10, CAST(N'2018-08-08T09:43:08.183' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (102, 110, 10, CAST(N'2018-08-08T09:43:08.313' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (103, 111, 10, CAST(N'2018-08-22T09:43:41.743' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (104, 112, 10, CAST(N'2018-08-22T09:43:41.867' AS DateTime), 1, NULL)
GO
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (105, 106, 10, CAST(N'2018-08-10T09:43:57.437' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (106, 107, 10, CAST(N'2018-08-10T09:43:57.573' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (107, 108, 10, CAST(N'2018-08-10T09:43:57.687' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (108, 102, 10, CAST(N'2018-08-17T09:44:20.560' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (109, 103, 10, CAST(N'2018-08-17T09:44:20.690' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (110, 104, 10, CAST(N'2018-08-17T09:44:20.800' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (111, 105, 10, CAST(N'2018-08-17T09:44:20.903' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (112, 122, 10, CAST(N'2018-06-25T10:14:30.733' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (113, 123, 10, CAST(N'2018-07-14T10:18:40.217' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (114, 124, 10, CAST(N'2018-07-14T10:18:40.347' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (115, 125, 10, CAST(N'2018-07-14T10:18:40.450' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (116, 126, 10, CAST(N'2018-07-16T10:20:47.137' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (117, 127, 10, CAST(N'2018-07-16T10:20:47.220' AS DateTime), 1, NULL)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailID], [ByUserID], [DateTime], [ReturnedStatusID], [OldRuntimeDays]) VALUES (118, 128, 10, CAST(N'2018-07-16T10:20:47.290' AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] ON 

INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (1, 1, 8, CAST(N'2018-05-11T15:50:11.280' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (2, 1, 10, CAST(N'2018-05-11T16:59:27.913' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (3, 1, 3, CAST(N'2018-05-11T17:20:54.163' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (4, 2, 8, CAST(N'2018-05-13T08:16:26.670' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (5, 3, 8, CAST(N'2018-05-20T09:34:02.417' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (6, 4, 8, CAST(N'2018-05-20T10:36:57.673' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (7, 4, 10, CAST(N'2018-05-20T11:03:57.673' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (8, 3, 10, CAST(N'2018-05-20T09:54:02.417' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (9, 2, 10, CAST(N'2018-05-13T08:56:26.670' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (10, 4, 3, CAST(N'2018-05-20T13:26:57.673' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (11, 3, 3, CAST(N'2018-05-20T10:00:02.417' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (12, 2, 3, CAST(N'2018-05-13T09:02:05.473' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (13, 1, 10, CAST(N'2018-05-12T07:30:11.280' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (14, 1, 10, CAST(N'2018-05-30T10:38:27.667' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (15, 2, 10, CAST(N'2018-05-13T09:05:31.290' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (16, 2, 10, CAST(N'2018-05-28T10:39:42.640' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (17, 3, 10, CAST(N'2018-05-20T11:54:02.417' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (18, 3, 10, CAST(N'2018-05-26T10:40:37.977' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (19, 4, 10, CAST(N'2018-05-20T13:46:57.673' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (20, 4, 10, CAST(N'2018-05-28T17:41:05.660' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (21, 5, 8, CAST(N'2018-05-03T09:58:11.107' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (22, 5, 10, CAST(N'2018-05-03T11:01:12.063' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (23, 5, 3, CAST(N'2018-05-03T11:21:15.407' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (24, 5, 10, CAST(N'2018-05-03T14:01:18.153' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (25, 5, 10, CAST(N'2018-05-27T17:05:11.107' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (34, 8, 6, CAST(N'2018-05-22T08:00:57.420' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (35, 8, 10, CAST(N'2018-05-22T08:04:38.553' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (36, 8, 3, CAST(N'2018-05-22T08:04:41.363' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (37, 8, 10, CAST(N'2018-05-22T08:04:47.993' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (38, 8, 10, CAST(N'2018-05-22T08:04:57.163' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (39, 9, 6, CAST(N'2018-05-22T08:08:03.527' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (40, 9, 10, CAST(N'2018-05-22T08:08:12.697' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (41, 9, 3, CAST(N'2018-05-22T08:08:16.210' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (42, 9, 10, CAST(N'2018-05-22T08:08:20.620' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (43, 9, 10, CAST(N'2018-05-22T08:08:36.610' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (44, 10, 6, CAST(N'2018-05-18T08:11:37.157' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (45, 10, 10, CAST(N'2018-05-18T08:11:45.167' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (46, 10, 3, CAST(N'2018-05-18T08:11:47.923' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (47, 10, 10, CAST(N'2018-05-18T08:11:50.820' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (48, 10, 10, CAST(N'2018-05-29T08:12:15.047' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (49, 11, 6, CAST(N'2018-05-10T09:13:24.290' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (50, 11, 10, CAST(N'2018-05-10T09:13:34.957' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (51, 11, 3, CAST(N'2018-05-10T09:13:37.803' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (52, 11, 10, CAST(N'2018-05-10T09:13:41.733' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (53, 11, 10, CAST(N'2018-05-25T15:14:03.257' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (54, 12, 8, CAST(N'2018-05-25T08:28:44.223' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (55, 12, 10, CAST(N'2018-05-25T08:28:48.937' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (56, 12, 3, CAST(N'2018-05-25T08:28:53.013' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (57, 12, 10, CAST(N'2018-05-25T08:28:55.233' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (58, 12, 10, CAST(N'2018-06-22T18:29:08.543' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (59, 13, 6, CAST(N'2018-05-25T09:33:36.897' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (60, 13, 10, CAST(N'2018-05-25T09:33:44.713' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (61, 13, 3, CAST(N'2018-05-25T09:33:48.407' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (62, 13, 10, CAST(N'2018-05-25T09:33:56.100' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (63, 13, 10, CAST(N'2018-06-18T09:34:11.773' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (64, 14, 6, CAST(N'2018-06-04T10:49:58.250' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (65, 14, 10, CAST(N'2018-06-04T11:55:59.453' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (66, 14, 3, CAST(N'2018-06-04T11:56:41.990' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (67, 14, 10, CAST(N'2018-06-04T11:56:45.153' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (68, 14, 10, CAST(N'2018-06-04T11:56:54.230' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (69, 15, 8, CAST(N'2018-06-20T09:03:51.060' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (70, 16, 8, CAST(N'2018-06-20T09:04:38.823' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (71, 17, 6, CAST(N'2018-06-20T09:05:36.333' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (72, 18, 6, CAST(N'2018-06-20T09:06:22.857' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (73, 19, 6, CAST(N'2018-06-20T09:07:05.437' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (74, 17, 10, CAST(N'2018-06-29T09:07:51.310' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (75, 17, 3, CAST(N'2018-06-29T09:07:58.297' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (76, 17, 10, CAST(N'2018-06-29T09:08:02.087' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (77, 17, 10, CAST(N'2018-07-20T09:14:15.847' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (78, 15, 10, CAST(N'2018-06-20T09:13:31.357' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (79, 15, 3, CAST(N'2018-06-20T09:13:34.920' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (80, 15, 10, CAST(N'2018-06-20T09:13:39.730' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (81, 15, 10, CAST(N'2018-07-06T09:13:52.200' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (82, 16, 10, CAST(N'2018-06-22T09:14:36.223' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (83, 16, 3, CAST(N'2018-06-22T09:14:40.800' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (84, 16, 10, CAST(N'2018-06-22T09:15:03.633' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (85, 16, 10, CAST(N'2018-06-29T09:15:18.153' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (86, 18, 10, CAST(N'2018-06-29T09:15:47.270' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (87, 18, 3, CAST(N'2018-06-29T09:15:50.267' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (88, 18, 10, CAST(N'2018-06-29T09:15:53.013' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (89, 18, 10, CAST(N'2018-07-20T09:16:06.917' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (90, 19, 10, CAST(N'2018-06-29T09:16:17.830' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (91, 19, 3, CAST(N'2018-06-29T09:16:21.873' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (92, 19, 10, CAST(N'2018-06-29T09:16:26.283' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (93, 19, 10, CAST(N'2018-07-26T09:16:38.067' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (94, 20, 8, CAST(N'2018-07-02T09:20:40.943' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (95, 21, 8, CAST(N'2018-07-02T09:21:34.530' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (96, 22, 8, CAST(N'2018-07-02T09:22:19.477' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (97, 23, 6, CAST(N'2018-07-02T09:23:36.280' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (98, 24, 6, CAST(N'2018-07-02T09:24:24.847' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (99, 24, 10, CAST(N'2018-07-09T09:25:52.240' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (100, 24, 3, CAST(N'2018-07-09T09:25:58.310' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (101, 24, 10, CAST(N'2018-07-09T09:26:04.213' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (102, 24, 10, CAST(N'2018-07-27T09:26:16.557' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (103, 20, 10, CAST(N'2018-07-02T09:26:35.720' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (104, 21, 10, CAST(N'2018-07-02T09:26:41.907' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (105, 20, 3, CAST(N'2018-07-02T09:27:25.020' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (106, 21, 3, CAST(N'2018-07-02T09:27:34.913' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (107, 21, 10, CAST(N'2018-07-02T09:27:45.497' AS DateTime), 3, 5, NULL)
GO
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (108, 20, 10, CAST(N'2018-07-02T09:27:50.123' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (109, 20, 10, CAST(N'2018-07-12T09:28:01.930' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (110, 21, 10, CAST(N'2018-07-12T09:28:18.120' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (111, 23, 10, CAST(N'2018-07-04T09:28:36.710' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (112, 22, 10, CAST(N'2018-07-04T09:28:40.667' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (113, 22, 3, CAST(N'2018-07-04T09:28:46.537' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (114, 23, 3, CAST(N'2018-07-04T09:28:56.227' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (115, 22, 10, CAST(N'2018-07-04T09:29:01.820' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (116, 23, 10, CAST(N'2018-07-04T09:29:06.663' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (117, 23, 10, CAST(N'2018-07-20T09:29:24.337' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (118, 22, 10, CAST(N'2018-07-20T09:29:41.440' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (119, 25, 8, CAST(N'2018-08-01T09:36:23.810' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (120, 26, 8, CAST(N'2018-08-01T09:37:06.013' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (121, 27, 6, CAST(N'2018-08-01T09:37:57.147' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (122, 28, 6, CAST(N'2018-08-01T09:39:31.580' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (123, 25, 10, CAST(N'2018-08-01T09:40:08.643' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (124, 26, 10, CAST(N'2018-08-01T09:40:17.273' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (125, 27, 10, CAST(N'2018-08-01T09:40:23.153' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (126, 28, 10, CAST(N'2018-08-01T09:40:31.613' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (127, 25, 3, CAST(N'2018-08-01T09:40:37.950' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (128, 26, 3, CAST(N'2018-08-01T09:40:55.783' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (129, 27, 3, CAST(N'2018-08-01T09:41:09.843' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (130, 28, 3, CAST(N'2018-08-01T09:41:34.863' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (131, 28, 10, CAST(N'2018-08-01T09:41:55.227' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (132, 25, 10, CAST(N'2018-08-01T09:42:06.773' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (133, 26, 10, CAST(N'2018-08-01T09:42:12.913' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (134, 27, 10, CAST(N'2018-08-01T09:42:19.633' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (135, 27, 10, CAST(N'2018-08-08T09:43:08.143' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (136, 28, 10, CAST(N'2018-08-22T09:43:41.870' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (137, 26, 10, CAST(N'2018-08-10T09:43:57.687' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (138, 25, 10, CAST(N'2018-08-17T09:44:20.907' AS DateTime), 5, 6, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (139, 29, 8, CAST(N'2018-08-18T09:42:24.533' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (140, 30, 8, CAST(N'2018-08-18T09:48:24.517' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (141, 31, 6, CAST(N'2018-08-18T09:49:59.293' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (142, 32, 6, CAST(N'2018-08-18T09:50:41.907' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (143, 29, 10, CAST(N'2018-08-18T09:51:13.243' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (144, 30, 10, CAST(N'2018-08-18T09:51:20.683' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (145, 32, 10, CAST(N'2018-08-18T09:52:04.593' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (146, 29, 3, CAST(N'2018-08-18T09:52:14.793' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (147, 30, 3, CAST(N'2018-08-18T09:54:11.530' AS DateTime), 2, 4, N'Hiện công trường không còn cần búa đục nữa, tại sao lại mượn?')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (148, 29, 10, CAST(N'2018-08-18T10:04:02.127' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (149, 33, 15, CAST(N'2018-06-24T10:12:54.133' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (150, 33, 10, CAST(N'2018-06-24T10:13:20.787' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (151, 33, 3, CAST(N'2018-06-24T10:13:46.833' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (152, 33, 10, CAST(N'2018-06-24T10:13:50.480' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (153, 33, 10, CAST(N'2018-06-25T10:14:30.740' AS DateTime), 5, 6, N'Đã thay dây mới')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (154, 34, 15, CAST(N'2018-07-14T10:17:21.533' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (155, 34, 10, CAST(N'2018-07-14T10:17:32.403' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (156, 34, 3, CAST(N'2018-07-14T10:17:37.353' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (157, 34, 10, CAST(N'2018-07-14T10:17:43.853' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (158, 34, 10, CAST(N'2018-07-14T10:18:40.457' AS DateTime), 5, 6, N'Máy tốt, chỉ bị bụi vào, đã vệ sinh')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (159, 35, 15, CAST(N'2018-07-14T10:19:51.733' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (160, 35, 10, CAST(N'2018-07-15T10:20:00.820' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (161, 35, 3, CAST(N'2018-07-15T10:20:04.977' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (162, 35, 10, CAST(N'2018-07-15T10:20:12.187' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (163, 35, 10, CAST(N'2018-07-16T10:20:47.290' AS DateTime), 5, 6, N'Thay lưỡi cưa mới')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (164, 36, 6, CAST(N'2018-08-18T01:42:58.890' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (165, 37, 8, CAST(N'2018-08-18T01:46:04.227' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (166, 37, 10, CAST(N'2018-08-18T01:46:29.290' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (167, 37, 3, CAST(N'2018-08-18T01:46:49.040' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (168, 37, 10, CAST(N'2018-08-18T01:46:53.707' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (169, 38, 6, CAST(N'2018-08-18T01:49:18.907' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (171, 38, 10, CAST(N'2018-08-18T01:52:14.997' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (172, 38, 3, CAST(N'2018-08-18T01:52:22.210' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (173, 38, 10, CAST(N'2018-08-18T01:52:27.390' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (174, 40, 15, CAST(N'2018-08-18T01:53:27.433' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (175, 40, 10, CAST(N'2018-08-18T01:53:34.723' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (176, 40, 3, CAST(N'2018-08-18T01:53:51.910' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (177, 40, 10, CAST(N'2018-08-18T01:53:56.077' AS DateTime), 3, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (178, 41, 6, CAST(N'2018-08-16T10:09:00.570' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (179, 41, 10, CAST(N'2018-08-16T10:09:11.113' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (180, 41, 3, CAST(N'2018-08-16T10:09:18.360' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (181, 41, 10, CAST(N'2018-08-16T10:09:25.973' AS DateTime), 3, 5, NULL)
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
