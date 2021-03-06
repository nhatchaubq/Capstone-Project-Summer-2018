USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[CloseOrCancelWorkOrderByWoId]    Script Date: 6/27/2018 4:35:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CloseOrCancelWorkOrderByWoId]
	-- Add the parameters for the stored procedure here
	@workOrderId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update EquipmentItem set StatusId = 1 
	where Id in (select ei.Id
	from EquipmentItem as ei join WorkOrderDetail wd on ei.Id = wd.EquipmentItemID
	where wd.WorkOrderID = @workOrderId and (ei.StatusId != 3 and ei.StatusId != 1 and ei.StatusId != 4))
END
GO
