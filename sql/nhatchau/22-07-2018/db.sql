/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [EquipmentManageSystem]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[AccountNotification]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 7/22/2018 12:26:35 PM ******/
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
 CONSTRAINT [PK__Equipmen__3214EC0703B82630] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Floor]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 7/22/2018 12:26:35 PM ******/
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
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__Location__3214EC0780403FED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaintenanceDuration]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Tile]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[VendorType]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 7/22/2018 12:26:35 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 7/22/2018 12:26:35 PM ******/
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
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'staff', N'123456', NULL, N'Staff', NULL, 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', NULL, N'Quoc Viet', NULL, 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'teamleader', N'123456', NULL, N'Bùi Quang Nhật Châu', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', NULL, N'Thanh Hau', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'estaff', N'123456', NULL, N'Huy Hoang', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (11, N'DienDTL', N'123456', NULL, N'Lam Dien', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (12, N'ThanhNT', N'123456', NULL, N'Ngoc Thanh', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (13, N'HungNT', N'123456', NULL, N'Thanh Hung', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (14, N'NgocHT', N'123456', NULL, N'Tuan Ngoc', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'Huy', N'123456', NULL, N'Nhat Huy', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (16, N'chau', N'123456', NULL, N'bao chau', NULL, NULL, NULL, NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (17, N'DienDTL', N'123456', N'', N'Đoàn Trọng Lam Điền', N'0123999888', NULL, CAST(N'1996-06-13T00:00:00.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (18, N'ChauBQN', N'123456', N'nhatchau.bq@gmail.com', N'Bui Quang Nhat Chau', N'0927234234', 1, CAST(N'2018-07-19T00:19:04.537' AS DateTime), NULL, 3, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (1, N'Block A', 1, NULL, NULL, 1, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (2, N'Block B', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (3, N'Block A1', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (4, N'Block A2', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (5, N'Block A3', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (6, N'Block A', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (33, N'1', 7, NULL, N'[{"x":0,"y":0},{"x":500,"y":0},{"x":500,"y":350},{"x":0,"y":350}]', 2, 0)
INSERT [dbo].[Block] ([Id], [Name], [LocationID], [Description], [Coordinate], [TotalFloor], [TotalBasementFloor]) VALUES (34, N'Nha anh Chau', 9, NULL, N'[{"x":0,"y":0},{"x":460,"y":0},{"x":460,"y":296},{"x":0,"y":296}]', 5, 1)
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

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', N'Japan', NULL, 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', N'China', NULL, 1, 3, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/35553276_1397515960392211_9183626838994321408_n.jpg?_nc_cat=0&oh=ce5ff292839ea9d2409a8590d39ed08e&oe=5BB5BACF', N'Hàn Quốc', N'Update', 1, 2, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', N'Puma', NULL, 1, 4, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (5, N'
Panasonic Laser Fax KX-FLB882', 2, N'http://www.mucinhanoi.vn/images/201204/goods_img/612_G_1334278634575.jpg', N'Japan', NULL, 1, 5, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (14, N'Máy đầm cóc chạy điện HCD100 (3KW) 380V', 1, N'http://dailymayxaydung.com/wp-content/uploads/2017/09/dam_coc_hcd100.jpg', N'China', NULL, 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (15, N'Búa hơi đục bê tông G10', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg', N'China', NULL, 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (16, N'Máy đo khoảng cách laser Bosch GLM30 (30m)
', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/08/Bosch-GML30-400x400.jpg', N'Malaysia', NULL, 1, 10, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (17, N'Máy đo khoảng cách Leica Disto D510 (200m)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_bom_SEV50X.jpg', N'Hungary', N'ASSD', 1, 10, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (18, N'Máy khoan bàn 600mm hồng ký KD600', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may-khoan-ban-hong-ky-hk-kd600.gif', N'VietNam', NULL, 1, 2, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (19, N'Máy trộn bê tông cam 250L', 1, N'http://dienmaysaoviet.vn//app/webroot/upload/image/images/M%C3%A1y%20tr%E1%BB%99n%20b%C3%AA%20t%C3%B4ng%20250L.jpg', N'VietNam', NULL, 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1028, N'Máy hàn que Maxi 300', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_han_que_maxi_300.jpg', N'China', NULL, 1, 3, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1031, N'Máy tiện ren ống Lushun Zit-N50 (21-60mm)', 1, N'http://res.cloudinary.com/deanwflps/image/upload/v1528885003/e60k0wfkx64osout7qjs.jpg', N'China', N'Nhập thử lần đầu 1 sp', 1, 2, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1032, N'Máy bơm nước Koshin SEV 50X (3.1KW)', 11, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/may_bom_SEV50X.jpg', N'Nhật Bản - USA', N'ABCD', 1, 10, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1033, N'may duoi sat cat sat 2-5GT', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531271427/may_duoi_sat_gt2-5-400x400.jpg.jpg', N'Viet Nam', N'demo', 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1034, N'may_duoi_sat_gt2-5', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531271427/may_duoi_sat_gt2-5-400x400.jpg.jpg', N'Nhật Bản', N'demo', 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1035, N'Máy duỗi sắt GT2-7', 1, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531349130/1.jpg.jpg', N'', N'test demo', 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1036, N'Máy xúc Komatsu 001', 13, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531306438/17.jpg.jpg', N'China', N'description', 1, 1, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1037, N'Máy hàn', 2, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531188545/may_han_que_maxi_300.jpg.jpg', N'China', N'', 1, 3, NULL)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [MadeIn], [Description], [UnitID], [CategoryID], [MaintenanceDurationID]) VALUES (1038, N'Máy hàn que2', 2, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531188545/may_han_que_maxi_300.jpg.jpg', N'China', N'', 1, 3, NULL)
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
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (13, N'Văn phòng phẩm', NULL)
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (1, 4, N'10101012', NULL, 6, 12, 71, 2950000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (2, 4, N'10101013', NULL, 6, 10, 71, 2950000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (3, 4, N'10101014', NULL, 6, NULL, 71, 2950000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (7, 5, N'109021101', NULL, 12, NULL, 71, 8290000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (8, 5, N'109021109', NULL, 12, 75, 71, 8290000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (9, 16, N'1110245222311', NULL, 18, 0, 71, 1980000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (10, 16, N'1110242566178', NULL, 18, 0, 71, 1980000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (11, 15, N'2020154022532', NULL, 6, NULL, 71, 1650000, CAST(N'2017-01-10T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), 1, N'Mới update')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (12, 15, N'2020154322210', NULL, 6666, 6666, 71, 6666, CAST(N'2017-10-01T00:00:00.000' AS DateTime), CAST(N'2018-04-19T00:00:00.000' AS DateTime), CAST(N'2018-07-19T00:00:00.000' AS DateTime), 1, N'ahihi')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (13, 18, N'1245543156741', NULL, 3, 10, 71, 1800000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (14, 18, N'1245543156751', NULL, 3, 20, 71, 1800000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (15, 18, N'1245543256435', NULL, 3, 21, 71, 1800000, CAST(N'2018-06-16T15:55:17.107' AS DateTime), NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (16, 19, N'1134578122221', NULL, 6, 18, 71, 2700000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (17, 19, N'1134578122652', NULL, 6, 29, 71, 2700000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (18, 19, N'1134578122543', NULL, 6, 60, 71, 2700000, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (35, 15, N'0001661890628', NULL, 24, NULL, 71, 2450000, CAST(N'2018-06-16T00:00:00.000' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (36, 15, N'0001927576168', NULL, 24, NULL, 71, 2450000, CAST(N'2017-01-20T00:00:00.000' AS DateTime), CAST(N'2018-05-30T00:00:00.000' AS DateTime), CAST(N'2018-12-30T00:00:00.000' AS DateTime), 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (37, 1032, N'0005935665494', NULL, 12, 0, 71, 5100000, CAST(N'2018-06-17T12:20:19.987' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (38, 1032, N'0005553792700', NULL, 12, 0, 71, 5100000, CAST(N'2018-06-17T12:20:19.987' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (39, 1032, N'0005423170254', NULL, 12, 0, 71, 5100000, CAST(N'2018-06-17T12:20:19.993' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (40, 1032, N'0005967426065', NULL, 12, 0, 71, 5100000, CAST(N'2018-06-17T12:20:20.003' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (41, 1032, N'0005878766973', NULL, 12, 0, 71, 5100000, CAST(N'2018-06-17T12:20:20.010' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (43, 18, N'110000', NULL, 10, 0, 71, 200, CAST(N'2018-06-20T13:37:29.857' AS DateTime), NULL, NULL, 1, N'ko co gi')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (44, 1035, N'0001116215764', NULL, 1, NULL, 71, 50000, CAST(N'2018-07-12T05:46:18.927' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (45, 1035, N'0001543305506', NULL, 1, NULL, 71, 50000, CAST(N'2018-07-12T05:46:18.943' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (46, 1035, N'0001250325188', NULL, 6, NULL, 71, 2500000, CAST(N'2018-07-12T08:21:03.440' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (47, 1035, N'0001163173723', NULL, 6, NULL, 71, 2500000, CAST(N'2018-07-12T00:00:00.000' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (48, 1034, N'0001507044089', NULL, 1, 0, 71, 50000, CAST(N'2018-07-18T23:54:42.780' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (49, 2, N'0003955455318', NULL, 1, 0, 71, 50000, CAST(N'2018-07-19T00:08:52.553' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (50, 2, N'0003451880969', NULL, 1, 0, 71, 50000, CAST(N'2018-07-19T00:08:52.560' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (51, 2, N'0003851085400', NULL, 1, 0, 71, 50000, CAST(N'2018-07-19T00:08:52.570' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (52, 2, N'0003596282370', NULL, 1, 0, 71, 50000, CAST(N'2018-07-19T00:08:52.583' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (53, 2, N'0003620918939', NULL, 1, 0, 71, 50000, CAST(N'2018-07-21T13:42:02.927' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (54, 2, N'0003883962445', NULL, 1, 0, 71, 50000, CAST(N'2018-07-21T13:42:02.943' AS DateTime), NULL, NULL, 1, N'No description')
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarehouseID], [WarrantyDuration], [RuntimeDays], [TileID], [Price], [ImportDate], [LastMaintainDate], [NextMaintainDate], [StatusId], [Description]) VALUES (55, 2, N'0003149026463', NULL, 1, 0, 71, 50000, CAST(N'2018-07-21T13:42:02.970' AS DateTime), NULL, NULL, 1, N'No description')
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
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
SET IDENTITY_INSERT [dbo].[Floor] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (1, N'Kho ABC', N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (2, N'Đại học FPT', N'Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (3, N'4S Linh Đông Thủ Đức', N'20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (4, N'Misa Building', N'Lô 47, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Công trường', 106.629288, 10.852845, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (5, N'FPT Software', N'Lot T2, D1 Street, Saigon Hi-Tech Park, Dist 9, Phường Tân Phú, Quận 9, Hồ Chí Minh', N'Công trường', 106.79836, 10.850978, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (6, N'Sky Center ', N'10, Phổ Quang, Phường 2, Q. Tân Bình, Tp.HCM', N'Công trường', 106.666555, 10.805359, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (7, N'Cầu vượt Nguyễn Thái Sơn', N'Vòng xoay Phạm Văn Đồng - Hoàng Minh Giám, Q.Gò Vấp, TpHCM', N'Công trường', 106.678678, 10.813932, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531137149/photo-2-1486537416903.jpg.jpg', NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (8, N'FPT University', N'Toà nhà Innovation, lô 24, Công viên phần mềm Quang Trung, Quận 12, Hồ Chí Minh, Vietnam', N'this is fpt university', 106.62954480000008, 10.8529391, NULL, NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (9, N'Nha Chau', N'135 Yersin, Phú Cường, Thủ Dầu Một, Bình Dương, Vietnam', N'', 106.65972799999997, 10.9822488, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1531259677/b%E1%BA%A3n%20thi%E1%BA%BFt%20k%E1%BA%BF%20nh%C3%A0%202.jpg.jpg', NULL, 1)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (10, N'CVPM Quang Trung', N'Tân Chánh Hiệp, District 12, Ho Chi Minh City, Vietnam', N'123', 106.62652720000006, 10.8528103, NULL, NULL, 0)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude], [Image], [PaintToolMode], [IsActive]) VALUES (11, N'Cầu Phú Cường', N'Cầu Phú Cường, Bình Mỹ, Củ Chi, Bình Dương, Vietnam', N'', 106.64339259999997, 10.9810635, NULL, NULL, 1)
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
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Equipment Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (5, N'Maintainer')
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
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 2, 5, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 2, 3, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 5, 12, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 5, 13, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 4, 14, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (9, 4, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (10, 4, 10, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (11, 3, 11, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (12, 3, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (13, 3, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (14, 5, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (15, 2, 8, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (16, 4, 6, 1)
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
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (13, 10, 3, CAST(N'2018-07-17T09:50:20.407' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (16, 3, 4, CAST(N'2018-07-19T00:15:00.690' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (19, 11, 5, CAST(N'2018-07-19T00:15:56.590' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (20, 11, 4, CAST(N'2018-07-19T14:40:48.747' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (21, 1, 2, CAST(N'2018-07-19T15:48:09.093' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (22, 1, 5, CAST(N'2018-07-19T15:48:09.103' AS DateTime), NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (23, 1, 4, CAST(N'2018-07-19T15:48:09.110' AS DateTime), NULL)
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
INSERT [dbo].[Unit] ([Id], [Name]) VALUES (3, N'chiếc')
SET IDENTITY_INSERT [dbo].[Unit] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nội', N'', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (2, N'FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'thietbivanphong.vn', N'Nguyễn Thanh Long', N'thietbivanphong@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (3, N'Công Ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', N'a')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', N'ggg')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Kim Thanh ', N'truonglongoto@gmail.com', N'Phone: (028) 37543188')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', N'Phone: (84 - 4) 3.6500478')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (8, N'Công Ty Cổ Phần Máy Công Trình Phúc Long', N'Số 420, QL 1A, KP 2, Tam Bình, Thủ Đức, TP. HCM', N'http://phuclong.com/', N'Bình Minh', N'info@phuclong.com', N'0988 012 717')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (10, N'Công Ty Cổ Phần Thiết Bị Xây Dựng Gia Phan', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (11, N'Công Ty TNHH Bình Lợi', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (12, N'công ty Kiến Tạo', N'111 Phù Đổng', N'kientao.com', N'Nguyễn Bê', N'', N'')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (13, N'Tokuda Automatic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (14, N'cong ty thien hoa', N'01 thien vuong', N'thienvuongthienhoa', N'thien hoa', N'thienhoa@gmail.com', N'adf')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (15, N'New Vendor', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (16, N'Hải Dương Auto', N'Hải Dương Auto', N'', N'Huỳnh Hải Dương', N'contact@haiduongauto.com', N'')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (17, N'Hải Dương Auto', N'Hải Dương Auto', N'', N'Huỳnh Hải Dương', N'contact@haiduongauto.com', N'')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (18, N'Đình Thành', N'165 CMT8, Thủ Đức, TP. HCM', N'', N'Nguyễn Trung Thành', N'nguyentrungthanh@gmail.com', N'')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (19, N'Đình Thành', N'165 CMT8, q Thủ Đức, TP. HCM', N'', N'Nguyễn Trung Thành', N'nguyentrungthanh@gmail.com', N'')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thiết bị xây dựng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thiết bị văn phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thiết bị cơ sở vật chất', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Maintain')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Working')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
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
