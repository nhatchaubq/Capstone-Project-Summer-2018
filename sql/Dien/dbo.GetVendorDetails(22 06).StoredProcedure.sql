USE [EquipmentManageSystem]
GO
/****** Object:  StoredProcedure [dbo].[GetVendorDetails(22/06)]    Script Date: 6/30/2018 6:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetVendorDetails(22/06)]
	-- Add the parameters for the stored procedure here
		@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT v.BusinessName as 'Vendor.BusinessName',v.BusinessAddress as 'Vendor.BusinessAddress', v.ContactName as 'Vendor.ContactName', v.ContactEmail as 'vendor.ContactEmail', v.Description as 'vendor.Description' 
	--FROM [Vendor] as v 
	--WHERE v.Id = @id
	--for json path, without_array_wrapper
	select v.*
	FROM [Vendor] as v 
	WHERE v.Id = @id
	for json path, without_array_wrapper
	
END
GO
