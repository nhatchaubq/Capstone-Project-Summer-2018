var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT * From [Vendor] for json path")
        .into(response);
});
router.get('/1', (request, response) => {
    request.sql("exec [dbo].[GetallVendor(22/06)] ")

        .into(response);
});
router.get('/:id', (request, response) => {
    request.sql("exec [dbo].[GetVendorDetails(22/06)] @id")
        .param('id', request.params.id, TYPES.Int)
        .into(response);
});

router.post('/', (request, response) => {
    request.sql("INSERT INTO Vendor (BusinessName) VALUES (@businessName)")
        .param('businessName', request.body.businessName, TYPES.NVarChar)
        .exec(response);
});
module.exports = router;