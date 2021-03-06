USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetAvailableEquipmentForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAvailableEquipmentForReport] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ei.*,e.Name,l.[Name] as 'Location',t.[Name] as 'Tile',f.[Name] as 'Floor',b.[Name] as 'Block'
	from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
						join Tile as t on ei.TileID = t.Id
						join [Floor] as f on f.Id = t.FloorID
						join [Block] as b on b.Id = f.BlockID
						join [Location] as l on l.Id = b.LocationID
	where ei.StatusId = 1
	for json path
END
GO
