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
/****** Object:  Table [dbo].[WorkOrderDetail]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentItemID] [int] NULL,
	[WorkOrderID] [int] NULL,
	[StartDate] [datetime] NULL,
	[FinishedDate] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
	[MaintainceCost] [float] NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_WorkOrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] ON 

INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (33, 1, 35, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (34, 2, 35, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (35, 3, 35, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (36, 4, 36, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (37, 6, 36, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (38, 7, 36, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (39, 8, 36, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-06-30T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (40, 11, 38, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[WorkOrderDetail] ([Id], [EquipmentItemID], [WorkOrderID], [StartDate], [FinishedDate], [ReturnDate], [MaintainceCost], [Description]) VALUES (41, 12, 38, CAST(N'2018-06-18T00:00:00.000' AS DateTime), CAST(N'2018-07-01T00:00:00.000' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WorkOrderDetail] OFF
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
