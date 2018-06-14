USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipments]    Script Date: 6/14/2018 1:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipments]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', e.Price as 'Equipment.Price', 
         e.Image  as 'Equipment.Image', 
         e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', 
         v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', 
         ec.Name as 'Equipment.Category.Name', ei.SerialNumber as 'Equipment.SerialNumber'
     FROM [Equipment] as e 
				 JOIN [Vendor] as v ON e.VendorID = v.Id 
				 JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id
				 JOIN [EquipmentItem] as ei ON e.Id = ei.EquipmentID
	for json path
END
GO
