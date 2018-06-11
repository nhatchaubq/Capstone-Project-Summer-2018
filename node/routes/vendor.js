var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT * From [Vendor] for json path")
        .into(response);
});
module.exports = router;