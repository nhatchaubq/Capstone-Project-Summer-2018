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
/****** Object:  StoredProcedure [dbo].[CountWorkOrderByStatusId]    Script Date: 6/26/2018 2:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountWorkOrderByStatusId]
	-- Add the parameters for the stored procedure here
	@statusid int
AS
BEGIN
    -- Insert statements for procedure here
	select count(*)
	from WorkOrder as wo
	where wo.StatusID = @statusid
END
GO
