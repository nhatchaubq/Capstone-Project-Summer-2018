USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentOverviewForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentOverviewForReport]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select e.Id,e.Name,e.MadeIn,e.CategoryID,v.BusinessName as 'Vendor',ec.Name as 'Category',ei.Quantity,json_query((select tmpEi.*,e.[Name],e.[Image],ec.[Name] as Category,tmpEs.[Name] as 'Status'
																								from EquipmentItem as tmpEi  join EquipmentStatus as tmpEs on tmpEi.StatusId = tmpEs.Id
																								where tmpEi.EquipmentID = e.Id for json path)) as 'Detail'
	from Equipment as e join Vendor as v on e.VendorID = v.Id
						join EquipmentCategory as ec on e.CategoryID = ec.Id
						join (select e.Id,count(*) as 'Quantity' 
						from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID
						group by e.Id) as ei on e.Id = ei.Id 
	for json path		
					 
END
GO
