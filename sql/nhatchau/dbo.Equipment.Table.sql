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
/****** Object:  Table [dbo].[Equipment]    Script Date: 6/22/2018 4:01:37 PM ******/
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
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (1, N'Máy đục bê tông Makita HM1201 (1130W)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/Makita_HM1201.jpg', 11450000, N'Japan', 8.7, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/05/Jasic_arc200.jpg', 3450000, N'China', 5.8, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/07/may-khoan-rut-loi-ken-6200n.jpg', 6800000, N'China', 20.5, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, N'http://dailymayxaydung.com/wp-content/uploads/2016/04/Puma_xn2525.jpg', 2950000, N'Puma', 20, NULL, 4)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [Image], [Price], [MadeIn], [Weight], [Description], [CategoryID]) VALUES (5, N'Panasonic Laser Fax KX-FLB882', 2, N'http://www.mucinhanoi.vn/images/201204/goods_img/612_G_1334278634575.jpg', 8290000, N'Japan', 2.5, NULL, 5)
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
