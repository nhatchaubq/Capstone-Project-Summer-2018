USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetAccountDetailByAccId]    Script Date: 7/7/2018 1:04:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAccountDetailByAccId]
	-- Add the parameters for the stored procedure here
	@accId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select acc.* , json_query((select * from [Role] where Id = acc.RoleID for json path, without_array_wrapper)) as [SystemRole],
			(select t.*, json_query((select * 
									 from TeamRoles 
									 where Id = (select TeamRoleID 
												 from TeamAccount 
												 where TeamID = t.Id and AccountID = @accId) for json path, without_array_wrapper)) as [TeamRole]
			from Team as t
			where Id in (select TeamId from TeamAccount where AccountID = @accId) for json path) as [Teams]
	from Account as acc where acc.Id = @accId
	for json path, without_array_wrapper
END
GO
