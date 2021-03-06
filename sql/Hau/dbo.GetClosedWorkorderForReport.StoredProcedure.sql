USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetClosedWorkorderForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetClosedWorkorderForReport]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	select w.*,t.Name as 'Team',json_query((select COUNT(*) as 'quantity',json_query((select wd.*,ei.SerialNumber,e.Image,e.Name as 'Equipment',es.Name 'ReturnedStatus'
																						from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id
																												   join EquipmentItem as ei on wd.EquipmentItemID = ei.Id
																												   join Equipment as e on e.Id = ei.EquipmentID
																												   join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId
																						where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 1 for json path)) as 'Detail'
											from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id																		
											where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 1 for json path, without_array_wrapper)) as 'Available',
								json_query((select COUNT(*) as 'quantity',json_query((select wd.*,ei.SerialNumber,e.Image,e.Name as 'Equipment',es.Name 'ReturnedStatus'
																						from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id
																												   join EquipmentItem as ei on wd.EquipmentItemID = ei.Id
																												   join Equipment as e on e.Id = ei.EquipmentID
																												   join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId
																						where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 5 for json path)) as 'Detail'
											from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id																		
											where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 5 for json path, without_array_wrapper)) as 'Damaged',
								json_query((select COUNT(*) as 'quantity',json_query((select wd.*,ei.SerialNumber,e.Image,e.Name as 'Equipment',es.Name 'ReturnedStatus'
																						from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id
																												   join EquipmentItem as ei on wd.EquipmentItemID = ei.Id
																												   join Equipment as e on e.Id = ei.EquipmentID
																												   join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId
																						where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 7 for json path)) as 'Detail'
											from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id																		
											where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 7 for json path, without_array_wrapper)) as 'Lost'
	from WorkOrder as w join TeamLocation as tl on tl.Id = w.TeamLocationID
						join Team as t on t.Id = tl.TeamID
	where w.StatusID = 5 for json path




	


	

	

	
END
GO
