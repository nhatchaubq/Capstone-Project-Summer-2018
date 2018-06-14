var router = require("express").Router();
var TYPES = require("tedious").TYPES;

// router.get('/', (request, response) => {
//     request.sql("exec GetEquipments")
//         .into(response);
// });

/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("INSERT INTO EquipmentItem (EquipmentID, SerialNumber, WarrantyDuration, ImportDate, StatusId, Description, PositionID)" +
            " VALUES (@equipmentID, @serialNumber, @warrantyDuration, @importDate, @statusId, @description, @positionID)")
        .param('name', request.body.name, TYPES.NVarChar)
        .param('serialNumber', request.body.vendorID, TYPES.NVarChar)
        .param('warrantyDuration', request.body.image, TYPES.NVarChar)
        .param('importDate', request.body.price, TYPES.DateTime)
        .param('statusId', request.body.price, TYPES.Int)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('positionID', request.body.categoryID, TYPES.Int)
        .exec(response);
});

    router.get('/:id/getByLocationId',(request,response) => {
        request.sql("select eqti.*,eqt.Name,eqt.Image from [EquipmentItem] as eqti join [Position] as pos on eqti.PositionID = pos.Id "+
        "join [Equipment] as eqt on eqti.EquipmentID = eqt.ID "+
        "where pos.LocationID = @locationId for json path")
        .param('locationId',request.params.id,TYPES.Int)
        .into(response);
    })

    router.get('/getByEquipmentId/:id',(request,response) => {
        request.sql("exec [dbo].[GetEquipmentItemByEquipmentIdAndLocationId] @locationId")
           .param('locationId',request.params.id, TYPES.Int)
           .into(response)
    })

module.exports = router;