var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get('/', (request, response) => {
    request.sql("exec GetEquipments")
        .into(response);
});
/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("INSERT INTO Equipment (Name, VendorID, Image, Price, MadeIn, Description, CategoryID)" +
            " VALUES (@name, @vendorID, @image, @price, @madein, @description, @categoryID)")
        .param('name', request.body.name, TYPES.NVarChar)
        .param('vendorID', request.body.vendorID, TYPES.Int)
        .param('image', request.body.image, TYPES.NVarChar)
        .param('price', request.body.price, TYPES.Float)
        .param('madein', request.body.madein, TYPES.NVarChar)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('categoryID', request.body.categoryID, TYPES.Int)
        .exec(response);
});

module.exports = router;