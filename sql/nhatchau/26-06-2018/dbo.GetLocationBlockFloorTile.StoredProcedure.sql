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
/****** Object:  StoredProcedure [dbo].[GetLocationBlockFloorTile]    Script Date: 6/26/2018 2:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLocationBlockFloorTile]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select lo.*, (select bl.*, (select fl.*, (select ti.*
											  from Tile as ti
											  where ti.FloorID = fl.Id
											  for json path) as [Tiles]
								from [Floor] as fl
								where fl.BlockID = bl.Id
								for json path) as [Floors]
				  from [Block] as bl
				  where bl.LocationID = @locationId
				  for json path) as [Blocks]
	from [Location] as lo
	where lo.Id = @locationId
	for json path, without_array_wrapper
END
GO
