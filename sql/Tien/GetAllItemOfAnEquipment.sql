USE [EquipmentManageSystem]
GO

/****** Object:  StoredProcedure [dbo].[GetAllItemOfAnEquipment]    Script Date: 6/26/2018 10:03:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllItemOfAnEquipment] 
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ei.ID, ei.EquipmentID, ei.SerialNumber, ei.Price,CONVERT(date, ImportDate) as [ImportDate],
	ei.WarrantyDuration, ei.RuntimeDays, es.Name as Status, ei.Description
	From EquipmentItem as ei
	JOIN EquipmentStatus as es ON ei.StatusId = es.Id 
	Where ei.EquipmentID = @id
	for json path
END



GO

