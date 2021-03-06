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
/****** Object:  StoredProcedure [dbo].[SearchWorkOrder]    Script Date: 6/26/2018 2:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchWorkOrder] 
	-- Add the parameters for the stored procedure here
	@searchValue nvarchar
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select wo.*
	--from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
	--		join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
	--		join Equipment as e on ei.EquipmentID = e.Id
	--		join Account as acc on wo.RequestUserID = acc.Id
	----where acc.Fullname like '%' + @searchValue + '%'
	--where (cast(wo.Id as nvarchar) like '%' + @searchValue + '%') or (acc.Fullname like '%' + @searchValue + '%') or (acc.Username like '%' + @searchValue + '%') 
	--		 or (ei.SerialNumber like '%' + @searchValue + '%')
	--for json path

	select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], 
					p.[Name] as [Priority], p.TagHexColor as [PriorityColor],
                    (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image]
                                                        from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id
                                                        where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							    from WorkOrderDetail as wod
							    where wod.WorkOrderID = wo.Id
                		for json path))) as [WorkOrderDetails]
			from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
								 join Account as acc on wo.RequestUserID = acc.Id
								 join [Priority] as p on wo.PriorityID = p.Id
			where wo.Id in (select wo.Id
							from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
									join EquipmentItem as ei on wod.EquipmentItemID = ei.Id
									join Equipment as e on ei.EquipmentID = e.Id
									join Account as acc on wo.RequestUserID = acc.Id
							where (cast(wo.Id as nvarchar) like '%' + @searchValue + '%') or (acc.Fullname like '%' + @searchValue + '%') 
									or (acc.Username like '%' + @searchValue + '%') or (ei.SerialNumber like '%' + @searchValue + '%'))
			order by wo.CreateDate desc
    for json path) as [WorkOrders] for json path, without_array_wrapper

END
GO
