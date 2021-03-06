/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4224)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [EquipmentManageSystem]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (2, N'admin', N'123456', N'admin@ems.com', N'Nguyễn Huy Hung', N'0983234919', 1, CAST(N'2018-06-03T14:20:49.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', N'manager@ems.com', N'Trần Minh Hưng', N'0941239761', 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'TienNT', N'123456', N'tiennt@ems.com', N'Nguyễn Thanh Tiến', N'0971298366', 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'KhanhPM', N'123456', N'khanhpm@ems.com', N'Phạm Minh Khánh', N'0981123123', 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'teamleader2', N'123456', N'teamleader2@gmail.com', N'Nguyễn Minh Hải', N'0927234925', 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'VietNQ', N'123456', N'vietnq@ems.com', N'Trần Quốc Việt', N'0961212636', 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'teamleader', N'123456', N'nhatchau.bq249@gmail.com', N'Bùi Quang Nhật Châu', N'0982712366', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'HauTT', N'123456', N'hautt@ems.com', N'Trịnh Thanh Hậu', N'0927234923', 0, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534476847/lake_motosu_and_mount_fuji-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'estaff', N'123456', N'estaff@ems.com', N'Nguyễn Huy Hoàng', N'0927234924', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 4, N'http://res.cloudinary.com/dmlopvmdy/image/upload/v1534442948/mount_fuji_landscapes-wallpaper-1366x768.jpg.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (15, N'maintainer', N'123456', N'chaubqnse61740@fpt.edu.vn', N'Nguyễn Nhật Duy', N'0912383766', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (16, N'admin2', N'123456', N'admin2@ems.com', N'Ngô Bảo Châu', N'0981283838', 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
