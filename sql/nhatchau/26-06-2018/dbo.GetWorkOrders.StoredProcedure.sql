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
/****** Object:  StoredProcedure [dbo].[GetWorkOrders]    Script Date: 6/26/2018 2:34:20 PM ******/
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
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],
																				json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location],
																				t.Id as [Team.Id], t.[Name] as [Team.Name], 
                                                                                 (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image]
                                                                                                                        from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id
                                                                                                                        where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							                                                                    from WorkOrderDetail as wod
							                                                                    where wod.WorkOrderID = wo.Id
                			                                                         for json path))) as [WorkOrderDetails]
                     from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
	                                      join Account as acc on wo.RequestUserID = acc.Id
                                          join [Priority] as p on wo.PriorityID = p.Id
										  join TeamLocation as tl on wo.TeamLocationID = tl.Id
										  join Team as t on tl.TeamID = t.Id
                     order by wo.CreateDate desc
                for json path) as [WorkOrders] for json path, without_array_wrapper
END
GO
