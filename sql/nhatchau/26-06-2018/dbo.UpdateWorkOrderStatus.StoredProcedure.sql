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
/****** Object:  StoredProcedure [dbo].[UpdateWorkOrderStatus]    Script Date: 6/26/2018 2:34:20 PM ******/
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
	@newWorkOrderStatusId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId;
	insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID) 
		values(@workOrderId, @userId, getdate(), @oldWorkOrderStatusId, @newWorkOrderStatusId);
END
GO
