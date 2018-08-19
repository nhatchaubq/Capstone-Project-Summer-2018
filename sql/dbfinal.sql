USE [EquipmentManageSystem]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 15-Aug-18 12:19:21 PM ******/
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
/****** Object:  Table [dbo].[AccountNotification]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Equipment]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[EquipmentItemHistory]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[EquipmentStatus]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Floor]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[MaintenanceDuration]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Priority]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 15-Aug-18 12:19:22 PM ******/
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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[TeamRoles]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[Tile]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[Unit]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[VendorType]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrder]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderCategory]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderDetailReturn]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderRecord]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 15-Aug-18 12:19:23 PM ******/
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
