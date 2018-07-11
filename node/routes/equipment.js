var router = require("express").Router();
var TYPES = require("tedious").TYPES;

// router.get("/", (request, response) => {
//   request.sql("exec GetEquipments").into(response);
// });
/*Get ALL EQT*/
router.get("/", (request, response) => {
  request.sql("SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', " +
    "e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn', " +
    "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', " +
    "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', " +
    "u.[Name] as [Equipment.Unit], " +
    "ec.Name as 'Equipment.Category.Name', (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity], " +
    "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], " +
    "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 2) as [Equipment.NotAvailableQuantity], " +
    "(select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems] " +
    "FROM [Equipment] as e " +
    "JOIN [Vendor] as v ON e.VendorID = v.Id " +
    "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
    "JOIN [Unit] as u on e.UnitID = u.Id " +
    "for json path").into(response);
});
/*GET an Eqt by ID*/
router.get("/:id", (request, response) => {
  request
  request.sql("SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', " +
      "e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn', " +
      "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', " +
      "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId',  " +
      "ec.Name as 'Equipment.Category.Name', e.UnitID as 'Equipment.UnitID', unit.Name as 'Equipment.Unit.Name' , (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 2) as [Equipment.NotAvailableQuantity], " +
      "(select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems] " +
      "FROM [Equipment] as e " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
      "JOIN [Unit] as unit ON e.UnitID = unit.Id " +
      "where e.Id = @id " +
      "for json path")
    .param("id", request.params.id, TYPES.Int)
    .into(response);
});

// /*Get Equipment BY ID*/
// router.get("/:id", (request, response) => {
//   request
//     .sql("exec GetEquipmentByID @id")
//     .param("id", request.params.id, TYPES.Int)
//     .into(response);
// });

/* GET request, get EquipmentByName */
router.get("/byName/:equipmentName", function (request, response) {
  request
    .sql(
      "SELECT * from Equipment where Name = @equipmentName for json path, without_array_wrapper"
    )
    .param("equipmentName", request.params.equipmentName, TYPES.NVarChar)
    .into(response);
});
/* GET request, get EquipmentByName and vendorName */
router.get("/:equipmentId/:vendorId", function (request, response) {
  request
    .sql(
      "SELECT count(e.Id) as [Quantity] " +
      "FROM [Equipment] as e " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "where e.Id = @equipmentId and v.Id = @vendorId for json path, without_array_wrapper"
    )
    .param("equipmentId", request.params.equipmentId, TYPES.Int)
    .param("vendorId", request.params.vendorId, TYPES.Int)
    .into(response);
});
/* POST request, for insert */
router.post("/", (request, response) => {
  request
    .sql(
      "INSERT INTO Equipment (Name, VendorID, Image, MadeIn, Description, CategoryID, UnitID)" +
      " VALUES (@name, @vendorID, @image, @madein, @description, @categoryID, @unitID)"
    )
    .param("name", request.body.name, TYPES.NVarChar)
    .param("vendorID", request.body.vendorID, TYPES.Int)
    .param("image", request.body.image, TYPES.NVarChar)
    .param("madein", request.body.madein, TYPES.NVarChar)
    .param("description", request.body.description, TYPES.NVarChar)
    .param("categoryID", request.body.categoryID, TYPES.Int)
    .param("unitID", request.body.unitID, TYPES.Int)
    .exec(response);
});

/* PUT request, for update an Equipment */
router.put("/:id", function (request, response) {
  request
    .sql(
      "UPDATE [Equipment] set Name = @name, VendorID = @vendorid, Image=@image, MadeIn=@madein, Description=@description, CategoryID=@categoryid where Id = @id"
    )
    .param("id", request.params.id, TYPES.Int)
    .param("name", request.body.name, TYPES.NVarChar)
    .param("vendorid", request.body.vendorid, TYPES.Int)
    .param("image", request.body.image, TYPES.NVarChar)
    .param("madein", request.body.madein, TYPES.NVarChar)
    .param("categoryid", request.body.categoryid, TYPES.Int)
    .param("description", request.body.description, TYPES.NVarChar)
    .exec(response);
});



module.exports = router;