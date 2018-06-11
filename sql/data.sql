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
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Site Manager')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Equipment Staff')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (5, N'Staff')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (2, N'admin', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:20:49.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (3, N'manager', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:31:11.000' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (4, N'sitemanager', N'123456', NULL, N'Nhat Chau', NULL, 1, CAST(N'2018-06-03T14:31:46.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (5, N'eqtstaff', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:32:19.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (6, N'staff', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:32:42.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (7, N'staff1', N'23456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:33:08.000' AS DateTime), NULL, 5, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (8, N'nhatchau', N'123456', NULL, NULL, NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 1, N'https://i.imgur.com/0OGAkGJ.jpg')
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (9, N'sitemanager2', N'123456', NULL, N'Mattin Garrix', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Email], [Fullname], [Phone], [IsActive], [StartDate], [EndDate], [RoleID], [AvatarImage]) VALUES (10, N'sitemanager3', N'123456', NULL, N'Mike Tyson', NULL, 1, CAST(N'2018-06-03T14:33:34.000' AS DateTime), NULL, 3, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Id], [Name], [Description], [Longitude], [Latitude]) VALUES (1, N'21 Sông Thao, Phường 2, Quận Tân Bình, TPHCM', N'Kho', 106.666401, 10.809084)
INSERT [dbo].[Location] ([Id], [Name], [Description], [Longitude], [Latitude]) VALUES (2, N'Đại học FPT, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Trụ sở', 106.629288, 10.852845)
INSERT [dbo].[Location] ([Id], [Name], [Description], [Longitude], [Latitude]) VALUES (3, N'Linh Đông, 20 Phạm Văn Đồng, Thủ Đức, TPHCM', N'Công trường', 106.741077, 10.843665)
INSERT [dbo].[Location] ([Id], [Name], [Description], [Longitude], [Latitude]) VALUES (4, N'Lô 47, Công viên phần mềm Quang Trung, Quận 12, TPHCM', N'Công trường', 106.629288, 10.852845)
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (1, N'4S Linh Dong Apartment', 3, CAST(N'2018-06-02T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Project] ([Id], [Name], [LocationID], [StartDate], [FinishedDate], [CreatedById]) VALUES (2, N'MiSa Building', 4, CAST(N'2018-05-02T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (1, NULL, N'Marketing')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (2, NULL, N'IT')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (3, NULL, N'Thi công công trình')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (4, NULL, N'Administrator')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (5, NULL, N'Construction')
INSERT [dbo].[Department] ([Id], [CreatedById], [Name]) VALUES (6, NULL, N'Office')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedByID], [DepartmentID], [CreatedDate]) VALUES (1, N'xay dung abc', 2, 5, NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedByID], [DepartmentID], [CreatedDate]) VALUES (2, N'TeamA', 2, 5, NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedByID], [DepartmentID], [CreatedDate]) VALUES (3, N'TeamB', 2, 5, NULL)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[TeamRoles] ON 

INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (1, N'Leader')
INSERT [dbo].[TeamRoles] ([Id], [TeamRole]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[TeamRoles] OFF
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 6, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 5, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 2, 4, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 2, 8, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
SET IDENTITY_INSERT [dbo].[Priority] ON 

INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (1, N'Low', N'#00c853')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (2, N'Medium', N'#fbc02d')
INSERT [dbo].[Priority] ([Id], [Name], [TagHexColor]) VALUES (3, N'High', N'#ef5350')
SET IDENTITY_INSERT [dbo].[Priority] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] ON 

INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (1, N'Onsite')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (2, N'Upgrade')
INSERT [dbo].[WorkOrderCategory] ([Id], [Name]) VALUES (3, N'Maintain')
SET IDENTITY_INSERT [dbo].[WorkOrderCategory] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] ON 

INSERT [dbo].[WorkOrderStatus] ([Id], [Name], [TagHexColor]) VALUES (1, N'Requested', NULL)
INSERT [dbo].[WorkOrderStatus] ([Id], [Name], [TagHexColor]) VALUES (2, N'Opened', NULL)
INSERT [dbo].[WorkOrderStatus] ([Id], [Name], [TagHexColor]) VALUES (3, N'Approved', NULL)
INSERT [dbo].[WorkOrderStatus] ([Id], [Name], [TagHexColor]) VALUES (4, N'Working', NULL)
INSERT [dbo].[WorkOrderStatus] ([Id], [Name], [TagHexColor]) VALUES (5, N'Closed', NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderStatus] OFF
SET IDENTITY_INSERT [dbo].[WorkOrder] ON 

INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [ProjectId], [CategoryID]) VALUES (1, NULL, 4, CAST(N'2018-06-06T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, 3, 1, 1, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [ProjectId], [CategoryID]) VALUES (2, NULL, 9, CAST(N'2018-05-01T00:00:00.000' AS DateTime), CAST(N'2018-05-31T00:00:00.000' AS DateTime), NULL, NULL, 1, 4, 2, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [ProjectId], [CategoryID]) VALUES (3, NULL, 10, CAST(N'2018-06-01T00:00:00.000' AS DateTime), CAST(N'2018-06-20T00:00:00.000' AS DateTime), NULL, NULL, 2, 2, 1, 1)
INSERT [dbo].[WorkOrder] ([Id], [Name], [RequestUserID], [CreateDate], [DueDate], [ClosedDate], [Description], [PriorityID], [StatusID], [ProjectId], [CategoryID]) VALUES (4, NULL, 4, CAST(N'2018-06-06T00:00:00.000' AS DateTime), CAST(N'2018-06-10T00:00:00.000' AS DateTime), NULL, NULL, 2, 1, 2, 3)
SET IDENTITY_INSERT [dbo].[WorkOrder] OFF
SET IDENTITY_INSERT [dbo].[EquipmentCategory] ON 

INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (1, N'Máy xây d?ng', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (2, N'Máy co khí', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (3, N'Máy hàn', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (4, N'Máy nén khí', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (5, N'Máy bom', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (6, N'Máy FAX', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (7, N'Crane', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (8, N'Excavator', NULL)
INSERT [dbo].[EquipmentCategory] ([Id], [Name], [Description]) VALUES (9, N'Forklift', NULL)
SET IDENTITY_INSERT [dbo].[EquipmentCategory] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (1, N'CTY TNHH MINH THIÊN LONG', N'S? 14B Ngõ 200 Vinh Hung, Qu?n Hoàng Mai, Hà N?i', N'dailymayxaydung.com', N'Nguyễn Thanh Tiến', N'dailymayxaydung@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (2, N'FINTEC', N'S? nhà M2-4, ngõ 30 Nguy?n Th? Ð?nh, qu?n C?u Gi?y, Hà N?i', N'thietbivanphong.vn', NULL, N'thietbivanphong@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (3, N'Công Ty TNHH Phú Nhu?n Ð?c', N'S? 965, Ðu?ng ÐT 743, P. Tân Ðông Hi?p, Di An, Bình Duong', N'mayxaydungphunhuanduc.com', NULL, N'lientrinh0912@gmail.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (4, N'Samsung HOIST', N'242-21 Gojungri Tongineup Gyeonggido Korea', N'http://www.samsunghoist.com/eng', N'CEO Sehyun Choi', N'sm@samsunghoist.com', NULL)
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (5, N'Hitachi Construction Machinery Asia and Pacific Pte. Ltd.', N'2 Pioneer Walk Singapore 627856', N'https://www.hitachicm.com.sg', N'Yasushi Ochiai', NULL, N'Phone: +65 6265-2377')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (6, N'Trường Long', N'Lô 46, Đường số 3, KCN Tân Tạo, P. Tân Tạo A, Quận Bình Tân, Thành phố Hồ Chí Minh.', N'http://www.truonglong.com', NULL, NULL, N'Phone: (028) 37543188')
INSERT [dbo].[Vendor] ([Id], [BusinessName], [BusinessAddress], [Website], [ContactName], [ContactEmail], [Description]) VALUES (7, N'Trường Thành Auto', N'Quốc Lộ 3, Du Nội - Mai Lâm - Đông Anh, Hà Nội ', N'truongthanhauto.com', NULL, N'truongthanhautogroup@gmail.com ', N'Phone: (84 - 4) 3.6500478')
SET IDENTITY_INSERT [dbo].[Vendor] OFF
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (1, N'Máy d?c bê tông Makita HM1201 (1130W)', 1, CAST(N'2018-06-02T23:27:08.410' AS DateTime), NULL, 11450000, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (2, N'Máy hàn que Jasic ARC 200', 1, CAST(N'2018-06-02T23:29:00.097' AS DateTime), NULL, 3450000, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (3, N'Máy khoan rút lõi bê tông Ken 6200N (3,8KW)', 1, CAST(N'2018-06-02T23:29:43.530' AS DateTime), NULL, 6800000, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (4, N'Máy nén khí Puma XN2525 (2.5HP)', 1, CAST(N'2018-06-02T23:30:47.613' AS DateTime), NULL, 2950000, NULL, 4)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (5, N'	
Panasonic Laser Fax KX-FLB882', 2, CAST(N'2018-06-02T00:00:00.000' AS DateTime), NULL, 8290000, NULL, 5)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (6, N'Samsung SC25H', 1, CAST(N'2018-06-05T00:00:20.000' AS DateTime), N'http://xenangvinacoma.com/upload/images/IMG_4147.JPG', NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (7, N'Hitachi EX8000-6', 2, CAST(N'2018-06-05T00:04:49.000' AS DateTime), N'http://www.hitachiconstruction.com/wp-content/uploads/2015/10/EX8000_6_HERO.jpg', NULL, NULL, 2)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (8, N'SAMSUNG SC50H', 1, CAST(N'2018-06-05T00:06:49.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/can_cau_samsung__tan_.JPG', NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (9, N'KOMATSU FD250-2', 4, CAST(N'2018-06-05T00:12:26.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/xenanghangkomatsufdtan_.jpg', NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (10, N'KOMATSU FD60-5', 4, CAST(N'2018-06-05T00:13:36.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/komatsu__tan_.JPG', NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (11, N'TCM FD135Z', 4, CAST(N'2018-06-05T00:14:32.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/xenanghangtcmtan__13.JPG', NULL, NULL, 3)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (12, N'Kato NK-800', 4, CAST(N'2018-06-05T00:15:37.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/cancaubanhlopkatotan__1.jpg', NULL, NULL, 1)
INSERT [dbo].[Equipment] ([Id], [Name], [VendorID], [ImportDate], [Image], [Price], [Description], [CategoryID]) VALUES (13, N'SAMSUNG SC50H', 1, CAST(N'2018-06-05T00:16:41.000' AS DateTime), N'http://truongthanhauto.com/FileUpload/Images/thumb/can_cau_samsung__tan_.JPG', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[EquipmentStatus] ON 

INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (1, N'AVAILABLE')
INSERT [dbo].[EquipmentStatus] ([Id], [Name]) VALUES (2, N'UNAVAILABLE')
SET IDENTITY_INSERT [dbo].[EquipmentStatus] OFF
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (1, N'Kho 1', N'A', N'1', N'A7', NULL, 1)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (2, N'Kho 1', N'A', N'2', N'C2', NULL, 1)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (3, N'Trụ sở', N'A', N'2', N'A2', NULL, 2)
INSERT [dbo].[Position] ([Id], [PositionName], [Block], [Floor], [Tile], [Description], [LocationID]) VALUES (4, N'Trụ sở', N'A', N'2', N'A3', NULL, 2)
SET IDENTITY_INSERT [dbo].[Position] OFF
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (1, 4, 10101012, CAST(N'2020-06-02T00:00:00.000' AS DateTime), NULL, 1, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (2, 4, 10101013, CAST(N'2020-06-02T00:00:00.000' AS DateTime), NULL, 1, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (3, 4, 10101014, CAST(N'2020-06-02T00:00:00.000' AS DateTime), NULL, 1, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (4, 2, 1212900, CAST(N'2025-01-10T00:00:00.000' AS DateTime), NULL, 1, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (5, 2, 1212901, CAST(N'2025-01-10T00:00:00.000' AS DateTime), NULL, 1, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (6, 2, 1212903, CAST(N'2025-01-10T00:00:00.000' AS DateTime), NULL, 1, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (7, 5, 109021101, CAST(N'2022-05-10T00:00:00.000' AS DateTime), NULL, 1, NULL, 3, 1)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyExpireDate], [Ownership], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (8, 5, 109021109, CAST(N'2022-05-10T00:00:00.000' AS DateTime), NULL, 1, NULL, 4, 2)
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (1, 1, 1, CAST(N'2018-06-06T00:00:00.000' AS DateTime), CAST(N'2018-06-20T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (2, 3, 1, CAST(N'2018-06-07T00:00:00.000' AS DateTime), CAST(N'2018-06-20T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (3, 5, 2, CAST(N'2018-05-02T00:00:00.000' AS DateTime), CAST(N'2018-05-31T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (4, 5, 2, CAST(N'2018-05-02T00:00:00.000' AS DateTime), CAST(N'2018-05-31T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (5, 2, 3, CAST(N'2018-03-06T00:00:00.000' AS DateTime), CAST(N'2018-06-25T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (6, 7, 4, CAST(N'2018-06-07T00:00:00.000' AS DateTime), CAST(N'2018-06-25T00:00:00.000' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[ProjectTeams] ON 

INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (1, 1, 2, CAST(N'2018-06-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (4, 2, 3, CAST(N'2018-06-08T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[ProjectTeams] OFF
SET IDENTITY_INSERT [dbo].[VendorType] ON 

INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (1, N'Thi?t b? xây d?ng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (2, N'Thi?t b? van phòng', NULL)
INSERT [dbo].[VendorType] ([Id], [Name], [Description]) VALUES (3, N'Thi?t b? co s? v?t ch?t', NULL)
SET IDENTITY_INSERT [dbo].[VendorType] OFF
