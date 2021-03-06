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
/****** Object:  Table [dbo].[VendorType]    Script Date: 6/22/2018 4:01:37 PM ******/
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
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thiết bị xây dựng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thiết bị văn phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thiết bị cơ sở vật chất', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
