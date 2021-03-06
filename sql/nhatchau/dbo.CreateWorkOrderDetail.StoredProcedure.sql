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
/****** Object:  StoredProcedure [dbo].[CreateWorkOrderDetail]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateWorkOrderDetail]
	-- Add the parameters for the stored procedure here
	@workOrderId int,
	@equipmentId int,
	@startDate datetime,
	@dueDate datetime,
	@maintainceCost float,
	@description text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @equipmentItemId int;
	select @equipmentItemId = (select top 1 Id from EquipmentItem where EquipmentID = @equipmentId and StatusId = 1);
    -- Insert statements for procedure here
	insert into WorkOrderDetail(EquipmentItemID, WorkOrderID, StartDate, FinishedDate, MaintainceCost, [Description])
		values(@equipmentItemId, @workOrderId, @startDate, @dueDate, @maintainceCost, @description);
	update EquipmentItem set StatusId = 2 where Id = @equipmentItemId;
END
GO
