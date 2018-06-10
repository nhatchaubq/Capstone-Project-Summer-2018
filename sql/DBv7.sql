USE [master]
GO
/****** Object:  Database [EquipmentManageSystem]    Script Date: 6/9/2018 12:31:23 PM ******/
CREATE DATABASE [EquipmentManageSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EquipmentManageSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EquipmentManageSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EquipmentManageSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EquipmentManageSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EquipmentManageSystem] SET COMPATIBILITY_LEVEL = 140
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
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
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
/****** Object:  Table [dbo].[Account]    Script Date: 6/9/2018 12:31:23 PM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 6/9/2018 12:31:23 PM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 6/9/2018 12:31:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[VendorID] [int] NULL,
	[Image] [nvarchar](250) NULL,
	[Price] [float] NULL,
	[MadeIn] [nvarchar](50) NULL,
	[Weight] [float] NULL,
	[Description] [nvarchar](250) NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK__Equipmen__3214EC0703B82630] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 6/9/2018 12:31:24 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 6/9/2018 12:31:24 PM ******/
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
	[ImportDate] [datetime] NULL,
	[StatusId] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[PositionID] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK__Equipmen__3214EC07D8BED705] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 6/9/2018 12:31:24 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 6/9/2018 12:31:24 PM ******/
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
 CONSTRAINT [PK__Location__3214EC0780403FED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 6/9/2018 12:31:24 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 6/9/2018 12:31:25 PM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 6/9/2018 12:31:25 PM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 6/9/2018 12:31:25 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 6/9/2018 12:31:25 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 6/9/2018 12:31:26 PM ******/
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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 6/9/2018 12:31:26 PM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 6/9/2018 12:31:26 PM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 6/9/2018 12:31:26 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 6/9/2018 12:31:26 PM ******/
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
/****** Object:  Table [dbo].[VendorType]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 6/9/2018 12:31:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentItemID] [int] NULL,
	[WorkOrderID] [int] NULL,
	[StartDate] [datetime] NULL,
	[FinishedDate] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
	[MaintainceCost] [float] NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_WorkOrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderDetailRecord]    Script Date: 6/9/2018 12:31:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetailRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderDetailId] [int] NOT NULL,
	[ModifiedByUserId] [int] NOT NULL,
	[ModifiedByDateTime] [datetime] NOT NULL,
	[OldEquipmentStatusId] [int] NOT NULL,
	[NewEquipmentStatusId] [int] NOT NULL,
 CONSTRAINT [PK_WorkOrderDetailRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 6/9/2018 12:31:27 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 6/9/2018 12:31:27 PM ******/
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

INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (2, N'admin', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:20:49.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'TienNT', N'123456', NULL, N'Thanh Tien', NULL, 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'KhanhPM', N'123456', NULL, N'Minh Khanh', NULL, 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'staff', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'nhatchau', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 1, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', NULL, N'Thanh Hau', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'HoangNH', N'123456', NULL, N'Huy Hoang', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (11, N'DienDTL', N'123456', NULL, N'Lam Dien', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (12, N'ThanhNT', N'123456', NULL, N'Ngoc Thanh', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (13, N'HungNT', N'123456', NULL, N'Thanh Hung', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (14, N'NgocHT', N'123456', NULL, N'Tuan Ngoc', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'Huy', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (1, NULL, N'Marketing')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (2, NULL, N'IT')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (3, NULL, N'Thi công công trình')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (4, NULL, N'Administrator')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (5, NULL, N'Construction')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (6, NULL, N'Office')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', 11450000, N'Japan', 8.7, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', 3450000, N'China', 5.8, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/may-khoan-rut-loi-ken-6200n.jpg', 6800000, N'China', 20.5, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', 2950000, N'Puma', 20, NULL, 4)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (5, N'
Panasonic Laser Fax KX-FLB882', 2, N'http://www.mucinhanoi.vn/images/201204/goods_img/612_G_1334278634575.jpg', 8290000, N'Japan', 2.5, NULL, 5)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (6, N'Samsung SC25H', 1, N'http://xenangvinacoma.com/upload/images/IMG_4147.JPG', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (7, N'Hitachi EX8000-6', 2, N'http://www.hitachiconstruction.com/wp-content/uploads/2015/10/EX8000_6_HERO.jpg', NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (8, N'SAMSUNG SC50H', 1, N'http://truongthanhauto.com/FileUpload/Images/can_cau_samsung__tan_.JPG', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (9, N'KOMATSU FD250-2', 4, N'http://truongthanhauto.com/FileUpload/Images/xenanghangkomatsufdtan_.jpg', NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (10, N'KOMATSU FD60-5', 4, N'http://truongthanhauto.com/FileUpload/Images/komatsu__tan_.JPG', NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (11, N'TCM FD135Z', 4, N'http://truongthanhauto.com/FileUpload/Images/xenanghangtcmtan__13.JPG', NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (12, N'Kato NK-800', 4, N'http://truongthanhauto.com/FileUpload/Images/cancaubanhlopkatotan__1.jpg', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (13, N'SAMSUNG SC50H', 1, N'http://truongthanhauto.com/FileUpload/Images/thumb/can_cau_samsung__tan_.JPG', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (14, N'Máy đầm cóc chạy điện HCD100 (3KW) 380V', 1, N'http://dailymayxaydung.com/wp-content/uploads/2017/09/dam_coc_hcd100.jpg', 6800000, N'China', 7, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (15, N'Búa hơi đục bê tông G10', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg', 1650000, N'China', 10, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (16, N'Máy đo khoảng cách laser Bosch GLM30 (30m)
', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/08/Bosch-GML30-400x400.jpg', 1980000, N'Malaysia', 1.4, NULL, 10)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (17, N'Máy đo khoảng cách Leica Disto D510 (200m)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2018/05/leica_disto_d510-400x400.jpg', 16500000, N'Hungary', 1.5, NULL, 10)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (18, N'Máy khoan bàn 600mm hồng ký KD600', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may-khoan-ban-hong-ky-hk-kd600.gif', 1800000, N'VietNam', 18.5, NULL, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (19, N'Máy trộn bê tông cam 250L', 1, N'http://dienmaysaoviet.vn//app/webroot/upload/image/images/M%C3%A1y%20tr%E1%BB%99n%20b%C3%AA%20t%C3%B4ng%20250L.jpg', 2700000, N'VietNam', 15, NULL, 1)
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
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (1, 4, N'10101012', 6, 12, NULL, 1, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (2, 4, N'10101013', 6, 10, NULL, 1, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (3, 4, N'10101014', 6, 5, NULL, 2, NULL, 9, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (4, 2, N'1212900', 12, 45, NULL, 1, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (5, 2, N'1212901', 12, 3, NULL, 2, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (6, 2, N'1212903', 12, 50, NULL, 1, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (7, 5, N'109021101', 12, 64, NULL, 1, NULL, 3, 1)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (8, 5, N'109021109', 12, 75, NULL, 2, NULL, 4, 2)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (9, 16, N'1110245222311', 18, 0, NULL, 2, NULL, 9, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (10, 16, N'1110242566178', 18, 0, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (11, 15, N'2020154022532', 6, 100, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (12, 15, N'2020154322210', 6, 30, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (13, 18, N'1245543156741', 3, 10, NULL, 2, NULL, 9, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (14, 18, N'1245543156751', 3, 20, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (15, 18, N'1245543256435', 3, 21, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (16, 19, N'1134578122221', 6, 15, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (17, 19, N'1134578122652', 6, 26, NULL, 2, NULL, 5, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (18, 19, N'1134578122543', 6, 57, NULL, 2, NULL, 6, NULL)
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[EquipmentStatus] ON 

INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (1, N'AVAILABLE')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (2, N'UNAVAILABLE')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (3, N'BROKEN')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (4, N'LOST')
SET IDENTITY_INSERT [dbo].[EquipmentStatus] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (1, N'Kho A', N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (2, N'Đại học FPT', N'Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (3, N'4S Linh Đông', N'20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (4, N'Misa Building', N'Lô 47, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Công trường', 106.629288, 10.852845)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (5, N'FPT Software', N'Lot T2, D1 Street, Saigon Hi-Tech Park, Dist 9, Phường Tân Phú, Quận 9, Hồ Chí Minh', N'Công trường', 106.79836, 10.850978)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (6, N'Sky Center ', N'10, Phổ Quang, Phường 2, Q. Tân Bình, Tp.HCM', N'Công trường', 106.666555, 10.805359)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (7, N'Cầu vượt Nguyễn Thái Sơn', N'Vòng xoay Phạm Văn Đồng - Hoàng Minh Giám, Q.Gò Vấp, TpHCM', N'Công trường', 106.678678, 10.813932)
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

INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (1, N'High', N'Red')
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
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (1, N'xay dung abc', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (2, N'TeamA', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (3, N'TeamB', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (4, N'TeamC', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (5, N'TeamD', NULL)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 3, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 5, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 2, 5, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 2, 3, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 5, 12, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 5, 13, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 4, 14, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (9, 4, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (10, 4, 10, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (11, 3, 11, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (12, 3, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (13, 3, 9, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[TeamRoles] ON 

INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (1, N'Leader')
INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[TeamRoles] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nộii', N'dailymayxaydung.com', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (2, N'FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'thietbivanphong.vn', N'Nguyễn Thanh Long', N'thietbivanphong@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (3, N'Công Ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', N'Phone: +65 6265-2377')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Kim Thanh ', N'truonglongoto@gmail.com', N'Phone: (028) 37543188')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', N'Phone: (84 - 4) 3.6500478')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thiết bị xây dựng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thiết bị văn phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thiết bị cơ sở vật chất', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
SET IDENTITY_INSERT [dbo].[WorkOrder] ON 

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (1, N'Order 4S Linh Đông', 5, NULL, NULL, NULL, NULL, 1, 1, 2, NULL)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (2, N'Order Misa', 11, NULL, CAST(N'2018-06-02T23:27:08.410' AS DateTime), NULL, NULL, 1, 1, 2, NULL)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (3, N'Order Misa', 11, NULL, NULL, NULL, NULL, 1, 4, 2, NULL)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [CategoryID], [TeamLocationID]) VALUES (4, N'Order 4S Linh ĐÔng', 5, NULL, NULL, NULL, NULL, 1, 4, 2, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (1, 5, 1, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (2, 8, 1, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (3, 17, 3, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (4, 18, 3, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (5, 13, 4, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (6, 3, 4, NULL, NULL, NULL, NULL, N'Remember to return ontime')
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (7, 9, 4, NULL, NULL, NULL, NULL, N'Remember to return ontime')
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] ON 

INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1, N'Request')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (2, N'Checked')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (3, N'Approve')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (4, N'Deliver')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (5, N'Return')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (6, N'Closed')
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_EquipmentCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[EquipmentCategory] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_EquipmentCategory]
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
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_Position]
GO
ALTER TABLE [dbo].[Position]  WITH CHECK ADD  CONSTRAINT [FK_Position_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[Position] CHECK CONSTRAINT [FK_Position_Location]
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
ALTER TABLE [dbo].[WorkOrderDetailRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailRecord_Account] FOREIGN KEY([ModifiedByUserId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord] CHECK CONSTRAINT [FK_WorkOrderDetailRecord_Account]
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailRecord_WorkOrderDetail] FOREIGN KEY([WorkOrderDetailId])
REFERENCES [dbo].[WorkOrderDetail] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord] CHECK CONSTRAINT [FK_WorkOrderDetailRecord_WorkOrderDetail]
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
/****** Object:  StoredProcedure [dbo].[CountWorkOrderByStatusId]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByAccName]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByProjectName]    Script Date: 6/9/2018 12:31:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByProjectName]
	-- Add the parameters for the stored procedure here
	@projectName nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select wo.*, p.Id as 'Project Id', p.[Name] as 'Project Name'
	from WorkOrder as wo, (select * from Project where [Name] like '%' + @projectName + '%') as p
	where wo.ProjectId = p.Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByStatusId]    Script Date: 6/9/2018 12:31:27 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByWorkOrderCategory]    Script Date: 6/9/2018 12:31:27 PM ******/
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
USE [master]
GO
ALTER DATABASE [EquipmentManageSystem] SET  READ_WRITE 
GO
