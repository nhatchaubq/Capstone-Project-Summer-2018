USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentItemByEquipmentIdAndLocationId]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetEquipmentItemByEquipmentIdAndLocationId]
	-- Add the parameters for the stored procedure here
	@locationId Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct e.*, (select ei.*
			   from EquipmentItem as ei join Tile as t on ei.TileID = t.Id 
										join [Floor] as f on t.FloorID = f.Id
										join [Block] as b on f.BlockID = b.Id
			   where b.LocationID = @locationId and ei.EquipmentId =  [LocationEquipment].Id for JSON path) as [EquipmentItems]
	from Equipment as e, (select eqt.Id as [Id]
						  from EquipmentItem as ei join Tile as t on ei.TileID = t.Id 
										join [Floor] as f on t.FloorID = f.Id
										join [Block] as b on f.BlockID = b.Id
												  join Equipment as eqt on eqt.Id = ei.EquipmentID
						  where b.LocationID = @locationId) as [LocationEquipment]
	where e.Id = [LocationEquipment].Id
	for json path 
END
GO
