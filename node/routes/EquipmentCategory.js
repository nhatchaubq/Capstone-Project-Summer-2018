var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT * From [EquipmentCategory] for json path")
        .into(response);
});

router.post('/', (request, response) => {
    request.sql("INSERT INTO EquipmentCategory (Name, Description) VALUES (@name, @description)")
        .param('name', request.body.EquipmentCate.Name, TYPES.NVarChar)
        .param('description', request.body.EquipmentCate.Description, TYPES.NVarChar)
        .exec(response);
});
module.exports = router;