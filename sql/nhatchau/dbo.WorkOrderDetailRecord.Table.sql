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
/****** Object:  Table [dbo].[WorkOrderDetailRecord]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkOrderDetailRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderDetailId] [int] NOT NULL,
	[ModifiedByUserId] [int] NOT NULL,
	[ModifiedByDateTime] [datetime] NOT NULL,
	[OldEquipmentStatusId] [int] NOT NULL,
	[NewEquipmentStatusId] [int] NOT NULL,
 CONSTRAINT [PK_WorkOrderDetailRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailRecord_Account] FOREIGN KEY([ModifiedByUserId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord] CHECK CONSTRAINT [FK_WorkOrderDetailRecord_Account]
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderDetailRecord_WorkOrderDetail] FOREIGN KEY([WorkOrderDetailId])
REFERENCES [dbo].[WorkOrderDetail] ([Id])
GO
ALTER TABLE [dbo].[WorkOrderDetailRecord] CHECK CONSTRAINT [FK_WorkOrderDetailRecord_WorkOrderDetail]
GO
