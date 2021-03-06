USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetUsingEquipmentForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUsingEquipmentForReport]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct ei.Id,e.[Name],ei.SerialNumber,l.[Name] as 'Location',t.[Name] as 'Tile',f.[Name] as 'Floor',b.[Name] as 'Block',wd.StartDate,wd.FinishedDate,tm.[Name] as 'Team'
	from EquipmentItem as ei join Equipment as e on ei.EquipmentID = e.Id
							 join WorkOrderDetail as wd on wd.EquipmentItemID = ei.Id
							 join WorkOrder as w on w.Id = wd.WorkOrderID
							 join TeamLocation as tl on tl.Id = w.TeamLocationID
							 join Team as tm on tm.Id = tl.TeamID							 
							 join Tile as t on ei.TileID = t.Id
							 join [Floor] as f on f.Id = t.FloorID
							 join [Block] as b on b.Id = f.BlockID
							 join [Location] as l on l.Id = b.LocationID	
							 						 
	where ei.StatusId = 4 	
	for json path						
END
GO
