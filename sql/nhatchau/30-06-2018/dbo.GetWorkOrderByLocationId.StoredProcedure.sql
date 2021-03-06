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
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByLocationId]    Script Date: 6/30/2018 1:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select distinct wo.*, (select COUNT(*)
	from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID
		join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID
	where tl.LocationID = @locationId) as Quantity
	from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID
		join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID
	where tl.LocationID = @locationId
	for json path

	
	
END
GO
