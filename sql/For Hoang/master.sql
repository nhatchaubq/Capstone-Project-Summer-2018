/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [EquipmentManageSystem]    Script Date: 7/12/2018 12:44:30 PM ******/
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
ALTER DATABASE [EquipmentManageSystem] SET ANSI_NULLS OFF 
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
/****** Object:  Table [dbo].[Account]    Script Date: 7/12/2018 12:44:30 PM ******/
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
	[Phone] [nvarchar](13) NULL,
	[IsActive] [bit] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[RoleID] [int] NULL,
	[AvatarImage] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Block]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LocationID] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[Coordinate] [varchar](max) NULL,
	[TotalFloor] [int] NULL,
	[TotalBasementFloor] [int] NULL,
 CONSTRAINT [PK_Block] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 7/12/2018 12:44:30 PM ******/
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
 CONSTRAINT [PK__Equipmen__3214EC0703B82630] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NULL,
	[SerialNumber] [nvarchar](50) NULL,
	[WarrantyDuration] [int] NULL,
	[RuntimeDays] [int] NULL,
	[Price] [float] NULL,
	[ImportDate] [datetime] NULL,
	[LastMaintainDate] [datetime] NULL,
	[NextMaintainDate] [datetime] NULL,
	[StatusId] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[TileID] [int] NULL,
 CONSTRAINT [PK__Equipmen__3214EC07D8BED705] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Floor]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 7/12/2018 12:44:30 PM ******/
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
	[Image] [varchar](max) NULL,
	[PaintToolMode] [int] NULL,
 CONSTRAINT [PK__Location__3214EC0780403FED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Tile]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 7/12/2018 12:44:30 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorType]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[RequestUserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[PriorityID] [int] NULL,
	[StatusID] [int] NULL,
	[CategoryID] [int] NULL,
	[TeamLocationID] [int] NULL,
 CONSTRAINT [PK__WorkOrde__3214EC07627B479A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentItemID] [int] NULL,
	[WorkOrderID] [int] NULL,
	[ExpectingStartDate] [datetime] NULL,
	[ExpectingDueDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
	[MaintainceCost] [float] NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_WorkOrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 7/12/2018 12:44:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetailReturn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderDetailId] [int] NOT NULL,
	[ByUserId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[NewItemStatusId] [int] NULL,
 CONSTRAINT [PK_WorkOrderDetailRecord_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 7/12/2018 12:44:30 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 7/12/2018 12:44:30 PM ******/
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
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', NULL, N'Minh Hung', NULL, 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'TienNT', N'123456', NULL, N'Thanh Tien', NULL, 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'KhanhPM', N'123456', NULL, N'Minh Khanh', NULL, 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'staff', N'123456', NULL, N'Manh Hung', NULL, 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', NULL, N'Quoc Viet', NULL, 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'teamleader', N'123456', NULL, N'Bùi Quang Nhật Châu', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 5, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', NULL, N'Thanh Hau', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'estaff', N'123456', NULL, N'Huy Hoang', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (11, N'DienDTL', N'123456', NULL, N'Lam Dien', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (12, N'ThanhNT', N'123456', NULL, N'Ngoc Thanh', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (13, N'HungNT', N'123456', NULL, N'Thanh Hung', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (14, N'NgocHT', N'123456', NULL, N'Tuan Ngoc', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'Huy', N'123456', NULL, N'Nhat Huy', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (16, N'chau', N'123456', NULL, N'bao chau', NULL, NULL, NULL, NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (17, N'DienDTL', N'123456', N'', N'Đoàn Trọng Lam Điền', N'0123999888', NULL, CAST(N'1996-06-13T00:00:00.000' AS DateTime), NULL, 4, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (1, N'Block A', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (2, N'Block B', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (3, N'Block A1', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (4, N'Block A2', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (5, N'Block A3', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (6, N'Block A', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (33, N'1', 7, NULL, N'[{"x":0,"y":0},{"x":500,"y":0},{"x":500,"y":350},{"x":0,"y":350}]', 2, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (34, N'Nha anh Chau', 9, NULL, N'[{"x":0,"y":0},{"x":460,"y":0},{"x":460,"y":296},{"x":0,"y":296}]', NULL, NULL)
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

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', N'Japan', NULL, 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', N'China', NULL, 1, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/35553276_1397515960392211_9183626838994321408_n.jpg?_nc_cat=0&oh=ce5ff292839ea9d2409a8590d39ed08e&oe=5BB5BACF', N'Hàn Quốc', N'Update', 1, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', N'Puma', NULL, 1, 4)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (5, N'
Panasonic Laser Fax KX-FLB882', 2, N'http://www.mucinhanoi.vn/images/201204/goods_img/612_G_1334278634575.jpg', N'Japan', NULL, 1, 5)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (14, N'Máy đầm cóc chạy điện HCD100 (3KW) 380V', 1, N'http://dailymayxaydung.com/wp-content/uploads/2017/09/dam_coc_hcd100.jpg', N'China', NULL, 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (15, N'Búa hơi đục bê tông G10', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg', N'China', NULL, 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (16, N'Máy đo khoảng cách laser Bosch GLM30 (30m)
', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/08/Bosch-GML30-400x400.jpg', N'Malaysia', NULL, 1, 10)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (17, N'Máy đo khoảng cách Leica Disto D510 (200m)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_bom_SEV50X.jpg', N'Hungary', N'ASSD', 1, 10)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (18, N'Máy khoan bàn 600mm hồng ký KD600', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may-khoan-ban-hong-ky-hk-kd600.gif', N'VietNam', NULL, 1, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (19, N'Máy trộn bê tông cam 250L', 1, N'http://dienmaysaoviet.vn//app/webroot/upload/image/images/M%C3%A1y%20tr%E1%BB%99n%20b%C3%AA%20t%C3%B4ng%20250L.jpg', N'VietNam', NULL, 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1028, N'Máy hàn que Maxi 300', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_han_que_maxi_300.jpg', N'China', NULL, 1, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1031, N'Máy tiện ren ống Lushun Zit-N50 (21-60mm)', 1, N'http://res.cloudinary.com/deanwflps/image/upload/v1528885003/e60k0wfkx64osout7qjs.jpg', N'China', N'Nhập thử lần đầu 1 sp', 1, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1032, N'Máy bơm nước Koshin SEV 50X (3.1KW)', 11, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_bom_SEV50X.jpg', N'Nhật Bản - USA', N'ABCD', 1, 10)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1033, N'may duoi sat cat sat 2-5GT', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531271427/may_duoi_sat_gt2-5-400x400.jpg.jpg', N'Viet Nam', N'demo', 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1034, N'may_duoi_sat_gt2-5', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531271427/may_duoi_sat_gt2-5-400x400.jpg.jpg', N'Nhật Bản', N'demo', 1, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID]) VALUES (1035, N'Máy duỗi sắt GT2-7', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531349130/1.jpg.jpg', N'', N'test demo', 1, 1)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentCategory] ON 

INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (1, N'Máy xây dựng', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (2, N'Máy cơ khí', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (3, N'Máy hàn', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (4, N'Máy nén khí', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (5, N'Máy bơm', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (6, N'Máy FAX', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (7, N'Crane', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (8, N'Excavator', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (9, N'Forklift', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (10, N'Dụng cụ đo', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (11, N'Dụng cụ điện', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (12, N'Máy bay', NULL)
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (1, 4, N'10101012', 6, 12, 2950000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (2, 4, N'10101013', 6, 10, 2950000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (3, 4, N'10101014', 6, 5, 2950000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (4, 2, N'1212900', 12, 18, 3450000, NULL, NULL, NULL, 1, NULL, 66)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (5, 2, N'1212901', 12, 7, 3450000, NULL, NULL, NULL, 1, NULL, 69)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (6, 2, N'1212903', 12, 7, 3450000, NULL, NULL, NULL, 1, NULL, 69)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (7, 5, N'109021101', 12, 64, 8290000, NULL, NULL, NULL, 1, NULL, 59)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (8, 5, N'109021109', 12, 75, 8290000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (9, 16, N'1110245222311', 18, 0, 1980000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (10, 16, N'1110242566178', 18, 0, 1980000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (11, 15, N'2020154022532', 6, 100, 1650000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), 1, N'Mới update', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (12, 15, N'2020154322210', 6666, 6666, 6666, CAST(N'2017-10-01T00:00:00.000' AS DateTime), CAST(N'2018-04-19T00:00:00.000' AS DateTime), CAST(N'2018-07-19T00:00:00.000' AS DateTime), 1, N'ahihi', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (13, 18, N'1245543156741', 3, 10, 1800000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (14, 18, N'1245543156751', 3, 20, 1800000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (15, 18, N'1245543256435', 3, 21, 1800000, CAST(N'2018-06-16T15:55:17.107' AS DateTime), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (16, 19, N'1134578122221', 6, 15, 2700000, NULL, NULL, NULL, 1, NULL, 58)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (17, 19, N'1134578122652', 6, 26, 2700000, NULL, NULL, NULL, 1, NULL, 59)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (18, 19, N'1134578122543', 6, 57, 2700000, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (35, 15, N'0001661890628', 24, 0, 2450000, CAST(N'2018-06-16T00:00:00.000' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (36, 15, N'0001927576168', 24, 0, 2450000, CAST(N'2017-01-20T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), CAST(N'2018-12-30T00:00:00.000' AS DateTime), 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (37, 1032, N'0005935665494', 12, 0, 5100000, CAST(N'2018-06-17T12:20:19.987' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (38, 1032, N'0005553792700', 12, 0, 5100000, CAST(N'2018-06-17T12:20:19.987' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (39, 1032, N'0005423170254', 12, 0, 5100000, CAST(N'2018-06-17T12:20:19.993' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (40, 1032, N'0005967426065', 12, 0, 5100000, CAST(N'2018-06-17T12:20:20.003' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (41, 1032, N'0005878766973', 12, 0, 5100000, CAST(N'2018-06-17T12:20:20.010' AS DateTime), NULL, NULL, 1, N'No description', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (43, 18, N'110000', 10, 0, 200, CAST(N'2018-06-20T13:37:29.857' AS DateTime), NULL, NULL, 1, N'ko co gi', NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (44, 1035, N'0001116215764', 1, 0, 50000, CAST(N'2018-07-12T05:46:18.927' AS DateTime), NULL, NULL, 1, N'No description', 71)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (45, 1035, N'0001543305506', 1, 0, 50000, CAST(N'2018-07-12T05:46:18.943' AS DateTime), NULL, NULL, 1, N'No description', 71)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (46, 1035, N'0001250325188', 6, 0, 2500000, CAST(N'2018-07-12T08:21:03.440' AS DateTime), NULL, NULL, 1, N'No description', 71)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description], [TileID]) VALUES (47, 1035, N'0001163173723', 6, 0, 2500000, CAST(N'2018-07-12T00:00:00.000' AS DateTime), NULL, NULL, 1, N'No description', 70)
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItemHistory] ON 

INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (4, 36, 10, 1, 3, CAST(N'2018-07-10T06:17:57.483' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (5, 35, 10, 1, 3, CAST(N'2018-07-10T06:17:57.483' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (6, 11, 10, 1, 3, CAST(N'2018-07-10T06:17:57.483' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (7, 12, 10, 1, 3, CAST(N'2018-07-10T06:17:57.500' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (8, 12, 10, 3, 1, CAST(N'2018-07-10T06:19:50.443' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (9, 11, 10, 3, 1, CAST(N'2018-07-10T06:19:50.443' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (10, 35, 10, 3, 1, CAST(N'2018-07-10T06:19:50.457' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (11, 36, 10, 3, 1, CAST(N'2018-07-10T06:19:50.473' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (12, 17, 3, 1, NULL, CAST(N'2018-07-10T09:27:43.850' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (13, 16, 3, 1, NULL, CAST(N'2018-07-10T09:27:43.850' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (14, 17, 10, NULL, 3, CAST(N'2018-07-10T09:28:42.133' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (15, 16, 10, NULL, 3, CAST(N'2018-07-10T09:28:42.133' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (16, 16, 10, 3, 1, CAST(N'2018-07-10T21:17:55.137' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (17, 17, 10, 3, 1, CAST(N'2018-07-10T21:28:01.570' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (18, 5, 3, 1, NULL, CAST(N'2018-07-11T04:29:12.570' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (19, 6, 3, 1, NULL, CAST(N'2018-07-11T04:29:12.570' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (20, 4, 3, 1, NULL, CAST(N'2018-07-11T04:29:12.570' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (21, 6, 10, NULL, 3, CAST(N'2018-07-11T04:29:33.870' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (22, 4, 10, NULL, 3, CAST(N'2018-07-11T04:29:33.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (23, 5, 10, NULL, 3, CAST(N'2018-07-11T04:29:33.880' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (24, 4, 10, 3, 1, CAST(N'2018-07-10T21:30:45.320' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (25, 5, 10, 3, 1, CAST(N'2018-07-10T21:33:16.440' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (26, 6, 10, 3, 1, CAST(N'2018-07-10T21:35:33.900' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (27, 4, 3, 1, NULL, CAST(N'2018-07-11T04:36:58.037' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (28, 6, 3, 1, NULL, CAST(N'2018-07-11T04:36:58.037' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (29, 5, 3, 1, NULL, CAST(N'2018-07-11T04:36:58.037' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (30, 4, 10, NULL, 3, CAST(N'2018-07-11T04:38:31.177' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (31, 5, 10, NULL, 3, CAST(N'2018-07-11T04:38:31.177' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (32, 6, 10, NULL, 3, CAST(N'2018-07-11T04:38:31.187' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (33, 5, 10, 3, 1, CAST(N'2018-07-10T21:38:34.447' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (34, 4, 10, 3, 1, CAST(N'2018-07-10T21:38:37.913' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (35, 6, 10, 3, 1, CAST(N'2018-07-10T21:38:40.743' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (36, 5, 3, 1, NULL, CAST(N'2018-07-11T04:41:56.077' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (37, 5, 10, NULL, 3, CAST(N'2018-07-11T04:42:12.700' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (38, 5, 10, 3, 1, CAST(N'2018-07-10T21:42:28.353' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (39, 4, 3, 1, NULL, CAST(N'2018-07-11T04:50:34.547' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (40, 5, 3, 1, NULL, CAST(N'2018-07-11T04:50:34.577' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (41, 4, 10, NULL, 3, CAST(N'2018-07-11T04:50:59.300' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (42, 5, 10, NULL, 3, CAST(N'2018-07-11T04:50:59.300' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (43, 5, 10, 3, 1, CAST(N'2018-07-11T05:28:33.827' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (44, 4, 10, 3, 1, CAST(N'2018-07-11T05:37:04.297' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (45, 5, 3, 1, NULL, CAST(N'2018-07-11T05:40:22.670' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (46, 3, 3, 1, NULL, CAST(N'2018-07-11T05:40:22.677' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (47, 2, 3, 1, NULL, CAST(N'2018-07-11T05:40:22.683' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (48, 4, 3, 1, NULL, CAST(N'2018-07-11T05:40:22.697' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (49, 3, 10, NULL, 3, CAST(N'2018-07-11T05:40:34.723' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (50, 5, 10, NULL, 3, CAST(N'2018-07-11T05:40:34.727' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (51, 2, 10, NULL, 3, CAST(N'2018-07-11T05:40:34.730' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (52, 4, 10, NULL, 3, CAST(N'2018-07-11T05:40:34.730' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (53, 2, 10, 3, 1, CAST(N'2018-07-11T05:40:55.560' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (54, 3, 10, 3, 1, CAST(N'2018-07-11T05:40:55.587' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (55, 4, 10, 3, 1, CAST(N'2018-07-11T05:40:55.587' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (56, 5, 10, 3, 1, CAST(N'2018-07-11T05:40:55.587' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (57, 6, 3, 1, NULL, CAST(N'2018-07-11T13:58:09.840' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (58, 5, 3, 1, NULL, CAST(N'2018-07-11T13:58:09.840' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (59, 4, 3, 1, NULL, CAST(N'2018-07-11T13:58:09.840' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (60, 5, 10, NULL, 3, CAST(N'2018-07-11T13:58:31.770' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (61, 4, 10, NULL, 3, CAST(N'2018-07-11T13:58:31.770' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (62, 6, 10, NULL, 3, CAST(N'2018-07-11T13:58:31.780' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (63, 5, 10, 3, 1, CAST(N'2018-07-18T14:03:10.600' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (64, 6, 10, 3, 1, CAST(N'2018-07-18T14:03:10.613' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (65, 4, 10, 3, 1, CAST(N'2018-07-18T14:03:10.620' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (66, 4, 3, 1, NULL, CAST(N'2018-07-18T14:12:07.500' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (67, 4, 10, NULL, 3, CAST(N'2018-07-18T14:12:29.937' AS DateTime), NULL)
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (68, 4, 10, 3, 1, CAST(N'2018-07-29T14:14:47.203' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (69, 47, 8, 1, 8, CAST(N'2018-07-12T08:23:13.073' AS DateTime), N'')
INSERT [dbo].[EquipmentItemHistory] ([Id], [EquipmentItemID], [ByUserID], [OldStatusID], [NewStatusID], [Date], [Description]) VALUES (70, 47, 8, 8, 1, CAST(N'2018-07-12T08:24:51.187' AS DateTime), N'ok')
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
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (66, N'1', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (67, N'2', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (68, N'3', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (69, N'G', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (70, N'B1', 34, NULL)
INSERT [dbo].[Floor] ([Id], [Name], [BlockID], [Description]) VALUES (71, N'G', 1, NULL)
SET IDENTITY_INSERT [dbo].[Floor] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (1, N'Kho A', N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (2, N'Đại học FPT', N'Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (3, N'4S Linh Đông', N'20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (4, N'Misa Building', N'Lô 47, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Công trường', 106.629288, 10.852845, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (5, N'FPT Software', N'Lot T2, D1 Street, Saigon Hi-Tech Park, Dist 9, Phường Tân Phú, Quận 9, Hồ Chí Minh', N'Công trường', 106.79836, 10.850978, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (6, N'Sky Center ', N'10, Phổ Quang, Phường 2, Q. Tân Bình, Tp.HCM', N'Công trường', 106.666555, 10.805359, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (7, N'Cầu vượt Nguyễn Thái Sơn', N'Vòng xoay Phạm Văn Đồng - Hoàng Minh Giám, Q.Gò Vấp, TpHCM', N'Công trường', 106.678678, 10.813932, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531137149/photo-2-1486537416903.jpg.jpg', NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (8, N'FPT University', N'Toà nhà Innovation, lô 24, Công viên phần mềm Quang Trung, Quận 12, Hồ Chí Minh, Vietnam', N'this is fpt university', 106.62954480000008, 10.8529391, NULL, NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (9, N'Nha Chau', N'135 Yersin, Phú Cường, Thủ Dầu Một, Bình Dương, Vietnam', N'', 106.65972799999997, 10.9822488, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531259677/b%E1%BA%A3n%20thi%E1%BA%BFt%20k%E1%BA%BF%20nh%C3%A0%202.jpg.jpg', NULL)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode]) VALUES (10, N'CVPM QT', N'Tân Chánh Hiệp, District 12, Ho Chi Minh City, Vietnam', N'', 106.62652720000006, 10.8528103, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Location] OFF
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
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Employee')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Equipment Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (5, N'Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (6, N'Maintainer')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (1, N'xay dung abc', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (2, N'TeamA', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (3, N'TeamB', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (4, N'TeamC', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (5, N'TeamD', NULL)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 3, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 5, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 2, 5, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 2, 3, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 5, 12, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 5, 13, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 4, 14, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (9, 4, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (10, 4, 10, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (11, 3, 11, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (12, 3, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (13, 3, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (14, 5, 8, 1)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[TeamLocation] ON 

INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (1, 2, 2, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (2, 2, 4, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (5, 8, 3, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (6, 8, 1, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (7, 8, 2, CAST(N'2018-07-10T08:52:07.820' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (8, 9, 5, CAST(N'2018-07-10T08:52:48.703' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (9, 7, 2, CAST(N'2018-07-10T09:25:27.903' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (10, 7, 5, CAST(N'2018-07-10T09:25:27.920' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (11, 7, 3, CAST(N'2018-07-10T09:25:27.920' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (12, 10, 2, CAST(N'2018-07-12T08:39:37.350' AS DateTime), NULL)
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
SET IDENTITY_INSERT [dbo].[Tile] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([Id], [Name]) VALUES (1, N'máy')
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (2, N'xe')
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nộii', N'dailymayxaydung.com', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (2, N'FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'thietbivanphong.vn', N'Nguyễn Thanh Long', N'thietbivanphong@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (3, N'Công Ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', N'ggg')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Kim Thanh ', N'truonglongoto@gmail.com', N'Phone: (028) 37543188')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', N'Phone: (84 - 4) 3.6500478')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (8, N'Công Ty Cổ Phần Máy Công Trình Phúc Long', N'Số 420, QL 1A, KP 2, Tam Bình, Thủ Đức, TP. HCM', N'http://phuclong.com/', N'Bình Minh', N'info@phuclong.com', N'0988 012 717')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (10, N'Công Ty Cổ Phần Thiết Bị Xây Dựng Gia Phan', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (11, N'Công Ty TNHH Bình Lợi', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (12, N'công ty Kiến Tạo', N'111 Phù Đổng', N'kientao.com', N'Nguyễn Bê', N'', N'')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thiết bị xây dựng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thiết bị văn phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thiết bị cơ sở vật chất', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
SET IDENTITY_INSERT [dbo].[WorkOrder] ON 

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (23, N'Vinhomes 1', 8, CAST(N'2018-07-04T17:48:03.907' AS DateTime), NULL, NULL, N'', 2, 1009, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (24, N'Dự án Metro số 1', 8, CAST(N'2018-07-04T17:51:51.130' AS DateTime), NULL, NULL, N'', 3, 1009, 2, 2)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (25, N'Vinhomes 1', 8, CAST(N'2018-07-05T04:24:09.600' AS DateTime), NULL, NULL, N'', 3, 1009, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (26, N'Vinhomes 1', 8, CAST(N'2018-07-05T04:30:05.120' AS DateTime), NULL, NULL, N'', 1, 5, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (27, N'Midori Kouen', 8, CAST(N'2018-07-06T20:32:46.267' AS DateTime), NULL, CAST(N'2018-07-10T21:38:40.743' AS DateTime), N'', 1, 5, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (28, N'Logitech', 8, CAST(N'2018-07-07T03:16:55.737' AS DateTime), NULL, CAST(N'2018-07-10T21:30:45.320' AS DateTime), N'', 1, 5, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (29, N'Landmark 69', 8, CAST(N'2018-07-09T05:20:15.820' AS DateTime), NULL, NULL, N'', 2, 5, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (30, N'Lankmark 669', 7, CAST(N'2018-07-09T21:04:31.773' AS DateTime), NULL, NULL, N'', 2, 5, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (31, N'Cau vuot NTS', 8, CAST(N'2018-07-10T02:26:33.877' AS DateTime), NULL, CAST(N'2018-07-10T21:28:01.570' AS DateTime), N'', 1, 5, 2, 9)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (32, N'Nhà của anh Châu', 8, CAST(N'2018-07-10T21:49:13.337' AS DateTime), NULL, CAST(N'2018-07-11T05:28:33.827' AS DateTime), N'', 1, 5, 2, 8)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (33, N'Nha anh Chau', 8, CAST(N'2018-07-10T22:39:43.297' AS DateTime), NULL, CAST(N'2018-07-10T21:30:45.320' AS DateTime), N'', 1, 5, 2, 8)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (35, N'Cầu Phú Cường', 8, CAST(N'2018-07-11T06:53:13.623' AS DateTime), NULL, CAST(N'2018-07-18T14:03:10.617' AS DateTime), N'', 1, 5, 2, 8)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (36, N'Thử nghiệm', 8, CAST(N'2018-07-18T07:11:01.327' AS DateTime), NULL, CAST(N'2018-07-29T14:14:47.203' AS DateTime), N'', 2, 5, 2, 1)
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1087, 4, 23, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1088, 5, 23, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1089, 3, 23, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1090, 4, 24, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1091, 6, 24, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1092, 5, 24, CAST(N'2018-07-05T00:00:00.000' AS DateTime), CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1093, 5, 25, CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-08-09T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1094, 4, 25, CAST(N'2018-07-28T00:00:00.000' AS DateTime), CAST(N'2018-08-09T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1095, 5, 26, CAST(N'2018-07-19T00:00:00.000' AS DateTime), CAST(N'2018-07-26T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:42:28.353' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1096, 5, 27, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:38:34.447' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1097, 4, 27, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:38:37.913' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1098, 6, 27, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-25T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:38:40.743' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1099, 6, 28, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:35:33.900' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1100, 5, 28, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:33:16.440' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1101, 4, 28, CAST(N'2018-07-07T00:00:00.000' AS DateTime), CAST(N'2018-07-16T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:30:45.320' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1102, 36, 29, CAST(N'2018-07-09T00:00:00.000' AS DateTime), CAST(N'2018-07-11T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1103, 11, 29, CAST(N'2018-07-09T00:00:00.000' AS DateTime), CAST(N'2018-07-11T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1104, 35, 29, CAST(N'2018-07-09T00:00:00.000' AS DateTime), CAST(N'2018-07-11T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1105, 12, 29, CAST(N'2018-07-09T00:00:00.000' AS DateTime), CAST(N'2018-07-11T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1106, 16, 30, CAST(N'2018-07-11T00:00:00.000' AS DateTime), CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1107, 17, 31, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:28:01.570' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1108, 16, 31, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-10T21:17:55.137' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1109, 4, 32, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:37:04.293' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1110, 5, 32, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-20T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:28:33.827' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1111, 5, 33, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-14T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:40:55.550' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1112, 3, 33, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-14T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:40:55.550' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1113, 2, 33, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-14T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:40:55.553' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1114, 4, 33, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-14T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-11T05:40:55.550' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1115, 5, 35, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-18T14:03:10.593' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1116, 4, 35, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-18T14:03:10.617' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1117, 6, 35, CAST(N'2018-07-12T00:00:00.000' AS DateTime), CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-18T14:03:10.600' AS DateTime), NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [ExpectingStartDate], [ExpectingDueDate], [StartDate], [ClosedDate], [MaintainceCost], [Description]) VALUES (1118, 4, 36, CAST(N'2018-07-18T00:00:00.000' AS DateTime), CAST(N'2018-07-30T00:00:00.000' AS DateTime), CAST(N'2018-07-18T14:12:29.840' AS DateTime), CAST(N'2018-07-29T14:14:47.203' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] ON 

INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (1, 1108, 10, CAST(N'2018-07-10T21:17:55.137' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (2, 1107, 10, CAST(N'2018-07-10T21:28:01.570' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (3, 1101, 10, CAST(N'2018-07-10T21:30:45.320' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (4, 1100, 10, CAST(N'2018-07-10T21:33:16.440' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (5, 1099, 10, CAST(N'2018-07-10T21:35:33.900' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (6, 1096, 10, CAST(N'2018-07-10T21:38:34.447' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (7, 1097, 10, CAST(N'2018-07-10T21:38:37.913' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (8, 1098, 10, CAST(N'2018-07-10T21:38:40.743' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (9, 1095, 10, CAST(N'2018-07-10T21:42:28.353' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (10, 1110, 10, CAST(N'2018-07-11T05:28:33.823' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (11, 1109, 10, CAST(N'2018-07-11T05:37:04.290' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (12, 1114, 10, CAST(N'2018-07-11T05:40:55.540' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (13, 1111, 10, CAST(N'2018-07-11T05:40:55.540' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (14, 1112, 10, CAST(N'2018-07-11T05:40:55.550' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (15, 1113, 10, CAST(N'2018-07-11T05:40:55.553' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (16, 1115, 10, CAST(N'2018-07-18T14:03:10.587' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (17, 1117, 10, CAST(N'2018-07-18T14:03:10.590' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (18, 1116, 10, CAST(N'2018-07-18T14:03:10.613' AS DateTime), 1)
INSERT [dbo].[WorkOrderDetailReturn] ([Id], [WorkOrderDetailId], [ByUserId], [DateTime], [NewItemStatusId]) VALUES (19, 1118, 10, CAST(N'2018-07-29T14:14:47.187' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[WorkOrderDetailReturn] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] ON 

INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (16, 23, 8, CAST(N'2018-07-04T17:48:03.907' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (17, 24, 8, CAST(N'2018-07-04T17:51:51.130' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (21, 24, 8, CAST(N'2018-07-05T11:17:43.057' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (22, 23, 8, CAST(N'2018-07-05T11:18:13.093' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (23, 25, 8, CAST(N'2018-07-05T04:24:09.600' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (24, 25, 8, CAST(N'2018-07-05T11:25:07.630' AS DateTime), 1, 1009, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (25, 26, 8, CAST(N'2018-07-05T04:30:05.120' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (26, 27, 8, CAST(N'2018-07-06T20:32:46.267' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (27, 28, 8, CAST(N'2018-07-07T03:16:55.737' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (28, 29, 8, CAST(N'2018-07-09T05:20:15.820' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (29, 30, 7, CAST(N'2018-07-09T21:04:31.773' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (30, 30, 10, CAST(N'2018-07-10T04:32:15.323' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (31, 30, 3, CAST(N'2018-07-10T04:35:54.370' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (32, 30, 10, CAST(N'2018-07-10T04:37:04.213' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (33, 30, 10, CAST(N'2018-07-10T06:13:01.720' AS DateTime), 4, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (34, 29, 10, CAST(N'2018-07-10T06:14:38.083' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (35, 29, 3, CAST(N'2018-07-10T06:14:55.157' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (36, 29, 10, CAST(N'2018-07-10T06:17:57.420' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (37, 29, 10, CAST(N'2018-07-10T06:19:50.333' AS DateTime), 4, 5, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (38, 31, 8, CAST(N'2018-07-10T02:26:33.877' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (39, 31, 10, CAST(N'2018-07-10T09:27:05.870' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (40, 31, 3, CAST(N'2018-07-10T09:27:43.717' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (41, 31, 10, CAST(N'2018-07-10T09:28:42.087' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (42, 31, 10, CAST(N'2018-07-10T21:28:01.570' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (43, 28, 10, CAST(N'2018-07-11T04:28:59.050' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (44, 28, 3, CAST(N'2018-07-11T04:29:12.470' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (45, 28, 10, CAST(N'2018-07-11T04:29:33.630' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (46, 28, 10, CAST(N'2018-07-10T21:35:33.900' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (47, 27, 10, CAST(N'2018-07-11T04:36:44.633' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (48, 27, 3, CAST(N'2018-07-11T04:36:57.783' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (49, 27, 10, CAST(N'2018-07-11T04:38:30.997' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (50, 27, 10, CAST(N'2018-07-10T21:38:40.743' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (51, 26, 10, CAST(N'2018-07-11T04:41:35.987' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (52, 26, 3, CAST(N'2018-07-11T04:41:55.967' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (53, 26, 10, CAST(N'2018-07-11T04:42:12.493' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (54, 26, 10, CAST(N'2018-07-10T21:42:28.353' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (55, 32, 8, CAST(N'2018-07-10T21:49:13.337' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (56, 32, 10, CAST(N'2018-07-11T04:49:52.463' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (57, 32, 3, CAST(N'2018-07-11T04:50:34.457' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (58, 32, 10, CAST(N'2018-07-11T04:50:59.140' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (59, 32, 10, CAST(N'2018-07-11T05:37:04.293' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (60, 33, 8, CAST(N'2018-07-10T22:39:43.297' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (61, 33, 10, CAST(N'2018-07-11T05:40:10.020' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (62, 33, 3, CAST(N'2018-07-11T05:40:22.570' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (63, 33, 10, CAST(N'2018-07-11T05:40:34.620' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (64, 33, 10, CAST(N'2018-07-11T05:40:55.557' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (65, 33, 10, CAST(N'2018-07-11T05:40:55.560' AS DateTime), 5, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (66, 33, 10, CAST(N'2018-07-11T05:40:55.570' AS DateTime), 5, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (67, 33, 10, CAST(N'2018-07-11T05:40:55.583' AS DateTime), 5, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (69, 35, 8, CAST(N'2018-07-11T06:53:13.623' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (70, 35, 10, CAST(N'2018-07-11T13:55:56.910' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (71, 35, 3, CAST(N'2018-07-11T13:58:09.680' AS DateTime), 2, 3, N'hello from the other')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (72, 35, 10, CAST(N'2018-07-11T13:58:31.667' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (73, 35, 10, CAST(N'2018-07-18T14:03:10.620' AS DateTime), 4, 5, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (74, 36, 8, CAST(N'2018-07-18T07:11:01.327' AS DateTime), NULL, 1, N'')
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (75, 36, 10, CAST(N'2018-07-18T14:11:39.807' AS DateTime), 1, 2, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (76, 36, 3, CAST(N'2018-07-18T14:12:07.353' AS DateTime), 2, 3, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (77, 36, 10, CAST(N'2018-07-18T14:12:29.840' AS DateTime), 3, 4, NULL)
INSERT [dbo].[WorkOrderRecord] ([Id], [WorkOrderID], [ModifiedByUserID], [ModifiedByDateTime], [OldStatusID], [NewStatusID], [Description]) VALUES (78, 36, 10, CAST(N'2018-07-29T14:14:47.203' AS DateTime), 4, 5, N'')
SET IDENTITY_INSERT [dbo].[WorkOrderRecord] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] ON 

INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1, N'Requested')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (2, N'Checked')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (3, N'Approved')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (4, N'In Progress')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (5, N'Closed')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (6, N'Rejected')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1009, N'Cancelled')
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
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
/****** Object:  StoredProcedure [dbo].[CountQualityItem]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CountQualityItem]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Count(*) as Quality From EquipmentItem as ei Where  ei.EquipmentID = @id
	for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[CountWorkOrderByStatusId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountWorkOrderByStatusId]
	-- Add the parameters for the stored procedure here
	@statusid int
AS
BEGIN
    -- Insert statements for procedure here
	select count(*)
	from WorkOrder as wo
	where wo.StatusID = @statusid
END
GO
/****** Object:  StoredProcedure [dbo].[CreateLocationBlock]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateLocationBlock]
	-- Add the parameters for the stored procedure here
	@blockName nvarchar(50),
	@locationId int,
	@description nvarchar(250),
	@coordinate varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [Block]([Name], LocationID, [Description], Coordinate) values(@blockName, @locationId, @description, @coordinate);
	select(select SCOPE_IDENTITY()) as [NewBlockId] for json path, without_array_wrapper;
END
GO
/****** Object:  StoredProcedure [dbo].[CreateWorkOrder]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateWorkOrder] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(250),
	@requestUserId int, 
	@createDate datetime,
	@description nvarchar(250),
	@priorityId int,
	@statusId int,
	@categoryId int,
	@teamLocationId int
AS
BEGIN
	declare @newWorkOrderId int;
    insert into [WorkOrder]([Name], RequestUserID, CreateDate, [Description], PriorityID, StatusID, CategoryID, TeamLocationID)
		values(@name, @requestUserId, @createDate, @description, @priorityId, @statusId, @categoryId, @teamLocationId);
	set @newWorkOrderId = (select SCOPE_IDENTITY());
	select(@newWorkOrderId) as [NewWorkOrderId] for json path, without_array_wrapper;
	insert into WorkOrderRecord(WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description])
		values(@newWorkOrderId, @requestUserId, @createDate, null, @statusId, @description);
END
GO
/****** Object:  StoredProcedure [dbo].[CreateWorkOrderDetail]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateWorkOrderDetail]
	-- Add the parameters for the stored procedure here
	@workOrderId int,
	--@equipmentId int,
	@equipmentItemId int,
	@startDate datetime,
	@dueDate datetime,
	@maintainceCost float,
	@description text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @equipmentItemId int;
	
	--set @equipmentItemId = (select top 1 Id 
	--						from EquipmentItem 
	--						where EquipmentID = @equipmentId and Id not in (select ei.Id
	--																		from EquipmentItem as ei join WorkOrderDetail as wod on ei.Id = wod.EquipmentItemID
	--																		where wod.WorkOrderID = @workOrderId)
	--						);
    -- Insert statements for procedure here
	insert into WorkOrderDetail(EquipmentItemID, WorkOrderID, StartDate, FinishedDate, MaintainceCost, [Description])
		values(@equipmentItemId, @workOrderId, @startDate, @dueDate, @maintainceCost, @description);
	--update EquipmentItem set StatusId = 2 where Id = @equipmentItemId;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAccountDetailByAccId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAccountDetailByAccId]
	-- Add the parameters for the stored procedure here
	@accId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select acc.* , json_query((select * from [Role] where Id = acc.RoleID for json path, without_array_wrapper)) as [SystemRole],
			(select t.*, json_query((select * 
									 from TeamRoles 
									 where Id = (select TeamRoleID 
												 from TeamAccount 
												 where TeamID = t.Id and AccountID = @accId) for json path, without_array_wrapper)) as [TeamRole]
			from Team as t
			where Id in (select TeamId from TeamAccount where AccountID = @accId) for json path) as [Teams]
	from Account as acc where acc.Id = @accId
	for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllItemOfAnEquipment]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllItemOfAnEquipment] 
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ei.ID, ei.EquipmentID, ei.SerialNumber, ei.Price,CONVERT(date, ImportDate) as [ImportDate], 
	CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as [NextMaintainDate],
	ei.WarrantyDuration, ei.RuntimeDays, es.Name as Status, ei.Description
	From EquipmentItem as ei
	JOIN EquipmentStatus as es ON ei.StatusId = es.Id 
	Where ei.EquipmentID = @id
	for json path
END



GO
/****** Object:  StoredProcedure [dbo].[GetAnItem]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAnItem] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*SELECT ei.Id, ei.EquipmentID, ei.WarrantyDuration, ei.SerialNumber, ei.RuntimeDays, ei.Price,
	CONVERT(date, ImportDate) as [ImportDate], es.Name as Status, wod.Id as WorkOrderDetailID, wod.WorkOrderID, wo.Name as WorkOrderName, wo.CreateDate, wo.DueDate
	From EquipmentItem as ei
	JOIN EquipmentStatus as es ON ei.StatusId = es.Id, WorkOrderDetail as wod, WorkOrder as wo, WorkOrderStatus as wos
	Where  ei.ID = @id and 
			wod.EquipmentItemID = @id*/
			/*select WorkOrder.Name from WorkOrder where WorkOrder.StatusID < 5
			select WorkOrderDetail.Id from WorkOrderDetail where WorkOrderDetail.EquipmentItemID = @id*/

	/*SELECT *
	from WorkOrder as wo
	where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
										from WorkOrderDetail as wod
										where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																	 from EquipmentItem as ei
																	 where ei.Id = 12))*/

/*select ((select wo.*, (select e.*
			  from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
			  where ei.Id = @id for json path, without_array_wrapper) as [Equipment]
		from WorkOrder as wo
		where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
											from WorkOrderDetail as wod
											where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																			from EquipmentItem as ei
																			where ei.Id = @id))
		for json path) 
) as [Item]
for json path, without_array_wrapper*/

select (json_query((select  ei.Id,ei.SerialNumber, ei.Price, ei.WarrantyDuration, ei.RuntimeDays,CONVERT(date, ImportDate) as [ImportDate], es.Name as Status,
		CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as NextMaintainDate, ei.Description, (select wo.*
					  from WorkOrder as wo
					  where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
														  from WorkOrderDetail as wod
														  where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																					   from EquipmentItem as ei
																					   where ei.Id = @id))
					  for json path) as [WorkOrders]
		 from EquipmentItem as ei
		 JOIN EquipmentStatus as es on es.Id = ei.StatusId
		  --join EquipmentItem as ei on e.Id = ei.EquipmentID
		 where ei.Id = @id for json path, without_array_wrapper))
) as [Item]
for json path, without_array_wrapper

END
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentByID]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentByID] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', 
         e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn',
         e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', 
         v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', 
         ec.Name as 'Equipment.Category.Name', (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity],
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], 
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 2) as [Equipment.NotAvailableQuantity], 
		 (select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems]
     FROM [Equipment] as e 
				 JOIN [Vendor] as v ON e.VendorID = v.Id 
				 JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id
	Where e.Id = @id
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentInfoOfWorkOrderById]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentInfoOfWorkOrderById]
	-- Add the parameters for the stored procedure here
	@workOrderId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select e.Id, e.[Name], e.[Image], (select ei.*
									from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
															join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
										where wo.Id = @workOrderId and ei.EquipmentID = e.Id for json path) as [EquipmentItems]
	from Equipment as e
	where e.Id in (select distinct e.Id
					from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
					where ei.id in (select wod.EquipmentItemID
									from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
									where wo.Id = @workOrderId))
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentItemsForCreateWorkOrder]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentItemsForCreateWorkOrder]
	-- Add the parameters for the stored procedure here
	@equipmentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select ei.*, es.[Name] as [Status],
			-- select all work orders the equipment item are currently in
			-- the order status must not be 'Cancelled', 'Closed' and 'Rejected' because those statuses do not effect the status of the equipment item
			-- if the item has not in any work orders at the time, the [WorkOrders] will be NULL in the returned result;
			json_query((select wo.*, acc.[Username] as [RequestUsername], wos.[Name] as [Status], pri.[Name] as [Priority], pri.TagHexColor as [PriorityTagColor],
										json_query((select wod.*
												    from WorkOrderDetail as wod
												    where wod.EquipmentItemID = ei.Id and wod.WorkOrderID = wo.Id
												    for json path, without_array_wrapper)) as [Detail]
						 from WorkOrder as wo join Account as acc on wo.RequestUserID = acc.Id 
											  join WorkOrderStatus as wos on wo.StatusID = wos.Id
											  join [Priority] as pri on wo.PriorityID = pri.Id, (select Id 
																								from WorkOrderStatus 
																								where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected') as [status], 
																										(select wod.*
																										 from WorkOrderDetail as wod
																										 where wod.EquipmentItemID = ei.Id) as [workorderdetail]
						 where wo.StatusId = [status].Id and wo.Id = [workorderdetail].WorkOrderID
						 order by wo.StatusID desc, wo.PriorityID desc
						 for json path)) as [WorkOrders]
	from EquipmentItem as ei 
				join Equipment as e on ei.EquipmentID = e.Id
				join EquipmentStatus as es on ei.StatusId = es.Id
	where ei.EquipmentID = @equipmentId
	-- if an equipment item has not in any work order at the time, it must have more priority than others
	-- then we consider the runtime days, the less runtime days, the less the equipment item works in the construction site, so it must be choosen
	-- then we consider the last maintaince date, the farther the last maintaince, the more of chance the next maintaince happens, so we should choose the item that has last maintaince close from the current time
	-- last, from the time someone wants to create an work order, it's ideally to pick the item has next maintaince farther from the current time
	order by (select count(wo.Id) 
			  from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
			  where wod.EquipmentItemID = ei.Id and wo.StatusID in (select Id
																	from WorkOrderStatus
																	where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected')) asc, ei.RuntimeDays asc, ei.LastMaintainDate desc, ei.NextMaintainDate desc
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetEquipments]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipments]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', 
         e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn',
         e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', 
         v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId',
		 u.[Name] as [Equipment.Unit],
         ec.Name as 'Equipment.Category.Name', (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity],
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], 
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 2) as [Equipment.NotAvailableQuantity], 
		 (select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems]
     FROM [Equipment] as e 
				 JOIN [Vendor] as v ON e.VendorID = v.Id 
				 JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id
				 join Unit as u on e.UnitID = u.Id
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetLocationBlockFloorTile]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLocationBlockFloorTile]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select lo.*, (select bl.*, (select fl.*, (select ti.*
											  from Tile as ti
											  where ti.FloorID = fl.Id
											  for json path) as [Tiles]
								from [Floor] as fl
								where fl.BlockID = bl.Id
								for json path) as [Floors]
				  from [Block] as bl
				  where bl.LocationID = @locationId
				  for json path) as [Blocks]
	from [Location] as lo
	where lo.Id = @locationId
	for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamDetails]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamDetails]
	-- Add the parameters for the stored procedure here
	@teamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT t.id as 'Team.Id', t.Name as 'Team.Name', t.CreatedDate as 'Team.CreatedDate',
			acc.Fullname as 'Account.FullName', tr.TeamRole as 'TeamRole.Name'
		FROM [Team] as t	
					JOIN [TeamAccount] as ta ON t.Id = ta.TeamID
					JOIN [Account] as acc ON ta.AccountID =acc.Id
					JOIN [TeamRoles] as tr ON ta.TeamRoleID =tr.Id
			WHERE acc.Id = @teamId
			for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamDetailsByTeamId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamDetailsByTeamId]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--SELECT t.id as 'Team.Id', t.Name as 'Team.Name', t.CreatedDate as 'Team.CreatedDate',
--			acc.Fullname as 'Account.FullName', tr.TeamRole as 'TeamRole.Name'
--		FROM [Team] as t	
--					JOIN [TeamAccount] as ta ON t.Id = ta.TeamID
--					JOIN [Account] as acc ON ta.AccountID =acc.Id
--					JOIN [TeamRoles] as tr ON ta.TeamRoleID =tr.Id
--			WHERE t.Id = @teamId
--			for json path
SELECT t.id as 'team.Id', t.Name as 'team.Name', t.CreatedDate as 'team.CreatedDate',
			json_query((SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID=@Id and ta.TeamRoleID =1 for json path, without_array_wrapper)) as 'team.LeaderAccount',
			(SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID=@Id and ta.TeamRoleID =2 for json path) as 'team.MemberAccounts'
FROM [Team] as t				
WHERE t.Id = @Id
for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamFromLocationId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamFromLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select (json_query((select * from Team where Id = tl.TeamID for json path, without_array_wrapper))) as [Team]
	from TeamLocation as tl join Team as t on tl.TeamID = t.Id
	where tl.LocationID = @locationId
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamLocationId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int,
	@teamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Id
	from TeamLocation as tl
	where tl.LocationID = @locationId and tl.TeamID = @teamId
	for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByAccName]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByAccName]
	-- Add the parameters for the stored procedure here
	@accname nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select wo.*, acc.Id as 'Acc Id', acc.Fullname
	from WorkOrder as wo, (select * from Account where Fullname like '%' + @accname + '%') acc
	where  wo.RequestUserID = acc.Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByLocationId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetWorkOrderByLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select distinct wo.*, (select COUNT(*)
	from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID
		join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID
	where tl.LocationID = @locationId) as Quantity
	from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID
		join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID
	where tl.LocationID = @locationId
	for json path

	
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByStatusId]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByStatusId]
	-- Add the parameters for the stored procedure here
	@statusid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from WorkOrder as wo where wo.StatusID = @statusid
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByWorkOrderCategory]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByWorkOrderCategory]
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select *
	from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
	where wo.CategoryID = @categoryId
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderHasEquipmentBetweenStartDateAndDueDate]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderHasEquipmentBetweenStartDateAndDueDate]
	@equipmentId int,
	@startDate datetime,
	@dueStart datetime
AS
BEGIN
	select distinct wo.*, json_query((select wod.*, json_query((select ei.*
																from EquipmentItem as ei
																where ei.EquipmentID = @equipmentId
																for json path)) as EquipmentItem
									  from WorkOrderDetail as wod
									  where wod.WorkOrderId = wo.Id
									  for json path)) as [WorkOrderDetails]
	from WorkOrder as wo, (select distinct e.Id as [EquipmentId] , wo.Id as [WorkOrderId]
						   from WorkOrderDetail as wod join WorkOrder as wo on wod.WorkOrderID = wo.Id
														join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
														join Equipment as e on ei.EquipmentID = e.Id
						   where wo.StatusID in (select Id from WorkOrderStatus where [Name] != N'Cancelled' and [Name] != N'Closed')
									and ((@startDate between wod.StartDate and wod.FinishedDate) or (@dueStart between wod.StartDate and wod.FinishedDate))
							) as wde
	where wo.Id = wde.WorkOrderId and wde.EquipmentId = @equipmentId
	for json path
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrders]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrders]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],
																				json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location],
																				t.Id as [Team.Id], t.[Name] as [Team.Name], 
                                                                                 (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image]
                                                                                                                        from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id
                                                                                                                        where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							                                                                    from WorkOrderDetail as wod
							                                                                    where wod.WorkOrderID = wo.Id
                			                                                         for json path))) as [WorkOrderDetails], (select wor.*, json_query((select [Name] 
																																						from WorkOrderStatus 
																																						where wor.OldStatusID = Id 
																																						for json path, without_array_wrapper)) as [OldStatus],
																																				json_query((select [Name] 
																																							from WorkOrderStatus 
																																							where wor.NewStatusID = Id 
																																							for json path, without_array_wrapper)) as NewStatus,
																																					json_query((select acc.*, ro.[Name] as [Role]
																																								from Account as acc join [Role] as ro on acc.RoleID = ro.Id
																																								where acc.Id = wor.ModifiedByUserID
																																								for json path, without_array_wrapper)) as [ModifiedUser]
																															  from WorkOrderRecord as wor 
																															  where wor.WorkOrderID = wo.Id
																															  order by wor.ModifiedByDateTime desc
																															  for json path) as [WorkOrderRecord]
                     from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
	                                      join Account as acc on wo.RequestUserID = acc.Id
                                          join [Priority] as p on wo.PriorityID = p.Id
										  join TeamLocation as tl on wo.TeamLocationID = tl.Id
										  join Team as t on tl.TeamID = t.Id
                     order by wo.CreateDate desc
                for json path) as [WorkOrders] for json path, without_array_wrapper
END
GO
/****** Object:  StoredProcedure [dbo].[SearchWorkOrder]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchWorkOrder] 
	-- Add the parameters for the stored procedure here
	@searchValue nvarchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select wo.*
	--from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
	--		join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
	--		join Equipment as e on ei.EquipmentID = e.Id
	--		join Account as acc on wo.RequestUserID = acc.Id
	----where acc.Fullname like '%' + @searchValue + '%'
	--where (cast(wo.Id as nvarchar) like '%' + @searchValue + '%') or (acc.Fullname like '%' + @searchValue + '%') or (acc.Username like '%' + @searchValue + '%') 
	--		 or (ei.SerialNumber like '%' + @searchValue + '%')
	--for json path

	select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],
																				json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location],
																				t.Id as [Team.Id], t.[Name] as [Team.Name], 
                                                                                 (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image]
                                                                                                                        from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id
                                                                                                                        where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							                                                                    from WorkOrderDetail as wod
							                                                                    where wod.WorkOrderID = wo.Id
                			                                                         for json path))) as [WorkOrderDetails]
            from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
	                            join Account as acc on wo.RequestUserID = acc.Id
                                join [Priority] as p on wo.PriorityID = p.Id
								join TeamLocation as tl on wo.TeamLocationID = tl.Id
								join Team as t on tl.TeamID = t.Id
			where wo.Id in (select wo.Id
							from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
									join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
									join Equipment as e on ei.EquipmentID = e.Id
									join Account as acc on wo.RequestUserID = acc.Id
							where (cast(wo.Id as nvarchar) like '%' + @searchValue + '%') or (acc.Fullname like '%' + @searchValue + '%') 
									or (acc.Username like '%' + @searchValue + '%') or (ei.SerialNumber like '%' + @searchValue + '%'))
			order by wo.CreateDate desc
    for json path) as [WorkOrders] for json path, without_array_wrapper

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEquipmentItem_Tien]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEquipmentItem_Tien] 
	-- Add the parameters for the stored procedure here
	@id int,
	@warrantyDuration int,
	@runtimeDays int,
	@price float,
	@importdate datetime,
	@lastmaintaindate datetime,
	@nextmaintaindate datetime,
	@statusId int,
	@description nvarchar(250)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update EquipmentItem
	SET WarrantyDuration = @warrantyDuration, RuntimeDays = @runtimeDays, Price = @price, ImportDate = @importdate,
	LastMaintainDate = @lastmaintaindate, NextMaintainDate =@nextmaintaindate, StatusId = @statusId, Description = @description
	WHERE Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEquipmentItemStatus]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEquipmentItemStatus]
	-- Add the parameters for the stored procedure here
	@itemId int,
	@userId int,
	--@oldStatus int,
	@newStatus int,
	@date datetime,
	@description nvarchar(250)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @currentItemStatusId int;
	set @currentItemStatusId = (select StatusID from EquipmentItem where Id = @itemId);

    -- Insert statements for procedure here
	update EquipmentItem set StatusId = @newStatus where Id = @itemId;
	insert into EquipmentItemHistory(EquipmentItemID, ByUserID, OldStatusID, NewStatusID, [Date], [Description])
		values(@itemId, @userId, @currentItemStatusId, @newStatus, getdate(), @description)
--insert into 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateWorkOrderStatus]    Script Date: 7/12/2018 12:44:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateWorkOrderStatus]
	-- Add the parameters for the stored procedure here
	@workOrderId int,
	@userId int,
	-- @oldWorkOrderStatusName nvarchar(50),
	@newWorkOrderStatusName nvarchar(50),
	@description nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @workOrderCategoryName nvarchar(50);
	--declare @equipmentItemId int;
	--declare @equipmentItemNewStatusId int;
	declare @currentDate datetime;
	declare @oldWorkOrderStatusId int;
	declare @newWorkOrderStatusId int;

	set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId);
	set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = @newWorkOrderStatusName);
	--declare @newEquipmentStatusName nvarchar(255);

	--set @newEquipmentStatusName = NULL;
	
	set @currentDate = getdate();

	-- get category of work order
	--set @workOrderCategoryName = (select woc.[Name]
	--							  from WorkOrder as wo join WorkOrderCategory as woc on wo.CategoryID = woc.Id 
	--							  where wo.Id = @workOrderId);
	
	-- get equipment items in work order
	--select ei.* into #equipmentItems 
	--from WorkOrderDetail as wod join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
	--where wod.WorkOrderID = @workOrderId

    -- update work order status and insert new record to work order record
	update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId;
	insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) 
		values(@workOrderId, @userId, @currentDate, @oldWorkOrderStatusId, @newWorkOrderStatusId, @description);

	-- update equipment item status and insert new record to equipment item history
	--if @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'Approved')
	--begin
	--	if @workOrderCategoryName = N'Working'
	--	begin
			-- get equipment status id of 'Working Requested'
	--		set @equipmentItemNewStatusId = (select Id from EquipmentStatus where [Name] = N'Working Requested');			
	--		set @newEquipmentStatusName = N'Working Requested';
	--	end
	--	else if @workOrderCategoryName = N'Maintain'
	--	begin
			-- get equipment status id of 'Working Requested'
	--		set @equipmentItemNewStatusId = (select Id from EquipmentStatus where [Name] = N'Maintain Requested');
	--		set @newEquipmentStatusName = N'Maintain Requested';
	--	end
--	end
--	else if @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'In Progress')
--	begin
--		if @workOrderCategoryName = N'Working'
--		begin
--			-- get equipment status id of 'Working Requested'
--			set @equipmentItemNewStatusId = (select Id from EquipmentStatus where [Name] = N'Working');
--			set @newEquipmentStatusName = N'Working';
--		end
--		else if @workOrderCategoryName = N'Maintain'
--		begin
			-- get equipment status id of 'Working Requested'
--			set @equipmentItemNewStatusId = (select Id from EquipmentStatus where [Name] = N'Maintaining');		
--			set @newEquipmentStatusName = N'Maintaining';		
--		end 
--	end
--	else if @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'In Progress')


--	if @newEquipmentStatusName != NULL
--	begin
		-- iterate the temp table #equipmentItems
--		while exists(select * from #equipmentItems)
--			begin
--				declare @equipmentItemCurrentStatusId int;				
--				declare @oldEquipmentStatusName nvarchar(255);
--				
--				select top 1
--				@equipmentItemId = Id,
--				@equipmentItemCurrentStatusId = StatusId
--				from #equipmentItems
--				order by Id asc;

				-- update equipment item status
--				update EquipmentItem
--				set StatusId = @equipmentItemNewStatusId
--				where Id = @equipmentItemId;

				-- insert new record to EquipmentItemHistory
--				insert into EquipmentItemHistory(EquipmentItemID, ByUserID, OldStatusID, NewStatusID, [Date], [Description])
--					values(@equipmentItemId, @userId, @equipmentItemCurrentStatusId, @equipmentItemNewStatusId, @currentDate, N'Change work order status from ' + @oldEquipmentStatusName + N' to ' + @newEquipmentStatusName);

--				delete #equipmentItems where Id = @equipmentItemId;
--			end
		-- delete temp table #equipmentItems
--		drop table #equipmentItems;
--	end
		
END
GO
USE [master]
GO
ALTER DATABASE [EquipmentManageSystem] SET  READ_WRITE 
GO
