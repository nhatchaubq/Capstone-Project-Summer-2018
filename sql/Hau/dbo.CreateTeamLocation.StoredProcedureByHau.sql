USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[CreateTeamLocation]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateTeamLocation]
	-- Add the parameters for the stored procedure here
	@locationId int,
	@teamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [TeamLocation](LocationID,TeamID,StartDate,OutDate) 
				values(@locationId,@teamId,GETDATE(),NULL)
END
GO
