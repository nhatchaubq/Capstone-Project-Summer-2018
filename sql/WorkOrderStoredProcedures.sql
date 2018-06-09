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
/****** Object:  StoredProcedure [dbo].[CountWorkOrderByStatusId]    Script Date: 6/6/2018 7:00:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CountWorkOrderByStatusId]
	-- Add the parameters for the stored procedure here
	@statusid int
AS
BEGIN
    -- Insert statements for procedure here
	select count(*)
	from WorkOrder as wo
	where wo.StatusID = @statusid
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByAccName]    Script Date: 6/6/2018 7:00:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByAccName]
	-- Add the parameters for the stored procedure here
	@accname nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select wo.*, acc.Id as 'Acc Id', acc.Fullname
	from WorkOrder as wo, (select * from Account where Fullname like '%' + @accname + '%') acc
	where  wo.RequestUserID = acc.Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByProjectName]    Script Date: 6/6/2018 7:00:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByProjectName]
	-- Add the parameters for the stored procedure here
	@projectName nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select wo.*, p.Id as 'Project Id', p.[Name] as 'Project Name'
	from WorkOrder as wo, (select * from Project where [Name] like '%' + @projectName + '%') as p
	where wo.ProjectId = p.Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByStatusId]    Script Date: 6/6/2018 7:00:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByStatusId]
	-- Add the parameters for the stored procedure here
	@statusid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from WorkOrder as wo where wo.StatusID = @statusid
END
GO
/****** Object:  StoredProcedure [dbo].[GetWorkOrderByWorkOrderCategory]    Script Date: 6/6/2018 7:00:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkOrderByWorkOrderCategory]
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select *
	from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID
	where wo.CategoryID = @categoryId
END
GO
