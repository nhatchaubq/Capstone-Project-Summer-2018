var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT * From [Vendor] for json path")
        .into(response);
});
router.post('/', (request, response) => {
    request.sql("INSERT INTO Vendor (BusinessName) VALUES (@businessName)")
        .param('businessName', request.body.businessName, TYPES.NVarChar)
        .exec(response);
});
module.exports = router;