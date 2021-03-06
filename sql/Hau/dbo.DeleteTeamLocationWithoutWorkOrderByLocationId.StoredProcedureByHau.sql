USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[DeleteTeamLocationWithoutWorkOrderByLocationId]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTeamLocationWithoutWorkOrderByLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		delete from TeamLocation where LocationID = @locationId and TeamID not in( 
		select distinct tl.TeamID
		from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID
		where tl.LocationID = @locationId)
END
GO
