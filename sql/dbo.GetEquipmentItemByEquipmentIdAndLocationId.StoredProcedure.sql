USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentItemByEquipmentIdAndLocationId]    Script Date: 6/14/2018 11:11:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentItemByEquipmentIdAndLocationId]
	-- Add the parameters for the stored procedure here
	@locationId Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct e.*, (select ei.*
			   from EquipmentItem as ei join Position as p on ei.PositionID = p.Id 
			   where p.LocationID = 1 and ei.EquipmentId =  [LocationEquipment].Id for JSON path) as [EquipmentItems]
	from Equipment as e, (select eqt.Id as [Id]
						  from EquipmentItem as ei join Position as p on ei.PositionID = p.Id 
												  join Equipment as eqt on eqt.Id = ei.EquipmentID
						  where p.LocationID = @locationId) as [LocationEquipment]
	where e.Id = [LocationEquipment].Id
	for json path
END
GO
