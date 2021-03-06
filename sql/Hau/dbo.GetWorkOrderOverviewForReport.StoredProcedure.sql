USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderOverviewForReport]    Script Date: 7/8/2018 2:32:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderOverviewForReport] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select w.Id,w.Name,w.CreateDate,w.DueDate,w.Description,w.ClosedDate,a.Fullname,ws.Name as 'Status',wc.Name as 'Category',p.Name as 'Priority',t.Name as 'Team',l.Name as 'Location'
	from WorkOrder as w join WorkOrderStatus as ws on w.StatusID = ws.Id						
						join WorkOrderCategory as wc on w.CategoryID = wc.Id						
						join Account as a on w.RequestUserID = a.Id
						join [Priority] as p on w.PriorityID = p.Id
						join TeamLocation as tl on w.TeamLocationID = tl.Id
						join Team as t on t.Id = tl.TeamID
						join [Location]  as l on tl.LocationID = l.Id
	where w.ClosedDate IS NULL
	for json path
	

	
END
GO
