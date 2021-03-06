USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[ChangeLeaderToMemberAndMeToLiByAccountID]    Script Date: 7/7/2018 1:04:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangeLeaderToMemberAndMeToLiByAccountID]
	-- Add the parameters for the stored procedure here
	@id int,
	@memberID int,
    @leaderId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [TeamAccount] set TeamRoleID = 2  where TeamID=@id and AccountID =@leaderId;
	update [TeamAccount] set TeamRoleID = 1  where TeamID=@id and AccountID =@memberID;
END
GO
