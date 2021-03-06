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
/****** Object:  Table [dbo].[Vendor]    Script Date: 6/22/2018 4:01:37 PM ******/
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
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'Số 14B Ngõ 200 Vinh Hung, Quận Hoàng Mai, Hà Nộii', N'dailymayxaydung.com', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (2, N'FINTEC', N'Số nhà M2-4, ngõ 30 Nguyễn Thị Ðịnh, quận Cầu Giấy, Hà Nội', N'thietbivanphong.vn', N'Nguyễn Thanh Long', N'thietbivanphong@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (3, N'Công Ty TNHH Phú Nhuận Ðức', N'Số 965, Ðường ÐT 743, P. Tân Ðông Hiệp, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', N'Trương Thị Huế', N'lientrinh0912@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', N'hitachiconstruction@gmail.com ', N'Phone: +65 6265-2377')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', N'Kim Thanh ', N'truonglongoto@gmail.com', N'Phone: (028) 37543188')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', N'Đặng Tuấn Thanh', N'truongthanhautogroup@gmail.com ', N'Phone: (84 - 4) 3.6500478')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
