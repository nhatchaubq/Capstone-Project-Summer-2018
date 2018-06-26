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
/****** Object:  Table [dbo].[EquipmentItem]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NULL,
	[SerialNumber] [nvarchar](50) NULL,
	[WarrantyDuration] [int] NULL,
	[RuntimeDays] [int] NULL,
	[ImportDate] [datetime] NULL,
	[StatusId] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[PositionID] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK__Equipmen__3214EC07D8BED705] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EquipmentItem] ON 

INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (1, 4, N'10101012', 6, 12, NULL, 2, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (2, 4, N'10101013', 6, 10, NULL, 2, NULL, 1, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (3, 4, N'10101014', 6, 5, NULL, 2, NULL, 9, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (4, 2, N'1212900', 12, 45, NULL, 2, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (5, 2, N'1212901', 12, 3, NULL, 2, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (6, 2, N'1212903', 12, 50, NULL, 2, NULL, 2, 3)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (7, 5, N'109021101', 12, 64, NULL, 2, NULL, 3, 1)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (8, 5, N'109021109', 12, 75, NULL, 2, NULL, 4, 2)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (9, 16, N'1110245222311', 18, 0, NULL, 1, NULL, 9, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (10, 16, N'1110242566178', 18, 0, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (11, 15, N'2020154022532', 6, 100, NULL, 2, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (12, 15, N'2020154322210', 6, 30, NULL, 2, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (13, 18, N'1245543156741', 3, 10, NULL, 1, NULL, 9, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (14, 18, N'1245543156751', 3, 20, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (15, 18, N'1245543256435', 3, 21, NULL, 1, NULL, 1, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (16, 19, N'1134578122221', 6, 15, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (17, 19, N'1134578122652', 6, 26, NULL, 1, NULL, 5, NULL)
INSERT [dbo].[EquipmentItem] ([Id], [EquipmentID], [SerialNumber], [WarrantyDuration], [RuntimeDays], [ImportDate], [StatusId], [Description], [PositionID], [DepartmentID]) VALUES (18, 19, N'1134578122543', 6, 57, NULL, 1, NULL, 6, NULL)
SET IDENTITY_INSERT [dbo].[EquipmentItem] OFF
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
ALTER TABLE [dbo].[EquipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentItem_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([Id])
GO
ALTER TABLE [dbo].[EquipmentItem] CHECK CONSTRAINT [FK_EquipmentItem_Position]
GO
