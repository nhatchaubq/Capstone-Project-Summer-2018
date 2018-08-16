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
    "ORDER BY v.Status DESC, v.BusinessName ASC " +
    "for json path ").into(response);
});
// router.get("/", (request, response) => {
//   request
//     .sql("exec [dbo].[GetallVendor(22/06)] ")

//     .into(response);
// });


router.get("/search/:value", function (request, response) {
  request
    .sql(
      "SELECT distinct v.* FROM [Vendor] as v " +
      "WHERE v.BusinessName like N'%' + @searchText + '%' or v.BusinessAddress like N'%' + @searchText + '%' or v.ContactEmail like N'%' + @searchText + '%' or v.ContactName like N'%' + @searchText + '%'  or v.Description like N'%' + @searchText + '%' or v.Website like N'%' + @searchText + '%' " +
      "ORDER BY v.BusinessName DESC " +
      "for json path "
    )
    // .param("id", request.params.id, TYPES.Int)
    .param("searchText", request.params.value, TYPES.NVarChar)
    .into(response);
});

router.get("/:id", (request, response) => {
  request
    .sql(
      "select v.*,  " +
      "json_query((SELECT e.*,ec.Name as 'ecName' FROM [Equipment] as e " +
      "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
      "WHERE e.VendorID = @id " +
      "ORDER BY e.Name ASC " +
      "for json path))as [Equipments],   " +
      "json_query((select count(*) as [Quantity]     " +
      "from Equipment as e      " +
      "where e.VendorID = v.Id for json path, without_array_wrapper)) as [Equipment],   " +
      "json_query((select count(*) as [Quantity]     " +
      "from Equipment as e      " +
      "Join EquipmentItem as ei ON ei.EquipmentID =e.Id   " +
      "where e.VendorID = v.Id " +
      "for json path, without_array_wrapper)) as [EquipmentItems]       " +
      "FROM [Vendor] as v    " +
      "WHERE v.Id = @id   " +
      "for json path, without_array_wrapper "

    )
    .param("id", request.params.id, TYPES.Int)
    .into(response);
});

router.post("/", (request, response) => {
  request
    .sql(
      "INSERT INTO [Vendor](BusinessName, BusinessAddress, Website, ContactName, ContactEmail, Description, Status, Phone ) VALUES(@BusinessName, @BusinessAddress, @Website, @ContactName, @ContactEmail, @Description, 'True', @Phone )"
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
    // .param("Status", request.body.Vendor.Status, TYPES.NVarChar)
    .param("Phone", request.body.Vendor.Phone, TYPES.NVarChar)
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
      "update [Vendor] set BusinessName = @BusinessName, BusinessAddress = @BusinessAddress, Website = @Website, ContactName = @ContactName, ContactEmail = @ContactEmail, Description =@Description, Phone = @Phone, Status = @Status  where Id = @id"
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
    .param("Phone", request.body.Vendor.Phone, TYPES.NVarChar)
    .param("Status", request.body.Vendor.Status, TYPES.NVarChar)
    .exec(response);
});
router.put("/edit/id");
module.exports = router;