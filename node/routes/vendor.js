var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request.sql("SELECT * From [Vendor] for json path").into(response);
});
// router.get("/", (request, response) => {
//   request
//     .sql("exec [dbo].[GetallVendor(22/06)] ")

//     .into(response);
// });
router.get("/:id", (request, response) => {
  request
    .sql("exec [dbo].[GetVendorDetails(22/06)] @id")
    .param("id", request.params.id, TYPES.Int)
    .into(response);
});

router.post("/", (request, response) => {
  console.log(request);
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
