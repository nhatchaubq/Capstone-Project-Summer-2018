USE [EquipmentManageSystem]
GO

/****** Object:  StoredProcedure [dbo].[GetAnItem]    Script Date: 6/26/2018 10:05:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetAnItem] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*SELECT ei.Id, ei.EquipmentID, ei.WarrantyDuration, ei.SerialNumber, ei.RuntimeDays, ei.Price,
	CONVERT(date, ImportDate) as [ImportDate], es.Name as Status, wod.Id as WorkOrderDetailID, wod.WorkOrderID, wo.Name as WorkOrderName, wo.CreateDate, wo.DueDate
	From EquipmentItem as ei
	JOIN EquipmentStatus as es ON ei.StatusId = es.Id, WorkOrderDetail as wod, WorkOrder as wo, WorkOrderStatus as wos
	Where  ei.ID = @id and 
			wod.EquipmentItemID = @id*/
			/*select WorkOrder.Name from WorkOrder where WorkOrder.StatusID < 5
			select WorkOrderDetail.Id from WorkOrderDetail where WorkOrderDetail.EquipmentItemID = @id*/

	/*SELECT *
	from WorkOrder as wo
	where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
										from WorkOrderDetail as wod
										where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																	 from EquipmentItem as ei
																	 where ei.Id = 12))*/

/*select ((select wo.*, (select e.*
			  from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
			  where ei.Id = @id for json path, without_array_wrapper) as [Equipment]
		from WorkOrder as wo
		where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
											from WorkOrderDetail as wod
											where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																			from EquipmentItem as ei
																			where ei.Id = @id))
		for json path) 
) as [Item]
for json path, without_array_wrapper*/

select (json_query((select ei.SerialNumber, ei.Price, ei.WarrantyDuration, ei.RuntimeDays,CONVERT(date, ImportDate) as [ImportDate], es.Name as Status,
		CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as NextMaintainDate, ei.Description, (select wo.*
					  from WorkOrder as wo
					  where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID
														  from WorkOrderDetail as wod
														  where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId]
																					   from EquipmentItem as ei
																					   where ei.Id = @id))
					  for json path) as [WorkOrders]
		 from EquipmentItem as ei
		 JOIN EquipmentStatus as es on es.Id = ei.StatusId
		  --join EquipmentItem as ei on e.Id = ei.EquipmentID
		 where ei.Id = @id for json path, without_array_wrapper))
) as [Item]
for json path, without_array_wrapper

END
GO

