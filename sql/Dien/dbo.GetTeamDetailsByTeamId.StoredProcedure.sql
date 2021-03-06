USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetTeamDetailsByTeamId]    Script Date: 7/7/2018 1:04:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamDetailsByTeamId]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--SELECT t.id as 'Team.Id', t.Name as 'Team.Name', t.CreatedDate as 'Team.CreatedDate',
--			acc.Fullname as 'Account.FullName', tr.TeamRole as 'TeamRole.Name'
--		FROM [Team] as t	
--					JOIN [TeamAccount] as ta ON t.Id = ta.TeamID
--					JOIN [Account] as acc ON ta.AccountID =acc.Id
--					JOIN [TeamRoles] as tr ON ta.TeamRoleID =tr.Id
--			WHERE t.Id = @teamId
--			for json path
SELECT t.id as 'team.Id', t.Name as 'team.Name', t.CreatedDate as 'team.CreatedDate',
			json_query((SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID=@Id and ta.TeamRoleID =1 for json path, without_array_wrapper)) as 'team.LeaderAccount',
			(SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID=@Id and ta.TeamRoleID =2 for json path) as 'team.MemberAccounts'
FROM [Team] as t				
WHERE t.Id = @Id
for json path, without_array_wrapper
END
GO
