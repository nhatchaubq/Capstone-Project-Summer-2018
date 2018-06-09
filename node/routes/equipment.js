var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', e.Price as 'Equipment.Price', " +
        "e.ImportDate as 'Equipment.ImportDate', e.Image  as 'Equipment.Image', " +
        "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', " +
        "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', " +
        "ec.Name as 'Equipment.Category.Name' " +
        "FROM [Equipment] as e " +
        "JOIN [Vendor] as v ON e.VendorID = v.Id " +
        "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
        "ORDER BY e.ImportDate DESC for json path"
    )
    .into(response);
});

module.exports = router;
