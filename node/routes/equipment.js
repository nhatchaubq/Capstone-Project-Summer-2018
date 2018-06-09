var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', e.Price as 'Equipment.Price', " +
            "e.MadeIn as 'Equipment.MadeIn', e.Image as 'Equipment.Image', e.Weight as 'Equipment.Weight', " +
            "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', " +
            "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', " +
            "ec.Name as 'Equipment.Category.Name' " +
            "FROM [Equipment] as e " +
            "JOIN [Vendor] as v ON e.VendorID = v.Id " +
            "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
            "ORDER BY e.Price DESC for json path")
        .into(response);
});

/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("insert into [Equipment](Name, VendorID, ImportDate, Image, Price, Description, CategoryID)" +
            " values(@name, @vendorID, @importDate, @image, @price, @description, @categoryID)")
        .param('name', request.body.name, TYPES.NVarChar)
        .param('vendorID', request.body.vendorID, TYPES.Int)
        .param('importDate', request.body.importDate, TYPES.DateTime)
        .param('image', request.body.image, TYPES.NVarChar)
        .param('price', request.body.price, TYPES.Float)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('categoryID', request.body.categoryID, TYPES.Int)
        .exec(response);
});


module.exports = router;