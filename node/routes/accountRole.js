var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("SELECT * From [Role] as r WHERE r.Id IN (SELECT r.Id FROM [Role] as r WHERE r.Name != N'Admin') for json path")
        .into(response);
});
module.exports = router;