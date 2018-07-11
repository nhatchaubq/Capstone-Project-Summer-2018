var router = require('express').Router();
var TYPES = require('tedious').TYPES;
router.get('/', (request, response) => {
    request.sql("SELECT * From [Unit] for json path")
        .into(response);
});

router.post('/', (request, response) => {
    request.sql("INSERT INTO Unit (Name) VALUES (@name)")
        .param('name', request.body.name, TYPES.NVarChar)
        .exec(response);
});
module.exports = router;