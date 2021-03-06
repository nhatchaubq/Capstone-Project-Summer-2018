USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[EditLocationById]    Script Date: 6/21/2018 2:49:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditLocationById]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct l.*,(select t.Id,t.Name
						from TeamLocation as tl join Location as l on tl.LocationID = l.Id
												join Team as t on t.Id = tl.TeamID
	where tl.LocationID = @locationId for json path) as 'Team'
	from [Location] as l
	where l.Id = @locationId for json path

	

	

END
GO
