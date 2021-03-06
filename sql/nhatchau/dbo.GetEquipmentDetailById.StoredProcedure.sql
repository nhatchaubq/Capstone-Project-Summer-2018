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
/****** Object:  StoredProcedure [dbo].[GetEquipmentDetailById]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentDetailById] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ei.*, e.[Name] as [Name], e.[Image] as [Image], v.BusinessName as [VendorName], json_query((select *
									from Position
									where Id = ei.PositionID for json path, without_array_wrapper)) as [Position],
										json_query((select *
										from [Location]
										where Id = (select l.Id 
													from Position as pos join [Location] as l on pos.LocationID = l.Id
													where pos.Id = ei.PositionID) for json path, without_array_wrapper)) as [Location]
	from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id
							join EquipmentStatus as es on ei.StatusId = es.Id
							join Vendor as v on e.VendorID = v.Id 
	where ei.Id = @id
	for json path, without_array_wrapper
END
GO
