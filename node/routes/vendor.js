var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request.sql(
    "SELECT *, " +
    "json_query((select count(*) as [Quantity]   " +
    "from Equipment as e    " +
    "Join EquipmentItem as ei ON ei.EquipmentID =e.Id " +
    "where e.VendorID = v.Id for json path, without_array_wrapper)) as [Vendor.Quantityitems]     " +
    "FROM [Vendor] as v " +
    "for json path ").into(response);
});
// router.get("/", (request, response) => {
//   request
//     .sql("exec [dbo].[GetallVendor(22/06)] ")

//     .into(response);
// });

router.get("/:id", (request, response) => {
  request
    .sql("	select v.*, " +
      "json_query((SELECT * FROM [Equipment] WHERE Equipment.VendorID = @id for json path))as [Equipments], " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy xây dựng') for json path))as [EMayXayDung], " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy cơ khí') for json path))as [EMayCoKhi], " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy hàn') for json path))as [EMayHan],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy nén khí') for json path))as [EMayNenKhi],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy bơm') for json path))as [EMayBom],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Máy FAX') for json path))as [EMayFax],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Crane') for json path))as [ECrane],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Excavator') for json path))as [EExcavator],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Forklift') for json path))as [EForklift],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Dụng cụ đo') for json path))as [EDungCuDo],   " +
      "json_query((SELECT e.* FROM [Equipment] as e JOIN [EquipmentCategory] as ec ON ec.Id =e.CategoryID  WHERE e.VendorID = @id and ec.Id = (SELECT ec.Id FROM [EquipmentCategory] as ec WHERE ec.Name = N'Dụng cụ điện') for json path))as [EDungCuDien],  	 " +
      "json_query((select count(*) as [Quantity]   " +
      "from Equipment as e    " +
      "where e.VendorID = v.Id for json path, without_array_wrapper)) as [Equipment], " +
      "json_query((select count(*) as [Quantity]   " +
      "from Equipment as e    " +
      "Join EquipmentItem as ei ON ei.EquipmentID =e.Id " +
      "where e.VendorID = v.Id for json path, without_array_wrapper)) as [EquipmentItems]     " +
      "FROM [Vendor] as v  " +
      "WHERE v.Id = @id " +
      "for json path, without_array_wrapper "

    )
    .param("id", request.params.id, TYPES.Int)
    .into(response);
});

router.post("/", (request, response) => {
  request
    .sql(
      "INSERT INTO [Vendor](BusinessName, BusinessAddress, Website, ContactName, ContactEmail, Description) VALUES(@BusinessName, @BusinessAddress, @Website, @ContactName, @ContactEmail, @Description)"
    )
    .param("BusinessName", request.body.Vendor.BusinessName, TYPES.NVarChar)
    .param(
      "BusinessAddress",
      request.body.Vendor.BusinessAddress,
      TYPES.NVarChar
    )
    .param("Website", request.body.Vendor.Website, TYPES.NVarChar)
    .param("ContactName", request.body.Vendor.ContactName, TYPES.NVarChar)
    .param("ContactEmail", request.body.Vendor.ContactEmail, TYPES.NVarChar)
    .param("Description", request.body.Vendor.Description, TYPES.NVarChar)
    .exec(response);
});
router.post("/vendorName/", (request, response) => {
  request
    .sql(
      "INSERT INTO [Vendor](BusinessName) VALUES(@businessName)"
    )
    .param("BusinessName", request.body.businessName, TYPES.NVarChar)
    .exec(response);
});
router.put("/:id", (request, response) => {
  request
    .sql(
      "update [Vendor] set BusinessName = @BusinessName, BusinessAddress = @BusinessAddress, Website = @Website, ContactName = @ContactName, ContactEmail = @ContactEmail, Description =@Description  where Id = @id"
    )
    .param("id", request.params.id, TYPES.Int)
    .param("BusinessName", request.body.Vendor.BusinessName, TYPES.NVarChar)
    .param(
      "BusinessAddress",
      request.body.Vendor.BusinessAddress,
      TYPES.NVarChar
    )
    .param("Website", request.body.Vendor.Website, TYPES.NVarChar)
    .param("ContactName", request.body.Vendor.ContactName, TYPES.NVarChar)
    .param("ContactEmail", request.body.Vendor.ContactEmail, TYPES.NVarChar)
    .param("Description", request.body.Vendor.Description, TYPES.NVarChar)
    .exec(response);
});
router.put("/edit/id");
module.exports = router;