/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetTeamDetailsByTeamId]    Script Date: 6/22/2018 4:01:37 PM ******/
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
	@teamId int
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
SELECT t.id as 'Team.Id', t.Name as 'Team.Name', t.CreatedDate as 'Team.CreatedDate',
			(select acc.*, tr.[TeamRole] as [TeamRole]
			from Account as acc join TeamAccount as ta on acc.Id = ta.AccountID
								JOIN [TeamRoles] as tr ON ta.TeamRoleID = tr.Id
			where ta.TeamID = t.Id for json path) as [Team.Accounts]
FROM [Team] as t				
WHERE t.Id = @teamId
for json path, without_array_wrapper
END
GO
