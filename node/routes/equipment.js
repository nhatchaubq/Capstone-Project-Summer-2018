var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get('/', (request, response) => {
    request.sql("exec GetEquipments")
        .into(response);
});
/* GET request, get EquipmentByName */
router.get("/:equipmentName", function (request, response) {
    request
        .sql("SELECT * from [Equipment] where Name = @equipmentName for json path, without_array_wrapper")
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
router.post('/', (request, response) => {
    request.sql("INSERT INTO Equipment (Name, VendorID, Image, MadeIn, Description, CategoryID)" +
            " VALUES (@name, @vendorID, @image, @madein, @description, @categoryID)")
        .param('name', request.body.name, TYPES.NVarChar)
        .param('vendorID', request.body.vendorID, TYPES.Int)
        .param('image', request.body.image, TYPES.NVarChar)
        .param('madein', request.body.madein, TYPES.NVarChar)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('categoryID', request.body.categoryID, TYPES.Int)
        .exec(response);
});

module.exports = router;