USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipments]    Script Date: 6/10/2018 12:05:14 PM ******/
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
	SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', 
         e.Image  as 'Equipment.Image', 
         e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', 
         v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', 
         ec.Name as 'Equipment.Category.Name' 
     FROM [Equipment] as e 
				 JOIN [Vendor] as v ON e.VendorID = v.Id 
				 JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id
	for json path
END
GO
