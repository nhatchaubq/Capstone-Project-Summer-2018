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
/****** Object:  StoredProcedure [dbo].[CreateWorkOrder]    Script Date: 6/30/2018 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateWorkOrder] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(250),
	@requestUserId int, 
	@createDate datetime,
	@description nvarchar(250),
	@priorityId int,
	@statusId int,
	@categoryId int,
	@teamLocationId int
AS
BEGIN
	declare @newWorkOrderId int;
    insert into [WorkOrder]([Name], RequestUserID, CreateDate, [Description], PriorityID, StatusID, CategoryID, TeamLocationID)
		values(@name, @requestUserId, @createDate, @description, @priorityId, @statusId, @categoryId, @teamLocationId);
	set @newWorkOrderId = (select SCOPE_IDENTITY());
	select(@newWorkOrderId) as [NewWorkOrderId] for json path, without_array_wrapper;
	insert into WorkOrderRecord(WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description])
		values(@newWorkOrderId, @requestUserId, @createDate, null, @statusId, @description);
END
GO
