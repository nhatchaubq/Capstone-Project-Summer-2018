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
/****** Object:  StoredProcedure [dbo].[UpdateWorkOrderStatus]    Script Date: 6/30/2018 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateWorkOrderStatus]
	-- Add the parameters for the stored procedure here
	@workOrderId int,
	@userId int,
	@oldWorkOrderStatusId int,
	@newWorkOrderStatusId int,
	@description nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @workOrderCategoryName int;
	set @workOrderCategoryName = (select woc.[Name]
								  from WorkOrder as wo join WorkOrderCategory as woc on wo.CategoryID = woc.Id 
								  where wo.Id = @workOrderId)

    -- Insert statements for procedure here
	update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId;
	insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) 
		values(@workOrderId, @userId, getdate(), @oldWorkOrderStatusId, @newWorkOrderStatusId, @description);

	-- update equipment item status and insert new record to 
	if @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'Approved')
		begin
			if @workOrderCategoryName = N'Working'
				begin
					update EquipmentItem set StatusId = (select Id from EquipmentStatus where [Name] = N'Working Requested')
				end
			else if @workOrderCategoryName = N'Maintain'
				begin
					update EquipmentItem set StatusId = (select Id from EquipmentStatus where [Name] = N'Maintain Requested')
				end
		end
	else if @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'In Progress')
		begin
			if @workOrderCategoryName = N'Working'
				begin
					update EquipmentItem set StatusId = (select Id from EquipmentStatus where [Name] = N'Working')
				end
			else if @workOrderCategoryName = N'Maintain'
				begin
					update EquipmentItem set StatusId = (select Id from EquipmentStatus where [Name] = N'Maintaining')
				end 
		end
		
END
GO
