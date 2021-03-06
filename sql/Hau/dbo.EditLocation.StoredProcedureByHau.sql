USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[EditLocation]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditLocation] 
	-- Add the parameters for the stored procedure here
	@locationId int,
	@name nvarchar(250),
	@address nvarchar(250),
	@description nvarchar(250)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [Location] set Name = @name,Address = @address,Description = @description
	where Id = @locationId
END
GO
