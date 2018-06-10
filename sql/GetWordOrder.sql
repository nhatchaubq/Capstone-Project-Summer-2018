USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrders]    Script Date: 6/10/2018 12:27:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrders]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],
		             (json_query((select wod.*, json_query((select * from EquipmentItem as ei where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							                                                                    from WorkOrderDetail as wod
							                                                                    where wod.WorkOrderID = wo.Id
                			                                                         for json path))) as [WorkOrderDetails]
                     from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
	                                      join Account as acc on wo.RequestUserID = acc.Id
                                          join [Priority] as p on wo.PriorityID = p.Id
                     order by wo.CreateDate desc
                for json path) as [WorkOrders] for json path, without_array_wrapper
END
GO
