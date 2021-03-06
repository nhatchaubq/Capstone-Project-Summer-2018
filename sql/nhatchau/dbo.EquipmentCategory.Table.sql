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
/****** Object:  Table [dbo].[EquipmentCategory]    Script Date: 6/22/2018 4:01:37 PM ******/
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
