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
/****** Object:  StoredProcedure [dbo].[GetEquipments]    Script Date: 6/26/2018 2:34:20 PM ******/
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
         e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn', u.[Name] as [Equipment.Unit],
         e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', 
         v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', 
         ec.Name as 'Equipment.Category.Name', (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity],
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], 
		 (select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId != 1) as [Equipment.NotAvailableQuantity], 
		 (select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems]
     FROM [Equipment] as e 
				 JOIN [Vendor] as v ON e.VendorID = v.Id 
				 JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id
				 join Unit as u on e.UnitID = u.Id
	for json path
END
GO
