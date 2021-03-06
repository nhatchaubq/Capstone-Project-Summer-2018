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
/****** Object:  Table [dbo].[WorkOrderStatus]    Script Date: 6/22/2018 4:01:37 PM ******/
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
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] ON 

INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (1, N'Request')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (2, N'Checked')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (3, N'Approved')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (4, N'Delivered')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (6, N'Closed')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (7, N'Rejected')
INSERT [dbo].[WorkOrderStatus] ([Id], [Name]) VALUES (8, N'Cancelled')
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] OFF
