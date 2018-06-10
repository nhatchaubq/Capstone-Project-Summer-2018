var router = require("express").Router();
var TYPES = require("tedious").TYPES;

<<<<<<< HEAD
router.get('/', (request, response) => {
    request.sql("SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', e.Price as 'Equipment.Price', " 
        + "e.ImportDate as 'Equipment.ImportDate', e.Image  as 'Equipment.Image', "
        + "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', "
        + "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', "
        + "ec.Name as 'Equipment.Category.Name' " 
        + "FROM [Equipment] as e " 
        + "JOIN [Vendor] as v ON e.VendorID = v.Id " 
        + "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id "
        + "ORDER BY e.ImportDate DESC for json path")
        .into(response);
}),
/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("INSERT INTO Equipment (Name, VendorID, ImportDate, Image, Price, Description, CategoryID)" +
        " VALUES (@name, @vendorID, @importDate, @image, @price, @description, @categoryID)")
        .param('name', request.body.name, TYPES.NVarChar)
        .param('vendorID', request.body.vendorID, TYPES.Int)
        .param('importDate', request.body.importDate, TYPES.DateTime)
        .param('image', request.body.image, TYPES.NVarChar)
        .param('price', request.body.price, TYPES.Float)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('categoryID', request.body.categoryID, TYPES.Int)
        .exec(response);
});

=======
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
>>>>>>> aea2dc7c216354b61d9d76a6e7adab53e33f5c0a

module.exports = router;
