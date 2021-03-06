USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetTeamDetails]    Script Date: 7/7/2018 1:04:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamDetails]
	-- Add the parameters for the stored procedure here
	@teamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT t.id as 'Team.Id', t.Name as 'Team.Name', t.CreatedDate as 'Team.CreatedDate',
			acc.Fullname as 'Account.FullName', tr.TeamRole as 'TeamRole.Name'
		FROM [Team] as t	
					JOIN [TeamAccount] as ta ON t.Id = ta.TeamID
					JOIN [Account] as acc ON ta.AccountID =acc.Id
					JOIN [TeamRoles] as tr ON ta.TeamRoleID =tr.Id
			WHERE acc.Id = @teamId
			for json path
END
GO
