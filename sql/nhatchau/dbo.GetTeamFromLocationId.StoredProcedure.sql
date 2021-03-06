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
/****** Object:  StoredProcedure [dbo].[GetTeamFromLocationId]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamFromLocationId]
	-- Add the parameters for the stored procedure here
	@locationId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select (json_query((select * from Team where Id = tl.TeamID for json path, without_array_wrapper))) as [Team]
	from TeamLocation as tl join Team as t on tl.TeamID = t.Id
	where tl.LocationID = @locationId
	for json path
END
GO
