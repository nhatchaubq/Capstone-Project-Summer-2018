USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetMaintainCalendarEquipmentForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMaintainCalendarEquipmentForReport]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ei.*,e.[Name],l.[Name] as 'Location',es.[Name] as 'Status',b.[Name] as 'Block',f.[Name] as 'Floor',t.[Name] as 'Tile'
	from EquipmentItem as ei join Equipment as e on ei.EquipmentID = e.Id
							 join Tile as t on ei.TileID = t.Id
							 join [Floor] as f on f.Id = t.FloorID
							 join [Block] as b on b.Id = f.BlockID
							 join [Location] as l on l.Id = b.LocationID
							 join EquipmentStatus as es on es.Id = ei.StatusId
	for json path				
END
GO
