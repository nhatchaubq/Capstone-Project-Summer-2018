var router = require("express").Router();
var TYPES = require("tedious").TYPES;

// router.get('/', (request, response) => {
//     request.sql("exec GetEquipments")
//         .into(response);
// });

router.get('/chau/:id', (req, res) => {
    req.sql('exec GetEquipmentDetailById @id')
        .param('id', req.params.id, TYPES.Int)
        .into(res);
});
/*Count Quality Equipment Item of one Equipment*/
// router.get('/:id', (req, res) => {
//     req.sql('exec CountQualityItem @id')
//         .param('id', req.params.id, TYPES.Int)
//         .into(res);
// });

/* Get all Item of an equipment by EquipmentID */
router.get('/:id', (req, res) => {
    req.sql('exec GetAllItemOfAnEquipment @id')
        .param('id', req.params.id, TYPES.Int)
        .into(res);
});
/* GET AN ITEM of an Equipment */
router.get('/Item/:id', (request, response) => {
    request.sql("exec GetAnItem @id")
        .param('id', request.params.id, TYPES.Int)
        .into(response)
})
/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("INSERT INTO EquipmentItem (EquipmentID, SerialNumber, WarrantyDuration, RuntimeDays, Price, ImportDate, StatusId, Description, TileID)" +
            " VALUES (@equipmentID, @serialNumber, @warrantyDuration, 0, @price, GETDATE(), @statusId, @description, @tileID)")
        .param('equipmentID', request.body.equipmentID, TYPES.Int)
        .param('serialNumber', request.body.serialNumber, TYPES.NVarChar)
        .param('warrantyDuration', request.body.warrantyDuration, TYPES.Int)
        .param('price', request.body.price, TYPES.Float)
        //.param('importDate', request.body.importDate, TYPES.DateTime)
        .param('statusId', request.body.statusId, TYPES.Int)
        .param('description', request.body.description, TYPES.NVarChar)
        .param('tileID', request.body.tileID, TYPES.Int)
        .exec(response);
});

router.get('/:id/getByLocationId', (request, response) => {
    request.sql("select eqti.*,eqt.Name,eqt.Image from [EquipmentItem] as eqti join [Position] as pos on eqti.PositionID = pos.Id " +
            "join [Equipment] as eqt on eqti.EquipmentID = eqt.ID " +
            "where pos.LocationID = @locationId for json path")
        .param('locationId', request.params.id, TYPES.Int)
        .into(response);
})

router.get('/getByEquipmentId/:id', (request, response) => {
    request.sql("exec [dbo].[GetEquipmentItemByEquipmentIdAndLocationId] @locationId")
        .param('locationId', request.params.id, TYPES.Int)
        .into(response)
})

router.put('/status/:id', (req, res) => {
    req.sql('exec [dbo].[UpdateEquipmentItemStatus] @itemId, @newStatus')
        .param(itemId, req.params.id, TYPES.Int)
        .param(newStatus, req.body.newStatus, TYPES.Int)
});

module.exports = router;