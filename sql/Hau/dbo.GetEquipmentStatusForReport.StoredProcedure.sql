USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetEquipmentStatusForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEquipmentStatusForReport] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select e.Id,e.Name,v.BusinessName as 'Vendor',e.MadeIn,ec.[Name] as 'Category',ei.Quantity
	--from Equipment as e join Vendor as v on e.VendorID = v.Id
					--join EquipmentCategory as ec on e.CategoryID = ec.Id
					--join (SELECT EquipmentID,COUNT(EquipmentID)  as 'Quantity'
						--from EquipmentItem
						--group by EquipmentID) as ei on e.Id = ei.EquipmentID 
	--for json path

	select distinct e.Id,e.[Name],e.MadeIn,e.[Description],
									json_query((select COUNT(*) as [Quantity],json_query((
										select  ei.*,e.[Name],e.[Image],e.MadeIn
									  from EquipmentItem as ei 
									  where EquipmentID = e.Id and StatusId = 5 
									  for json path)) as 'Detail'
												  from EquipmentItem
												  where EquipmentID = e.Id and StatusId = 5
												  for json path, without_array_wrapper)) as [DAMAGED],
									  
										json_query((select COUNT(*) as [Quantity],json_query((
										select  ei.*,e.[Name],e.[Image],e.MadeIn
									  from EquipmentItem as ei 
									  where EquipmentID = e.Id and StatusId = 7 
									  for json path)) as 'Detail'
															  from EquipmentItem
															  where EquipmentID = e.Id and StatusId = 7
															  for json path, without_array_wrapper)) as [LOST],
										json_query((select COUNT(*) as [Quantity],json_query((
										select  ei.*,e.[Name],e.[Image],e.MadeIn
									  from EquipmentItem as ei 
									  where EquipmentID = e.Id and StatusId = 8
									  for json path)) as 'Detail'
															  from EquipmentItem
															  where EquipmentID = e.Id and StatusId = 8
															  for json path, without_array_wrapper)) as [ARCHIVE]

	from EquipmentItem as ei join Equipment as e on e.Id = ei.EquipmentID
	where StatusId = 8 or StatusId = 7 or StatusId =5 										
	for json path


	 --json_query((select COUNT(*) as [Quantity],json_query((
		--								select  ei.*,e.[Name],e.[Image],e.MadeIn
			--						  from EquipmentItem as ei 
				--					  where EquipmentID = e.Id and StatusId = 1 
					--				  for json path)) as 'Detail'
						--	  from EquipmentItem
							--  where EquipmentID = e.Id and StatusId = 1
							  --for json path, without_array_wrapper)) as [AVAILABLE],
						--json_query((select COUNT(*) as [Quantity],json_query((
							--			select  ei.*,e.[Name],e.[Image],e.MadeIn
							--		  from EquipmentItem as ei 
							--		  where EquipmentID = e.Id and StatusId = 2 
							--		  for json path)) as 'Detail'
							--		  from EquipmentItem
							--		  where EquipmentID = e.Id and StatusId = 2
							--		  for json path, without_array_wrapper)) as [WORKINGREQUESTING],
							--json_query((select COUNT(*) as [Quantity],json_query((
							--			select  ei.*,e.[Name],e.[Image],e.MadeIn
						--			  from EquipmentItem as ei 
							--		  where EquipmentID = e.Id and StatusId = 3 
							--		  for json path)) as 'Detail'
							--			  from EquipmentItem
							--			  where EquipmentID = e.Id and StatusId = 3
							--			  for json path, without_array_wrapper)) as [MAINTAINANCEREQUESTING],
							--	json_query((select COUNT(*) as [Quantity],json_query((
							--			select  ei.*,e.[Name],e.[Image],e.MadeIn
							--		  from EquipmentItem as ei 
							--		  where EquipmentID = e.Id and StatusId = 4 
							--		  for json path)) as 'Detail'
							--				  from EquipmentItem
							--				  where EquipmentID = e.Id and StatusId = 4
							--				  for json path, without_array_wrapper)) as [WORKING],
							--json_query((select COUNT(*) as [Quantity],json_query((
							--		  select  ei.*,e.[Name],e.[Image],e.MadeIn
							--		  from EquipmentItem as ei 
							--		  where EquipmentID = e.Id and StatusId = 6 
							--		  for json path)) as 'Detail'
							--						  from EquipmentItem
							--						  where EquipmentID = e.Id and StatusId = 6
													  --for json path, without_array_wrapper)) as [MAINTAINING],
END
GO
