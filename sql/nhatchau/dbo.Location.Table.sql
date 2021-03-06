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
/****** Object:  Table [dbo].[Location]    Script Date: 6/22/2018 4:01:37 PM ******/
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
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (1, N'Kho A', N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (2, N'Đại học FPT', N'Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (3, N'4S Linh Đông', N'20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (4, N'Misa Building', N'Lô 47, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Công trường', 106.629288, 10.852845)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (5, N'FPT Software', N'Lot T2, D1 Street, Saigon Hi-Tech Park, Dist 9, Phường Tân Phú, Quận 9, Hồ Chí Minh', N'Công trường', 106.79836, 10.850978)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (6, N'Sky Center ', N'10, Phổ Quang, Phường 2, Q. Tân Bình, Tp.HCM', N'Công trường', 106.666555, 10.805359)
INSERT [dbo].[Location] ([Id], [Name], [Address], [Description], [Longitude], [Latitude]) VALUES (7, N'Cầu vượt Nguyễn Thái Sơn', N'Vòng xoay Phạm Văn Đồng - Hoàng Minh Giám, Q.Gò Vấp, TpHCM', N'Công trường', 106.678678, 10.813932)
SET IDENTITY_INSERT [dbo].[Location] OFF
