USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[Get1LocationById]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get1LocationById]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct l.*,(select tl.Id as 'TeamLocationId',t.Id,t.Name
						from TeamLocation as tl join Location as l on tl.LocationID = l.Id
												join Team as t on t.Id = tl.TeamID
	where tl.LocationID = @locationId for json path) as 'Team',(select COUNT(wo.Id) 
	from TeamLocation as tl join Location as l on tl.LocationID = l.Id
							join WorkOrder as wo on tl.Id = wo.TeamLocationID
	where tl.LocationID = @locationId) as 'WorkOrderQuantity',(select distinct tl.Id,tl.TeamID
																from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID
																where tl.LocationID = @locationId for json path) as 'TeamWithWorkOrdering'
	from [Location] as l
	where l.Id = @locationId for json path


	 
	
	

	--toi can biet duoc o 1 vi tri location do thi team nao cua bao nhiu workorder
		





	

	

END
GO
