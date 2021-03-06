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
/****** Object:  StoredProcedure [dbo].[GetEquipmentInfoOfWorkOrderById]    Script Date: 6/26/2018 2:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentInfoOfWorkOrderById]
	-- Add the parameters for the stored procedure here
	@workOrderId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select e.Id, e.[Name], e.[Image], u.[Name] as [Unit], (select ei.*
									from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
															join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
										where wo.Id = @workOrderId and ei.EquipmentID = e.Id for json path) as [EquipmentItems]
	from Equipment as e join Unit as u on e.UnitID = u.Id
	where e.Id in (select distinct e.Id
					from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
					where ei.id in (select wod.EquipmentItemID
									from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
									where wo.Id = @workOrderId))
	for json path
END
GO
