USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[CreateLocation]    Script Date: 6/25/2018 3:28:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateLocation] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(250),
	@address nvarchar(250),
	@description nvarchar(250),
	@longtitude float,
	@latitude float


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [Location]([Name],[Address],[Description],Longitude,Latitude)
         values(@name, @address, @description, @longtitude, @latitude)
	select(select SCOPE_IDENTITY()) as [NewLocationId] for json path, without_array_wrapper
END
GO
