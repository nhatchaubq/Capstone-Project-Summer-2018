USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetTeamByLocation]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamByLocation] 
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.*,m.NameOfTeam,m.IdOfTeam
	from Account as a join
	(select ta.AccountID, t.Name as 'NameOfTeam',t.Id as 'IdOfTeam'
	from Team as t join TeamLocation as tl on tl.TeamID = t.Id
				   join TeamAccount as ta on ta.TeamID = t.Id
 	where tl.LocationID = @locationId and ta.TeamRoleID = 1) as m on a.Id = m.AccountID
	
	for json path

END
GO
